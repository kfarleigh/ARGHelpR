# A data frame containing the population assignments for different haplotypes in the rattlesnake_args data.

Data frame containing 2 columns and 30 rows

## Usage

``` r
data(rattlesnake_pops)
```

## Format

A data frame with 2 columns and 30 rows:

- sample:

  All haplotypes in the data

- species:

  Population assignment

## Source

Farleigh, K., Highland, D. K., Alderman, M. G., Francioli, Y., Hirst, S.
R., Faber, E. M., ... & Schield, D. R. (2026). Evolution of genome-wide
barriers to gene flow during complex speciation in rattlesnakes.
Proceedings of the National Academy of Sciences, 123(21), e2609058123.

## Examples

``` r
# \donttest{
data(rattlesnake_pops)
Test <- rattlesnake_pops[,1]# }
```
