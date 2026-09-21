## code to prepare `rattlesnake_pops` dataset goes here

pops <- read.delim("/Users/kfarleigh/Downloads/pis_con.popmap", header = FALSE)

pops$species <- "continental"

pops$species[c(1:3)] <- "pisgah"

colnames(pops)[1] <- "sample"

pops_hap1 <- pops
pops_hap2 <- pops

pops_hap1$sample <- paste(pops_hap1$sample, "_1", sep = "")
pops_hap2$sample <- paste(pops_hap2$sample, "_2", sep = "")

rattlesnake_pops <- rbind(pops_hap1,pops_hap2)


usethis::use_data(rattlesnake_pops, overwrite = TRUE)
