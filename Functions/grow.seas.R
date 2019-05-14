# grow.seas.R
# calculate a growing season mean of long form climate data

library(tidyverse)
library(lubridate)
library(seas)

source("Functions/read.prism.R")

pgrid.list <- read.prism("mon_cv")
pgrid <- pgrid.list[[1]]

# Mean by seasons
# create seasons using lubridate::quarter
pgrid$pdate <- paste0(pgrid$pdate, "-01")
pgrid$quarters <- quarter(pgrid$pdate, fiscal_start=12, with_year=TRUE)

# create mean of seasons using aggregate
seas_mns <- aggregate(pgrid[,c(3:5)], by=list(pgrid$quarters), mean)

# Mean by selected months
pgrid <- pgrid.list[[1]]
sel_mons <- c(5,6,7) #months to select

pgrid$pdate <- paste0(pgrid$pdate, "-01")
pgrid$mon <- month(pgrid$pdate)
pgrid$year <- year(pgrid$pdate)

#Add if statement for adjusting winter months to next season
#if(pgrid$mon>10) pgrid$year+1 else pgrid$year

pgrid$sel <- pgrid$mon %in% sel_mons

x <- aggregate(pgrid[,c(3:5)], by=list(pgrid$sel, pgrid$year), mean)
x[x$Group.1=="TRUE",]
