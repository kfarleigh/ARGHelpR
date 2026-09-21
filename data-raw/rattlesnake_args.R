## code to prepare `rattlesnake_args` dataset goes here
rattlesnake_args <- read.table("/Users/kfarleigh/Downloads/ARGHelpR_toydata.bed", header = TRUE)

rattlesnake_args <- rattlesnake_args[1:1000,]

rattlesnake_args <- split(rattlesnake_args, seq_len(nrow(rattlesnake_args)))

usethis::use_data(rattlesnake_args, overwrite = TRUE)
