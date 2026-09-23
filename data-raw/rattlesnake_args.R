## code to prepare `rattlesnake_args` dataset goes here
rattlesnake_args <- read.table("/Users/kfarleigh/Downloads/ARGHelpR_toydata.bed", header = TRUE)

rattlesnake_args$tree <- gsub("Snake16_1", "Snake1_1", rattlesnake_args$tree)
rattlesnake_args$tree <- gsub("Snake16_2","Snake1_2", rattlesnake_args$tree)
rattlesnake_args$tree <- gsub("Snake17_1","Snake2_1", rattlesnake_args$tree)
rattlesnake_args$tree <- gsub("Snake17_2","Snake2_2", rattlesnake_args$tree)
rattlesnake_args$tree <- gsub("Snake18_1","Snake3_1", rattlesnake_args$tree)
rattlesnake_args$tree <- gsub("Snake18_2","Snake3_2", rattlesnake_args$tree)
rattlesnake_args$tree <- gsub("Snake21_1","Snake4_1", rattlesnake_args$tree)
rattlesnake_args$tree <- gsub("Snake21_2","Snake4_2", rattlesnake_args$tree)
rattlesnake_args$tree <- gsub("Snake22_1","Snake5_1", rattlesnake_args$tree)
rattlesnake_args$tree <- gsub("Snake22_2","Snake5_2", rattlesnake_args$tree)
rattlesnake_args$tree <- gsub("Snake23_1","Snake6_1", rattlesnake_args$tree)
rattlesnake_args$tree <- gsub("Snake23_2","Snake6_2", rattlesnake_args$tree)
rattlesnake_args$tree <- gsub("Snake24_1","Snake7_1", rattlesnake_args$tree)
rattlesnake_args$tree <- gsub("Snake24_2","Snake7_2", rattlesnake_args$tree)
rattlesnake_args$tree <- gsub("Snake25_1","Snake8_1", rattlesnake_args$tree)
rattlesnake_args$tree <- gsub("Snake25_2","Snake8_2", rattlesnake_args$tree)
rattlesnake_args$tree <- gsub("Snake26_1","Snake9_1", rattlesnake_args$tree)
rattlesnake_args$tree <- gsub("Snake26_2","Snake9_2", rattlesnake_args$tree)
rattlesnake_args$tree <- gsub("Snake27_1","Snake10_1", rattlesnake_args$tree)
rattlesnake_args$tree <- gsub("Snake27_2","Snake10_2", rattlesnake_args$tree)
rattlesnake_args$tree <- gsub("Snake28_1","Snake11_1", rattlesnake_args$tree)
rattlesnake_args$tree <- gsub("Snake28_2","Snake11_2", rattlesnake_args$tree)
rattlesnake_args$tree <- gsub("Snake29_1","Snake12_1", rattlesnake_args$tree)
rattlesnake_args$tree <- gsub("Snake29_2","Snake12_2", rattlesnake_args$tree)
rattlesnake_args$tree <- gsub("Snake30_1","Snake13_1", rattlesnake_args$tree)
rattlesnake_args$tree <- gsub("Snake30_2","Snake13_2", rattlesnake_args$tree)
rattlesnake_args$tree <- gsub("Snake31_1","Snake14_1", rattlesnake_args$tree)
rattlesnake_args$tree <- gsub("Snake31_2","Snake14_2", rattlesnake_args$tree)
rattlesnake_args$tree <- gsub("Snake78_1","Snake15_1", rattlesnake_args$tree)
rattlesnake_args$tree <- gsub("Snake78_2","Snake15_2", rattlesnake_args$tree)

# Replace chromosome names
rattlesnake_args$chromosome <- sub("_.*", "", rattlesnake_args$chromosome)


rattlesnake_args <- rattlesnake_args[1:1000,]



rattlesnake_args <- split(rattlesnake_args, seq_len(nrow(rattlesnake_args)))

usethis::use_data(rattlesnake_args, overwrite = TRUE)
