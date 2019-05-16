### ClimSynth

#### Two Functions: read.prism.R and grow.seas.R

##### read.prism.R
read.prism(site, tstep)

Reads in daily or monthly prism data from a directory/site in "Data/climate_data/", renames some columns and formats for package treeclim. Returns a list that includes a vector of all the files used (prism.files), a list that contains all the raw  data files used (dataFiles), and a dataframe mean of each variable from all the prism files in that directory (pgrid.df)

```r
 source("Functions/read.prism.R")
 read.prism("cv", "daily")
```

##### grow.seas.R
grow.seas(pgrid, sel_mons = NUM, sel_vars = NUM, st_mon = NUM, sum_f = FUN)

Takes the product of read.prism (pgrid.df) and summarizes monthly prism climate data by temporal windows of months
Select starting year of growing season, length of growing season to summarize, mean or sum, returns dataframe of growing season months included, years, climate variables included (gr_seas_df)

```r
 source("Functions/grow.seas.R")
 grow.seas (pgrid, sel_mons = c(5:7), sel_vars = c(3:5), st_mon = 11, sum_f = c("mean", "sum"))
```


##### To Do List
1) Create an option in read.prism for daily files
1) Separate grow.seas.R into a separate function to set beginning of growth year and one to summarize by user defined growing season.


