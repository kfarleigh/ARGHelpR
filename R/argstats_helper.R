#' Calculate ancestral recombination graph statistics
#'
#' @param arg.dat a list element that contains a dataframe. The data frame columns should be chromosome, start, end, and the phylogeney estimated in ARG analysis.
#' @param pop1 a vector of individuals in one population.
#' @param pop2 a vector of individuals in the other population.
#' @param pop1.name a character string that tells us the name of population 1.
#' @param pop2.name a character string that tells us the name of population 2.
#' @param n.haps a numeric value indicating the minimum number of haplotypes to identify a clade.
#'
#' @returns A data frame containing the calculated statistics, the relevant window, and relevant arg. The statistics include the time to the most recent common ancestor between populations/species (tmrca) and estimates of the time to most recent common ancestor within populations/species (tmrcaw). The output also indicates if populations/species are monophyletic and which population/species corresponds to which population.
#' @author Keaka Farleigh
#'
#' @examples
#' \donttest{
#' Test <- argstats(arg.dat = rattlesnake_args, pop1 = pop1_inds, pop2 = pop2_inds, pop1.name = "continental", pop2.name = "stephensi")}
argstats <- function(arg.dat, pop1, pop2, pop1.name, pop2.name, n.cores = 1, n.haps = 2){

  is.child <- n.pop1 <- n.pop2 <- NULL

  ### ToDo
  # Add parallel option

  # Function to identify clades in the data.
  identify_clade <- function(dat, pop1, pop2, tip_idx){

    prop.df <- data.frame(node = NA, prop.pop1 = NA, prop.pop2 = NA, n.ind = NA, n.pop1 = NA, n.pop2 = NA)

    pop1.inds <- pop1
    pop2.inds <- pop2

    dat <- dat

    n.pop1 <- length(which(tip_idx[dat] %in% pop1.inds))
    n.pop2 <- length(which(tip_idx[dat] %in% pop2.inds))

    prop.pop1 <- n.pop1/length(pop1.inds)
    prop.pop2 <- n.pop2/length(pop2.inds)

    n.ind <- length(dat)

    prop.df[1,2] <- prop.pop1
    prop.df[1,3] <- prop.pop2
    prop.df[1,4] <- n.ind
    prop.df[1,5] <- n.pop1
    prop.df[1,6] <- n.pop2

    remove(pop1.inds, pop2.inds, n.pop1, n.pop2, prop.pop1, prop.pop2, n.ind, dat)

    return(prop.df)


  }


  ### Create a data frame to store results
  arg.stats.df <- data.frame(chromosome = arg.dat$chromosome,
                             start = arg.dat$start, end = arg.dat$end,
                             tmrca = NA,
                             pop1.meantmrcaw = NA,
                             pop1.mediantmrcaw = NA,
                             pop1.mintmrcaw = NA,
                             pop1.maxtmrcaw = NA,
                             pop1.mono = NA,
                             pop2.meantmrcaw = NA,
                             pop2.mediantmrcaw = NA,
                             pop2.mintmrcaw = NA,
                             pop2.maxtmrcaw = NA,
                             pop2.mono = NA,
                             pop1 = pop1.name,
                             pop2 = pop2.name)

  i <- 1

  nwk <- arg.dat$tree[i]

  tree <- ape::read.tree(text = nwk)

  # Get the TMRCA for the tree
  tmrca <- max(phytools::nodeHeights(tree))

  # Get cross-coalescent events for each population/species
  pop1_dist <- phytools::findMRCA(tree, tips = pop1, type = "height")

  pop2_dist <- phytools::findMRCA(tree, tips = pop2, type = "height")

  arg.stats.df[i,4] <- tmrca

  if(ape::is.monophyletic(tree, tips= pop1)){


    # This is height from the root, which gives us the opposite of what we want; testing showed this to be equivalent to extracting a clade and working up from there
    pop1.dist.fix <- tmrca - pop1_dist

    arg.stats.df[i,5] <- pop1.dist.fix
    arg.stats.df[i,6] <- pop1.dist.fix
    arg.stats.df[i,7] <- pop1.dist.fix
    arg.stats.df[i,8] <- pop1.dist.fix
    arg.stats.df[i,9] <- TRUE

  } else {

    # Get a list of nodes and their descendants

    all_nodes <- phangorn::Descendants(tree, type = "tips")
    tip_idx <- tree$tip.label

    test <- lapply(all_nodes, identify_clade, pop1 = pop1, pop2 = pop2, tip_idx = tip_idx)

    test.df <- do.call("rbind", test)

    test.df$node <- paste(1:length(all_nodes))

    # Remove nodes with only 1 individual and filter for only nodes where there are no contiental individuals
    pop1.df.filt <- test.df %>% dplyr::filter(n.pop1 > (n.haps-1), n.pop2 == 0)

    if(nrow(pop1.df.filt) > 0){

      # Determine if nodes have a parent/child relationship
      prop.child <- data.frame(node = NA, children = NA, is.child = NA)
      for(j in 1:nrow(pop1.df.filt)){

        nodes <- pop1.df.filt[,1]

        which(nodes %in% phytools::getDescendants(tree, node = pop1.df.filt$node[j],))

        prop.child[j,1] <- pop1.df.filt$node[j]
        prop.child[j,2] <- length(which(nodes %in% phytools::getDescendants(tree, node = pop1.df.filt$node[j],)))

        if(any(phangorn::Ancestors(tree, pop1.df.filt$node[j], type = "all") %in% nodes)){

          prop.child[j,3] <- TRUE

        } else{

          prop.child[j,3] <- FALSE

        }

      }

      # Only select nodes where is.child == FALSE for calculations
      prop.child.filt <- prop.child %>% dplyr::filter(is.child == FALSE)

      # Calculate tmrca-within
      tmrca_w <- c()
      for(k in 1:nrow(prop.child.filt)){

        tips <- phytools::getDescendants(tree, node = prop.child.filt$node[k])

        pop1_dist <- phytools::findMRCA(tree, tips = tips, type = "height")
        pop1.fix <- tmrca - pop1_dist

        tmrca_w <- c(tmrca_w, pop1.fix)

        remove(tips, pop1_dist, pop1.fix)

      }

      arg.stats.df[i,5] <- mean(tmrca_w)
      arg.stats.df[i,6] <- stats::median(tmrca_w)
      arg.stats.df[i,7] <- min(tmrca_w)
      arg.stats.df[i,8] <- max(tmrca_w)
      arg.stats.df[i,9] <- FALSE

      remove(tmrca_w)

    } else{

      arg.stats.df[i,5] <- NA
      arg.stats.df[i,6] <- NA
      arg.stats.df[i,7] <- NA
      arg.stats.df[i,8] <- NA
      arg.stats.df[i,9] <- FALSE

    }

  }

  if(ape::is.monophyletic(tree, tips = pop2)){

    pop2.fix <- tmrca - pop2_dist
    arg.stats.df[i,10] <- pop2.fix
    arg.stats.df[i,11] <- pop2.fix
    arg.stats.df[i,12] <- pop2.fix
    arg.stats.df[i,13] <- pop2.fix
    arg.stats.df[i,14] <- TRUE

  } else {

    # Get a list of nodes and their descendants

    all_nodes <- phangorn::Descendants(tree, type = "tips")
    tip_idx <- tree$tip.label

    test <- lapply(all_nodes, identify_clade, pop1 = pop1, pop2 = pop2, tip_idx = tip_idx)

    test.df <- do.call("rbind", test)

    test.df$node <- paste(1:length(all_nodes))

    # Remove nodes with only 1 individual and filter for only nodes where there are no contiental individuals
    pop2.df.filt <- test.df %>% dplyr::filter(n.pop2 > (n.haps-1), n.pop1 == 0)

    if(nrow(pop2.df.filt) > 0){

      # Determine if nodes have a parent/child relationship
      prop.child <- data.frame(node = NA, children = NA, is.child = NA)
      for(l in 1:nrow(pop2.df.filt)){

        nodes <- pop2.df.filt[,1]

        which(nodes %in% phytools::getDescendants(tree, node = pop2.df.filt$node[l],))

        prop.child[l,1] <- pop2.df.filt$node[l]
        prop.child[l,2] <- length(which(nodes %in% phytools::getDescendants(tree, node = pop2.df.filt$node[l],)))

        if(any(phangorn::Ancestors(tree, pop2.df.filt$node[l], type = "all") %in% nodes)){

          prop.child[l,3] <- TRUE

        } else{

          prop.child[l,3] <- FALSE

        }

      }

      # Only select nodes where is.child == FALSE for calculations
      prop.child.filt <- prop.child %>% dplyr::filter(is.child == FALSE)

      # Calculate tmrca-within
      tmrca_w <- c()
      for(m in 1:nrow(prop.child.filt)){

        tips <- phytools::getDescendants(tree, node = prop.child.filt$node[m])

        con_dist <- phytools::findMRCA(tree, tips = tips, type = "height")
        pop2.fix <- tmrca - con_dist

        tmrca_w <- c(tmrca_w, pop2.fix)

        remove(tips, con_dist, pop2.fix)

      }

      arg.stats.df[i,10] <- mean(tmrca_w)
      arg.stats.df[i,11] <- stats::median(tmrca_w)
      arg.stats.df[i,12] <- min(tmrca_w)
      arg.stats.df[i,13] <- max(tmrca_w)
      arg.stats.df[i,14] <- FALSE

      remove(tmrca_w)


    } else{

      arg.stats.df[i,10] <- NA
      arg.stats.df[i,11] <- NA
      arg.stats.df[i,12] <- NA
      arg.stats.df[i,13] <- NA
      arg.stats.df[i,14] <- FALSE


    }

  }

  remove(tmrca, tree, nwk)

  return(arg.stats.df)

}
