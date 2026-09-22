#' Example list where each element is a data frame representing a single ancestral recombination graph; this was generated using data from Farleigh et al. (2026).
#'
#'
#' A list where each element is a data frame representing a single ancestral recombination graph.
#' @usage data(rattlesnake_args)
#' @format A list with data frames with four columns:
#' \describe{
#' \item{chromosome}{The chromsome information for each ARG.}
#' \item{start}{The start position of each ARG.}
#' \item{end}{The end position of each ARG.}
#' \item{tree}{The ARG for the interval.}
#'
#' ...
#' }
#' @examples
#' data(rattlesnake_args)
#' \donttest{
#' data(rattlesnake_args)
#' data(rattlesnake_pops)
#'
#' pop2 <- rattlesnake_pops[which(rattlesnake_pops$species == "pop2"),]
#' pop1 <- rattlesnake_pops[which(rattlesnake_pops$species == "pop1"),]
#'
#' Test <- argstats(arg.dat = rattlesnake_args, pop1 = pop1$sample, pop2 = pop2$sample, pop1.name = "pop1", pop2.name = "pop2")}
#'
#'
#'
#' @source Farleigh, K., Highland, D. K., Alderman, M. G., Francioli, Y., Hirst, S. R., Faber, E. M., ... & Schield, D. R. (2026). Evolution of genome-wide barriers to gene flow during complex speciation in rattlesnakes. Proceedings of the National Academy of Sciences, 123(21), e2609058123.
#'
"rattlesnake_args"
##########################################################################
#' A data frame containing the population assignments for different haplotypes in the rattlesnake_args data.
#'
#' Data frame containing 2 columns and 30 rows
#' @usage data(rattlesnake_pops)
#' @format A data frame with 2 columns and 30 rows:
#' \describe{
#' \item{sample}{All haplotypes in the data}
#' \item{species}{Population assignment}
#'
#' ...
#' }
#' @examples
#' \donttest{
#' data(rattlesnake_pops)
#' Test <- rattlesnake_pops[,1]}
#'
#' @source Farleigh, K., Highland, D. K., Alderman, M. G., Francioli, Y., Hirst, S. R., Faber, E. M., ... & Schield, D. R. (2026). Evolution of genome-wide barriers to gene flow during complex speciation in rattlesnakes. Proceedings of the National Academy of Sciences, 123(21), e2609058123.
#'
"rattlesnake_pops"
