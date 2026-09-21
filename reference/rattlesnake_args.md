# Example list where each element is a data frame representing a single ancestral recombination graph; this was generated using data from Farleigh et al. (2026).

A list where each element is a data frame representing a single
ancestral recombination graph.

## Usage

``` r
data(rattlesnake_args)
```

## Format

A list with data frames with four columns:

- chromosome:

  The chromsome information for each ARG.

- start:

  The start position of each ARG.

- end:

  The end position of each ARG.

- tree:

  The ARG for the interval.

## Source

Farleigh, K., Highland, D. K., Alderman, M. G., Francioli, Y., Hirst, S.
R., Faber, E. M., ... & Schield, D. R. (2026). Evolution of genome-wide
barriers to gene flow during complex speciation in rattlesnakes.
Proceedings of the National Academy of Sciences, 123(21), e2609058123.

## Examples

``` r
data(rattlesnake_args)
# \donttest{
Test <- argstats(arg.dat = rattlesnake_args, pop1 = pop1_inds, pop2 = pop2_inds, pop1.name = "continental", pop2.name = "stephensi")# }
#> Error: object 'pop1_inds' not found


```
