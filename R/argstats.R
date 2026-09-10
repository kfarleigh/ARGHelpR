#' Calculate ancestral recombination graph summary statistics.
#'
#' @param arg.dat a list where each element is an ancestral recombiation graph represented by a data frame. The data frame columns should be chromosome, start, end, and the phylogeney estimated in ARG analysis.
#' @param pop1 a vector of individuals in one population.
#' @param pop2 a vector of individuals in the other population.
#' @param pop1.name a character string that tells us the name of population 1.
#' @param pop2.name a character string that tells us the name of population 2.
#' @param n.cores a numeric value indicating the number of cores to run. Default is 1. Anything greater than 1 will run calcualtions in parallel. WARNING increasing this number too high can crash your computer depending on your dataset.
#' @param n.haps a numeric value indicating the minimum number of haplotypes to identify a clade.
#'
#' @returns A list of elements. Each element is a data frame containing the calculated statistics, the relevant window, and relevant arg. The statistics include the time to the most recent common ancestor between populations/species (tmrca) and estimates of the time to most recent common ancestor within populations/species (tmrcaw). The output also indicates if populations/species are monophyletic and which population/species corresponds to which population.
#' @author Keaka Farleigh
#' @export
#'
#' @examples
#' \donttest{
#' Test <- argstats(arg.dat = rattlesnake_args, pop1 = pop1_inds, pop2 = pop2_inds, pop1.name = "continental", pop2.name = "stephensi")}
argstats <- function(arg.dat, pop1, pop2, pop1.name, pop2.name, n.cores = 1, n.haps = 2){

  # Detect operating system (OS)
  os <- Sys.info()[["sysname"]]


  # Use lapply if n.cores = 1, otherwise run calculations in parallel
  if(n.cores == 1){
  argstat_calcs <- lapply(arg.dat, argstats_helper, pop1 = pop1, pop2 = pop2, pop1.name = pop1.name, pop2.name = pop2.name, n.haps = n.haps)
  } else {

    # We have to run in parallel differently for different OS
    if(os == "Windows"){

      # Determine the cores
      n_cores <- n.cores

      # Make the clusters with set number of cores
      cl <- parallel::makeCluster(n_cores, type = "PSOCK")

      # Export data and functions so that we can run everything in parallel
      parallel::clusterExport(cl, c("arg.dat", "pop1", "pop2", "pop1.name", "pop2.name", "n.haps"))
      parallel::clusterEvalQ(cl, library(ARGHelpR))

      # Run it
      argstat_calcs <- parallel::parLapply(cl, X = arg.dat, fun = argstats_helper, pop1 = pop1, pop2 = pop2, pop1.name = pop1.name, pop2.name = pop2.name, n.haps = n.haps)

      # Stop the cluster to free up memory
      parallel::stopCluster(cl)
      } else {

        argstat_calcs <- parallel::mclapply(arg.dat, argstats_helper, pop1 = pop1, pop2 = pop2, pop1.name = pop1.name, pop2.name = pop2.name, n.haps = n.haps, mc.cores = n.cores, mc.silent = TRUE)

    }
  }

  remove(n_cores, cl)

  return(argstat_calcs)

}
