# Identify ancestral recombination graphs under selection that correspond to models of divergence.

Identify ancestral recombination graphs under selection that correspond
to models of divergence.

## Usage

``` r
identify_argcandidates_divergence(
  dat,
  analysis = "all",
  background = NULL,
  tmrca.threshold = NULL,
  pop1.threshold = NULL,
  pop2.threshold = NULL,
  tmrca.iqr.low.threshold = NULL,
  tmrca.iqr.high.threshold = NULL
)
```

## Arguments

- dat:

  a dataframe of ancestral recombination graph statistics calculated
  using the argstats function.

- analysis:

  a character vector indicating the types of args you want to identify.
  Options are "all" for all types, "RI", "WP", "RS", "RIWP".

- background:

  a dataframe of ancestral recombination graph statistics calculated
  using the argstats function. If supplied this will be used to define
  thresholds and the dat argument will be treated as the test set.

- tmrca.threshold:

  a numeric value to customize the tmrca threshold used to identify ARGs
  associated with reproductive isolation.

- pop1.threshold:

  a numeric value to customize the pop1 tmrcaw threshold used to
  identify ARGs associated with within-population selection and
  recurrent selection.

- pop2.threshold:

  a numeric value to customize the pop2 tmrcaw threshold used to
  identify ARGs associated with within-population selection and
  recurrent selection.

- tmrca.iqr.low.threshold:

  a numeric value to customize the lower tmrca threshold used to
  identify ARGs associated with within-population selection and
  recurrent selection.

- tmrca.iqr.high.threshold:

  a numeric value to customize the upper tmrca threshold used to
  identify ARGs associated with within-population selection and
  recurrent selection.

## Value

a list containing ARGs that were identified as candidates

## Examples

``` r
# \donttest{
Test <- identify_argcandidates(dat = rattlesnake_argstats, analysis = "all")# }
#> Error in identify_argcandidates(dat = rattlesnake_argstats, analysis = "all"): could not find function "identify_argcandidates"
```
