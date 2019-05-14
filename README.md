### ClimSynth

#### Two Functions: read.prism.R and grow.seas.R

##### read.prism.R
read.prism(directory)
Reads in prism data from a directory in "Data"", renames some columns and formats for package treeclim. Returns a list of all the prism files in that directory. Can be subsetted:

```r
pgrid.list[[1]]
```


##### grow.seas.R

Takes the product of Summarize monthly prism climate data by temporal windows of months
Select starting year of growing season, length of growing season to summarize, mean or sum

```r
 source("Functions/grow.seas.R")
 grow.seas (pgrid, sel_mons = c(5:7), sel_vars = c(3:5), st_mon = 11, sum_f = c("mean", "sum"))
```
Calculates a growing season mean or sum of long form monthly climate data from Prism grids
