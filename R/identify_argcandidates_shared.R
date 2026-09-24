#' Identify ancestral recombination graphs under selection that correspond to models of shared variation (introgression and balancing selection).
#'
#' @param dat a dataframe of ancestral recombination graph statistics calculated using the argstats function.
#' @param analysis a character vector indicating the types of args you want to identify. Options are "all" for all types, "BS" for balancing selection, "INT" for introgression, and "BSINT" for balancing selection + introgression.
#' @param background a dataframe of ancestral recombination graph statistics calculated using the argstats function. If supplied this will be used to define thresholds and the dat argument will be treated as the test set.
#' @param tmrca.high.threshold a numeric value to customize the tmrca threshold used to identify ARGs associated with balancing selection.
#' @param pop1.threshold a numeric value to customize the pop1 tmrcaw threshold used to identify ARGs associated with introgression.
#' @param pop2.threshold a numeric value to customize the pop2 tmrcaw threshold used to identify ARGs associated with introgression.
#' @param tmrca.iqr.low.threshold a numeric value to customize the lower tmrca threshold used to identify ARGs associated with introgression.
#' @param tmrca.50.threshold a numeric value to customize the tmrca.50 threshold used to identify ARGs associated with the combined balancing selection + introgression scenario.
#' @param pop1.tmrcaw.95threshold a numeric value to customize the pop1.tmrcaw.95 threshold used to identify ARGs associated with the combined balancing selection + introgression scenario.
#' @param pop2.tmrcaw.95threshold a numeric value to customize the pop2.tmrcaw.95 threshold used to identify ARGs associated with the combined balancing selection + introgression scenario.
#'
#' @returns a list containing ARGs that were identified as candidates
#' @export
#'
#' @examples
#' \donttest{
#' data("rattlesnake_argstats")
#' data("rattlesnake_pops")
#'
#' pop2 <- rattlesnake_pops[which(rattlesnake_pops$species == "pop2"),]
#' pop1 <- rattlesnake_pops[which(rattlesnake_pops$species == "pop1"),]
#'
#' stat_res <- argstats(arg.dat = rattlesnake_args, pop1 = pop1$sample, pop2 = pop2$sample, pop1.name = "pop1", pop2.name = "pop2")
#'
#' stat_df <- do.call("rbind", stat_res)
#'
#' Test <- identify_argcandidates_shared(dat = stat_df, analysis = "all")}
identify_argcandidates_shared <- function(dat, analysis = "all", background = NULL, tmrca.high.threshold = NULL, pop1.threshold = NULL, pop2.threshold = NULL, tmrca.iqr.low.threshold = NULL, tmrca.50.threshold = NULL, pop1.tmrcaw.95threshold = NULL, pop2.tmrcaw.95threshold = NULL){

  tmrca <- pop1.meantmrcaw <- pop2.meantmrcaw <- NULL

  # If there is not a user defined genomic background we will consider the entire dat argument and use that to identify candidate args, otherwise, we set thresholds based on the background argument.
  if(is.null(background)){

    if(is.null(tmrca.high.threshold)){
      # Set balancing selection thresholds
      tmrca.thresh <- stats::quantile(dat$tmrca, probs = c(0.9,0.95,1), na.rm = TRUE)[2]
    } else{
      tmrca.thresh <- tmrca.high.threshold
    }

    if(is.null(tmrca.50.threshold)){
      tmrca50.thresh <- stats::quantile(dat$tmrca, probs = c(0.5), na.rm = TRUE)[1]
    } else{
      tmrca50.thresh <- tmrca.50.threshold
    }

    # Set within-population thresholds
    if(is.null(pop1.threshold)){
      pop1.tmrcaw.thresh <- stats::quantile(dat$pop1.meantmrcaw, probs = c(0.05,0.1), na.rm = TRUE)[1]
    } else{
      pop1.tmrcaw.thresh <- pop1.threshold
    }

    if(is.null(pop1.tmrcaw.95threshold)){
      pop1.tmrcaw.95thresh <- stats::quantile(dat$pop1.meantmrcaw, probs = c(0.95), na.rm = TRUE)[1]
    } else{
      pop1.tmrcaw.95thresh <- pop1.tmrcaw.95threshold
    }

    if(is.null(pop2.threshold)){
      pop2.tmrcaw.thresh <- stats::quantile(dat$pop2.meantmrcaw, probs = c(0.05,0.1), na.rm = TRUE)[1]
    } else{
      pop2.tmrcaw.thresh <- pop2.threshold
    }

    if(is.null(pop2.tmrcaw.95threshold)){
      pop2.tmrcaw.95thresh <- stats::quantile(dat$pop2.meantmrcaw, probs = c(0.95), na.rm = TRUE)[1]
    } else{
      pop2.tmrcaw.95thresh <- pop2.tmrcaw.95threshold
    }

    if(is.null(tmrca.iqr.low.threshold)){
      tmrca.iqr.low <- stats::quantile(dat$tmrca, probs = c(0.25), na.rm = TRUE)[1]
    } else{
      tmrca.iqr.low <- tmrca.iqr.low.threshold
    }



    ### Identify args that follow different models

    if("BS" %in% analysis | analysis == "all"){
      BS_args <- dat %>% dplyr::filter(tmrca >= tmrca.thresh)
    } else{
      BS_args <- NULL
    }
    if("INT" %in% analysis | analysis == "all"){
      INT_args <- dat %>% dplyr::filter(tmrca < tmrca.iqr.low & (pop1.meantmrcaw >= pop1.tmrcaw.thresh & pop2.meantmrcaw >= pop2.tmrcaw.thresh))
    } else{
      INT_args <- NULL
    }
    if("BSINT" %in% analysis | analysis == "all"){
      BSINT_args <- dat %>% dplyr::filter((tmrca > tmrca.iqr.low & tmrca < tmrca50.thresh) &  (pop1.meantmrcaw >= pop1.tmrcaw.95thresh & pop2.meantmrcaw >= pop2.tmrcaw.95thresh))
    } else{
      BSINT_args <- NULL
    }


    Output <- list(BS_args, INT_args, BSINT_args)

    names(Output) <- c("BS", "INT","BSINT")


  } else {

    if(is.null(tmrca.high.threshold)){
      # Set balancing selection thresholds
      tmrca.thresh <- stats::quantile(dat$tmrca, probs = c(0.9,0.95,1), na.rm = TRUE)[2]
    } else{
      tmrca.thresh <- tmrca.high.threshold
    }

    if(is.null(tmrca.50.threshold)){
      tmrca50.thresh <- stats::quantile(dat$tmrca, probs = c(0.5), na.rm = TRUE)[1]
    } else{
      tmrca50.thresh <- tmrca.50.threshold
    }

    # Set within-population thresholds
    if(is.null(pop1.threshold)){
      pop1.tmrcaw.thresh <- stats::quantile(dat$pop1.meantmrcaw, probs = c(0.05,0.1), na.rm = TRUE)[1]
    } else{
      pop1.tmrcaw.thresh <- pop1.threshold
    }

    if(is.null(pop1.tmrcaw.95threshold)){
      pop1.tmrcaw.95thresh <- stats::quantile(dat$pop1.meantmrcaw, probs = c(0.95), na.rm = TRUE)[1]
    } else{
      pop1.tmrcaw.95thresh <- pop1.tmrcaw.95threshold
    }

    if(is.null(pop2.threshold)){
      pop2.tmrcaw.thresh <- stats::quantile(dat$pop2.meantmrcaw, probs = c(0.05,0.1), na.rm = TRUE)[1]
    } else{
      pop2.tmrcaw.thresh <- pop2.threshold
    }

    if(is.null(pop2.tmrcaw.95threshold)){
      pop2.tmrcaw.95thresh <- stats::quantile(dat$pop2.meantmrcaw, probs = c(0.95), na.rm = TRUE)[1]
    } else{
      pop2.tmrcaw.95thresh <- pop2.tmrcaw.95threshold
    }

    if(is.null(tmrca.iqr.low.threshold)){
      tmrca.iqr.low <- stats::quantile(dat$tmrca, probs = c(0.25), na.rm = TRUE)[1]
    } else{
      tmrca.iqr.low <- tmrca.iqr.low.threshold
    }

    ### Identify args that follow different models

    if("BS" %in% analysis | analysis == "all"){
      BS_args <- background %>% dplyr::filter(tmrca >= tmrca.thresh)
    } else{
      BS_args <- NULL
    }
    if("INT" %in% analysis | analysis == "all"){
      INT_args <- background %>% dplyr::filter(tmrca < tmrca.iqr.low & (pop1.meantmrcaw >= pop1.tmrcaw.thresh & pop2.meantmrcaw >= pop2.tmrcaw.thresh))
    } else{
      INT_args <- NULL
    }
    if("BSINT" %in% analysis | analysis == "all"){
      BSINT_args <- dat %>% dplyr::filter((tmrca > tmrca.iqr.low & tmrca < tmrca50.thresh) &  (pop1.meantmrcaw >= pop1.tmrcaw.95thresh & pop2.meantmrcaw >= pop2.tmrcaw.95thresh))
    } else{
      BSINT_args <- NULL
    }


    Output <- list(BS_args, INT_args, BSINT_args)

    names(Output) <- c("BS", "INT", "BSINT")
  }

  # Set list of possible analyses
  Stat <- c("BS", "INT", "BSINT")
  Stat_idx <- c(1,2,3)

  if(length(analysis) == 1 && analysis ==  "all"){
    return(Output)
  } else {
    res <- which(Stat %in% analysis)
    Output_final<- Output[which(Stat_idx %in% res)]
    return(Output_final)
  }


}
