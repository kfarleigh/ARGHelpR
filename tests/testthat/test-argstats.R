test_that("argstats works", {

  # Create fake individuals
  pop1_inds <- c("ind1_1", "ind2_1", "ind1_2", "ind2_2")
  pop2_inds <- c("ind3_1", "ind4_1", "ind3_2", "ind4_2")

  # Create a fake ARG where tmrcab = 50 and tmrcaw = 25 in both populations
  test_tree <- c("(((ind1_1:8.0,ind1_2:8.0):17.0,(ind2_1:15.0,ind2_2:15.0):10.0):25.0,((ind3_1:10.0,ind3_2:10.0):15.0,(ind4_1:18.0,ind4_2:18.0):7.0):25.0);")

  # Set our expectations
  tmrcab_exp <- 50
  tmrcaw_exp <- 25

  # Make our test data frame
  test_df <- data.frame(chromosome = "1", start = 1, end = 50, tree = test_tree)

  # Make it a list for argstats
  test_list <- split(test_df , seq_len(nrow(test_df)))

  # Run the calculations
  test_stats <- argstats(test_list, pop1 = pop1_inds, pop2 = pop2_inds, pop1.name = "p1", pop2.name = "p2")

  # Bind into a data frame
  test_stats_df <- do.call("rbind", test_stats)

  # Make sure they are equal
  expect_equal(tmrcab_exp, test_stats_df$tmrca)
  expect_equal(tmrcaw_exp, test_stats_df$pop2.meantmrcaw)
})

