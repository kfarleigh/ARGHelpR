# Identify signatures of selection and introgression

Written by: Keaka Farleigh, Ph.D.  
Date: September, 21st, 2026.  
Date last modified: September, 21st, 2026

## Purpose

To help you understand how to identify signatures of selection driving
divergence and evidence of balancing selection and introgression using
ancestral recombination graphs (ARG) in ARGHelpR.

## Background

ARGHelpR provides a function to identify evidence of selection
associated with divergence (`identify_argcandidates_divergence`) and a
function to identify evidence of balancing selection and introgression
(`identify_argcandidates_shared`). **Note that you need to pair ARG
statistics with other tests, because distinct processes can lead to
similar signatures**. This is why we provide two functions, the
`identify_argcandidates_divergence` is meant to be used in a case where
there is a differentiation peak or similar and the
`identify_argcandidates_shared` is meant to be used when you know there
is shared polymorphism.

We provide a visualization below to help you understand what tests
ARGHelpR is performing when you use these functions (see figure below).

![Figure 1. Cartoons showing the expected relationship between ancestral
recombination graphs that are driven by one of a variety of processes
(colored phylogeny) relative to the genomic background (gray phylogeny).
The table below each comparison shows whether the time to the most
recent common ancestory between populations (TMRCAB) and the time to the
most recent common ancestor within populations (TMRCAW) is greater than
(up arrow), equal to (equal sign), or less than (down arrow) the genomic
background. The tests available in identify_argcandidates_shared is
shown on the top and the tests available in
identify_argcandidates_divergence are shown on the bottom. Users can
specify analysis = 'all' to test each scenario or the character string
in parentheses for each test.](ARGcartoons.png)

Figure 1. Cartoons showing the expected relationship between ancestral
recombination graphs that are driven by one of a variety of processes
(colored phylogeny) relative to the genomic background (gray phylogeny).
The table below each comparison shows whether the time to the most
recent common ancestory between populations (TMRCAB) and the time to the
most recent common ancestor within populations (TMRCAW) is greater than
(up arrow), equal to (equal sign), or less than (down arrow) the genomic
background. The tests available in identify_argcandidates_shared is
shown on the top and the tests available in
identify_argcandidates_divergence are shown on the bottom. Users can
specify analysis = ‘all’ to test each scenario or the character string
in parentheses for each test.
