# What is an ancestral recombination graph?

Written by: Dylan Highland  
Edited by: Keaka Farleigh, Ph.D.  
Date: September, 15th, 2026.  
Date last modified: September, 15th, 2026

## Purpose

To help you understand what an ancestral recombination graph (ARG) is
and what it is used for.

## What is an ancestral recombination graph?

An ancestral recombination graph (ARG) is a powerful genealogical
framework that is used in population genomics studies to represent the
evolutionary and genealogical history of a given set of genomic data
([Brandt et
al. 2024](https://academic.oup.com/gbe/article/16/2/evae005/7577593)).
While traditional phylogenetic approaches consider the genome a single
entity when inferring relationships between groups, ARGs account for
genetic recombination, and in doing so, recognize that segments of the
genome are products of distinct evolutionary histories. Thus, an ARG can
represent the complex evolutionary histories of data and improve our
understanding of lineage diversification relative to simpler
phylogenetic or summary statistic approaches. Moreover, this information
can be used to disentangle intricate and occasionally overlapping
evolutionary forces such as selection and gene flow. An ARG captures
this complexity by representing the relationships among sampled
haplotypes across the genome as a series of local genealogies connected
by recombination events. These genealogies describe how haplotypes
coalesce through time and we can use them to calculate the time to the
most recent common ancestor between lineages (TMRCA_(B)), as well as the
time to the most recent common ancestor within a lineage (TMRCA_(W)),
respectively.

ARGs have a variety of applications in population genetics, including
characterizing the genealogical history of specific genomic regions
across evolutionary time. Reconstructing ARGs allows researchers to
investigate patterns of ancestry and genetic variation across the
genome, including the distribution of mutations and genetic variants,
signatures of natural selection, and patterns of introgression between
populations or species ([Lewanski et
al. 2024](https://journals.plos.org/plosgenetics/article?id=10.1371/journal.pgen.1011110)).
By retaining information about local genealogies and their relationships
across the genome, ARGs can provide insights into evolutionary processes
that may be difficult to distinguish using individual gene trees or
summary statistics alone.

## Using ARGs to identify signatures of natural selection and introgression

Because forces of natural selection cause shifts in allele frequencies
over time, we can use ARGs to estimate the relative age of any given
sequence, and further, the mode of selection that operates there. For
example, under positive selection a given allele is swept to fixation
within a population; therefore, we would expect to see a more recent
coalescence time than predicted under neutrality ([Hejase et
al. 2020](https://www.pnas.org/doi/abs/10.1073/pnas.2015987117)).
Conversely, an allele that is maintained by balancing selection at
intermediate frequencies for long stretches of time would appear older
than a neutral site ([Rasmussen et
al. 2014](https://journals.plos.org/plosgenetics/article?id=10.1371/journal.pgen.1004342)).
Additionally, ARGs can also be used to detect introgression events
between species, as this process introduces alleles into the recipient
population post divergence, reducing TMRCAB ([Hubisz et
al. 2020](https://journals.plos.org/plosgenetics/article?id=10.1371/journal.pgen.1008895)).

## Literature Cited

Brandt, D. Y., Huber, C. D., Chiang, C. W., & Ortega-Del Vecchyo, D.
(2024). The promise of inferring the past using the ancestral
recombination graph. *Genome biology and evolution*, *16*(2), evae005.

Hejase, H. A., Salman-Minkov, A., Campagna, L., Hubisz, M. J., Lovette,
I. J., Gronau, I., & Siepel, A. (2020). Genomic islands of
differentiation in a rapid avian radiation have been driven by recent
selective sweeps. *Proceedings of the National Academy of Sciences*,
*117*(48), 30554-30565.

Hubisz, M. J., Williams, A. L., & Siepel, A. (2020). Mapping gene flow
between ancient hominins through demography-aware inference of the
ancestral recombination graph. *PLoS genetics*, *16*(8), e1008895.

Lewanski, A. L., Grundler, M. C., & Bradburd, G. S. (2024). The era of
the ARG: An introduction to ancestral recombination graphs and their
significance in empirical evolutionary genomics. *Plos Genetics*,
*20*(1), e1011110.

Rasmussen, M. D., Hubisz, M. J., Gronau, I., & Siepel, A. (2014).
Genome-wide inference of ancestral recombination graphs. *PLoS
genetics*, *10*(5), e1004342.
