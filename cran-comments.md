## October 15th, 2026

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.

```
checking Rd line widths ... NOTE
  Rd file 'argplot.Rd':
    \examples lines wider than 100 characters:
       test_plot <- argplot(arg = rattlesnake_args[[1]][1,4], pop1 = pop1$sample, pop2 = pop2$sample, col = c("#71BED6","#EDAF49"))
  
  Rd file 'argstats.Rd':
    \examples lines wider than 100 characters:
       Test <- argstats(arg.dat = rattlesnake_args, pop1 = pop1$sample, pop2 = pop2$sample, pop1.name = "pop1", pop2.name = "pop2")
  
  Rd file 'argstats_helper.Rd':
    \examples lines wider than 100 characters:
       Test <- argstats(arg.dat = rattlesnake_args, pop1 = pop1$sample, pop2 = pop2$sample, pop1.name = "pop1", pop2.name = "pop2")
  
  Rd file 'identify_argcandidates_divergence.Rd':
    \examples lines wider than 100 characters:
       stat_res <- argstats(arg.dat = rattlesnake_args, pop1 = pop1$sample, pop2 = pop2$sample, pop1.name = "pop1", pop2.name = "pop2")
  
  Rd file 'identify_argcandidates_shared.Rd':
    \examples lines wider than 100 characters:
       stat_res <- argstats(arg.dat = rattlesnake_args, pop1 = pop1$sample, pop2 = pop2$sample, pop1.name = "pop1", pop2.name = "pop2")
  
  Rd file 'rattlesnake_args.Rd':
    \examples lines wider than 100 characters:
       Test <- argstats(arg.dat = rattlesnake_args, pop1 = pop1$sample, pop2 = pop2$sample, pop1.name = "pop1", pop2.name = "pop2")
  
  These lines will be truncated in the PDF manual.
```

It is okay that these lines will be truncated in the PDF manual. 
