#' Identify ancestral recombination graphs under selection or involved in introgression
#'
#' @param dat a dataframe of ancestral recombination graph statistics calculated using the argstats function.
#' @param analysis a character vector indicating the types of args you want to identify. Options are "all" for all types, "RI", "WP", "RS", "RIWP", "BS", "INT".
#' @param background a dataframe of ancestral recombination graph statistics calculated using the argstats function. If supplied this will be used to define thresholds and the dat argument will be treated as the test set.
#'
#' @returns a list containing ARGs that were identified as candidates
#' @export
#'
#' @examples
#' \donttest{
#' Test <- identify_argcandidates(dat = rattlesnake_argstats, analysis = "all")}
identify_argcandidates <- function(dat, analysis = "all", background = NULL){

  # If there is not a user defined genomic background we will consider the entire dat argument and use that to identify candidate args, otherwise, we set thresholds based on the background argument.
  if(is.null(background)){

    # Set reproductive isolation thresholds
    tmrca.thresh <- quantile(dat$tmrca, probs = c(0.9,0.95,1))[2]

    # Set within-population selection thresholds
    pop1.tmrcaw.thresh <- quantile(dat$pop1.meantmrcaw, probs = c(0.05,0.1))[1]
    pop2.tmrcaw.thresh <- quantile(dat$pop2.meantmrcaw, probs = c(0.05,0.1))[1]

    # Set recurrent selection thresholds
    tmrca.iqr.low <- quantile(dat$tmrca, probs = c(0.25))[1]
    tmrca.iqr.high <- quantile(dat$tmrca, probs = c(0.75))[1]

    # Set RI + WP selection thresholds

    # Set balancing selection thresholds

    # Set introgression thresholds
    trmca.low <- as.numeric(quantile(dat$tmrca, probs = c(0.05)))


    ### Identify args that follow different models

    #RI_args <-
    #WP_args <-
    #RS_args <-
    #RIWP_args <-
    #BS_args <-
    #INT_args <-


  } else {

    # Set reproductive isolation thresholds
    tmrca.thresh <- quantile(background$tmrca, probs = c(0.9,0.95,1))[2]

    # Set within-population selection thresholds
    pop1.tmrcaw.thresh <- quantile(background$pop1.meantmrcaw, probs = c(0.05,0.1))[1]
    pop2.tmrcaw.thresh <- quantile(background$pop2.meantmrcaw, probs = c(0.05,0.1))[1]

    # Set recurrent selection thresholds
    tmrca.iqr.low <- quantile(background$tmrca, probs = c(0.25))[1]
    tmrca.iqr.high <- quantile(background$tmrca, probs = c(0.75))[1]

    # Set RI + WP selection thresholds

    # Set balancing selection thresholds

    # Set introgression thresholds
    trmca.low <- as.numeric(quantile(background$tmrca, probs = c(0.05)))

    ### Identify args that follow different models

    #RI_args <-
    #WP_args <-
    #RS_args <-
    #RIWP_args <-
    #BS_args <-
    #INT_args <

  }

  #### Update this nonsense
  return(tmrca.low)

}
