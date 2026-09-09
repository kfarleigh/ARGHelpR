# Calculate ancestral recombination graph summary statistics

Calculate ancestral recombination graph summary statistics

## Usage

``` r
argstats(arg.dat, pop1, pop2, pop1.name, pop2.name, n.cores = 1, n.haps = 2)
```

## Arguments

- arg.dat:

  a list where each element is an ancestral recombiation graph
  represented by a data frame. The data frame columns should be
  chromosome, start, end, and the phylogeney estimated in ARG analysis.

- pop1:

  a vector of individuals in one population.

- pop2:

  a vector of individuals in the other population.

- pop1.name:

  a character string that tells us the name of population 1.

- pop2.name:

  a character string that tells us the name of population 2.

- n.cores:

  a numeric value indicating the number of cores to run. Default is 1.
  Anything greater than 1 will run calcualtions in parallel. WARNING
  increasing this number too high can crash your computer depending on
  your dataset.

- n.haps:

  a numeric value indicating the minimum number of haplotypes to
  identify a clade.

## Value

A list of elements. Each element is a data frame containing the
calculated statistics, the relevant window, and relevant arg. The
statistics include the time to the most recent common ancestor between
populations/species (tmrca) and estimates of the time to most recent
common ancestor within populations/species (tmrcaw). The output also
indicates if populations/species are monophyletic and which
population/species corresponds to which population.

## Author

Keaka Farleigh

## Examples

``` r
# \donttest{
Test <- argstats(arg.dat = rattlesnake_args, pop1 = pop1_inds, pop2 = pop2_inds, pop1.name = "continental", pop2.name = "stephensi")# }
#> Error: object 'rattlesnake_args' not found
```
