#' Identify ancestral recombination graphs under selection that correspond to models of divergence.
#'
#' @param dat a dataframe of ancestral recombination graph statistics calculated using the argstats function.
#' @param analysis a character vector indicating the types of args you want to identify. Options are "all" for all types, "RI", "WP", "RS", "RIWP".
#' @param background a dataframe of ancestral recombination graph statistics calculated using the argstats function. If supplied this will be used to define thresholds and the dat argument will be treated as the test set.
#' @param tmrca.threshold a numeric value to customize the tmrca threshold used to identify ARGs associated with reproductive isolation.
#' @param pop1.threshold a numeric value to customize the pop1 tmrcaw threshold used to identify ARGs associated with within-population selection and recurrent selection.
#' @param pop2.threshold a numeric value to customize the pop2 tmrcaw threshold used to identify ARGs associated with within-population selection and recurrent selection.
#' @param tmrca.iqr.low.threshold a numeric value to customize the lower tmrca threshold used to identify ARGs associated with within-population selection and recurrent selection.
#' @param tmrca.iqr.high.threshold a numeric value to customize the upper tmrca threshold used to identify ARGs associated with within-population selection and recurrent selection.
#'
#' @returns a list containing ARGs that were identified as candidates
#' @export
#'
#' @examples
#' \donttest{
#' Test <- identify_argcandidates(dat = rattlesnake_argstats, analysis = "all")}
identify_argcandidates_divergence <- function(dat, analysis = "all", background = NULL, tmrca.threshold = NULL, pop1.threshold = NULL, pop2.threshold = NULL, tmrca.iqr.low.threshold = NULL, tmrca.iqr.high.threshold = NULL){

  tmrca <- pop1.meantmrcaw <- pop2.meantmrcaw <- NULL

  # If there is not a user defined genomic background we will consider the entire dat argument and use that to identify candidate args, otherwise, we set thresholds based on the background argument.
  if(is.null(background)){

    if(is.null(tmrca.threshold)){
    # Set reproductive isolation thresholds
    tmrca.thresh <- stats::quantile(dat$tmrca, probs = c(0.9,0.95,1))[2]
    } else{
      tmrca.thresh <- tmrca.threshold
    }

    # Set within-population selection thresholds
    if(is.null(pop1.threshold)){
    pop1.tmrcaw.thresh <- stats::quantile(dat$pop1.meantmrcaw, probs = c(0.05,0.1))[1]
    } else{
      pop1.tmrcaw.thresh <- pop1.threshold
    }
    if(is.null(pop2.threshold)){
    pop2.tmrcaw.thresh <- stats::quantile(dat$pop2.meantmrcaw, probs = c(0.05,0.1))[1]
    } else{
      pop2.tmrcaw.thresh <- pop2.threshold
    }

    # Set recurrent selection thresholds
    if(is.null(tmrca.iqr.low.threshold)){
    tmrca.iqr.low <- stats::quantile(dat$tmrca, probs = c(0.25))[1]
    } else{
      tmrca.iqr.low <- tmrca.iqr.low.threshold
    }

    if(is.null(tmrca.iqr.high.threshold)){
    tmrca.iqr.high <- stats::quantile(dat$tmrca, probs = c(0.75))[1]
    } else{
      tmrca.iqr.high <- tmrca.iqr.high.threshold
    }

    # Set introgression thresholds
    #trmca.low <- as.numeric(stats::quantile(dat$tmrca, probs = c(0.05)))


    ### Identify args that follow different models

    if("RI" %in% analysis | analysis == "all"){
      RI_args <- dat %>% dplyr::filter(tmrca >= tmrca.thresh)
    } else{
      RI_args <- NULL
    }
    if("WP" %in% analysis | analysis == "all"){
      WP_args <- dat %>% dplyr::filter(tmrca < tmrca.iqr.high & tmrca > tmrca.iqr.low & (pop1.meantmrcaw <= pop1.tmrcaw.thresh | pop2.meantmrcaw <= pop2.tmrcaw.thresh))
    } else{
      WP_args <- NULL
    }
    if("RS" %in% analysis | analysis == "all"){
      RS_args <- dat %>% dplyr::filter(tmrca < tmrca.iqr.low & (pop1.meantmrcaw <= pop1.tmrcaw.thresh | pop2.meantmrcaw <= pop2.tmrcaw.thresh))
    } else{
      RS_args <- NULL
    }
    if("RIWP" %in% analysis | analysis == "all"){
      RIWP_args <- dat %>% dplyr::filter(tmrca >= tmrca.thresh & (pop1.meantmrcaw <= pop1.tmrcaw.thresh | pop2.meantmrcaw <= pop2.tmrcaw.thresh))
    } else{
      RIWP_args <- NULL
    }

    Output <- list(RI_args, WP_args, RS_args, RIWP_args)

    names(Output) <- c("RI", "WP", "RS", "RIWP")


    #BS_args <- dat %>% filter(tmrca >= tmrca.thresh)
    #INT_args <- dat %>% filter(tmrca < tmrca.iqr.low & (pop1.meantmrcaw >= pop1.tmrcaw.thresh & pop2.meantmrcaw >= pop2.tmrcaw.thresh))


  } else {

    if(is.null(tmrca.threshold)){
      # Set reproductive isolation thresholds
      tmrca.thresh <- stats::quantile(background$tmrca, probs = c(0.9,0.95,1))[2]
    } else{
      tmrca.thresh <- tmrca.threshold
    }

    # Set within-population selection thresholds
    if(is.null(pop1.threshold)){
      pop1.tmrcaw.thresh <- stats::quantile(background$pop1.meantmrcaw, probs = c(0.05,0.1))[1]
    } else{
      pop1.tmrcaw.thresh <- pop1.threshold
    }
    if(is.null(pop2.threshold)){
      pop2.tmrcaw.thresh <- stats::quantile(background$pop2.meantmrcaw, probs = c(0.05,0.1))[1]
    } else{
      pop2.tmrcaw.thresh <- pop2.threshold
    }

    # Set recurrent selection thresholds
    if(is.null(tmrca.iqr.low.threshold)){
      tmrca.iqr.low <- stats::quantile(background$tmrca, probs = c(0.25))[1]
    } else{
      tmrca.iqr.low <- tmrca.iqr.low.threshold
    }

    if(is.null(tmrca.iqr.high.threshold)){
      tmrca.iqr.high <- stats::quantile(background$tmrca, probs = c(0.75))[1]
    } else{
      tmrca.iqr.high <- tmrca.iqr.high.threshold
    }

    ### Identify args that follow different models

    if("RI" %in% analysis | analysis == "all"){
      RI_args <- dat %>% dplyr::filter(tmrca >= tmrca.thresh)
    } else{
      RI_args <- NULL
    }
    if("WP" %in% analysis | analysis == "all"){
      WP_args <- dat %>% dplyr::filter(tmrca < tmrca.iqr.high & tmrca > tmrca.iqr.low & (pop1.meantmrcaw <= pop1.tmrcaw.thresh | pop2.meantmrcaw <= pop2.tmrcaw.thresh))
    } else{
      WP_args <- NULL
    }
    if("RS" %in% analysis | analysis == "all"){
      RS_args <- dat %>% dplyr::filter(tmrca < tmrca.iqr.low & (pop1.meantmrcaw <= pop1.tmrcaw.thresh | pop2.meantmrcaw <= pop2.tmrcaw.thresh))
    } else{
      RS_args <- NULL
    }
    if("RIWP" %in% analysis | analysis == "all"){
      RIWP_args <- dat %>% dplyr::filter(tmrca >= tmrca.thresh & (pop1.meantmrcaw <= pop1.tmrcaw.thresh | pop2.meantmrcaw <= pop2.tmrcaw.thresh))
    } else{
      RIWP_args <- NULL
    }

    Output <- list(RI_args, WP_args, RS_args, RIWP_args)

    names(Output) <- c("RI", "WP", "RS", "RIWP")

  }

  # Set list of possible analyses
  Stat <- c("RI", "WP", "RS", "RIWP")
  Stat_idx <- c(1,2,3,4)

  if(length(analysis) == 1 && analysis ==  "all"){
    return(Output)
  } else {
    res <- which(Stat %in% analysis)
    Output_final<- Output[which(Stat_idx %in% res)]
    return(Output_final)
  }


}
