# Identify ancestral recombination graphs under selection or involved in introgression

Identify ancestral recombination graphs under selection or involved in
introgression

## Usage

``` r
identify_argcandidates(dat, analysis = "all", background = NULL)
```

## Arguments

- dat:

  a dataframe of ancestral recombination graph statistics calculated
  using the argstats function.

- analysis:

  a character vector indicating the types of args you want to identify.
  Options are "all" for all types, "RI", "WP", "RS", "RIWP", "BS",
  "INT".

- background:

  a dataframe of ancestral recombination graph statistics calculated
  using the argstats function. If supplied this will be used to define
  thresholds and the dat argument will be treated as the test set.

## Value

a list containing ARGs that were identified as candidates

## Examples

``` r
# \donttest{
Test <- identify_argcandidates(dat = rattlesnake_argstats, analysis = "all")# }
#> Error: object 'rattlesnake_argstats' not found
```
