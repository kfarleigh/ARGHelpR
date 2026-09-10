#' Visualize ancestral recombination graphs.
#'
#' @param arg a newick string of ancestral recombination graph to be visualized.
#' @param pop1 a vector of individuals in population one.
#' @param pop2 a vector of individuals in population two.
#' @param col a vector of two colors. The first color will be used to color the tips of population 1 and the second will color population 2 tips.
#' @param scale a vector of two numbers. The first number will set the lower bounds of the scale and the second will set the upper bounds. This is useful when you want to compare two args.
#' @param font.size a numeric indicating the size of the tip labels, this is supplied to the cex argument in phytools plotTree function.
#'
#' @returns a phylogeny with tips colored according to population.
#' @export
#'
#' @examples
#' \donttest{
#' test_plot <- argplot(arg = rattlesnake_args[1,4], pop1 = pop1_inds, pop2 = pop2_inds, col = c("#71BED6","#EDAF49"))}
argplot <- function(arg, pop1, pop2, col = c("#6C6EA0", "#1A1F16"), scale = NULL, font.size = 1) {

  # Make the tree
  tree <- ape::read.tree(text = arg)

  # Make a data frame with individuals to color tips
  pop1_df <- data.frame(individual = pop1, color = col[1])
  pop2_df <- data.frame(individual = pop2, color = col[2])

  pops_df <- rbind(pop1_df, pop2_df)

  # Order the pops_df the same as the tips
  tip_ord <- tree$tip.label

  pops_df_ord <- pops_df[base::match(tip_ord, pops_df$individual),]


  # Plot the tree
  arg_tree <- phytools::plotTree(tree, direction = "downwards", cex = font.size, show.tip.label = TRUE, tip.color = pops_df_ord$color)

  if(!is.null(scale)){

    # If the user supplies a scale
    arg_tree <- phytools::plotTree(tree, direction = "downwards", cex = font.size, ylim = c(scale[1], scale[2]), show.tip.label = TRUE, tip.color = pops_df_ord$color)


  }

  return(arg_tree)
}
