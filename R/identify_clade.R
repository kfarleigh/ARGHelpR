### Write a custom function in case species are not monophyletic
# dat is a list element
# pop1 is a vector of individuals in one population
# pop2 is a vector of individuals in the other populations
# tip_idx is a vector of tip labels, this is used internally in the sliding_argstats function, do not modify
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
