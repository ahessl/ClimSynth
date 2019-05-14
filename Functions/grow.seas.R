# grow.seas.R
# calculate a growing season mean of long form climate data

library(tidyverse)
library(lubridate)

source("Functions/read.prism.R")

pgrid.list <- read.prism("mon_cv")
pgrid <- pgrid.list[[1]]


# grow.seas using long form prism climate data, select months to summarize, starting month for 
# growing season year, TBD select mean or total
grow.seas <- function (pgrid, sel_mons = c(5:7), st_mon = 11){

    sel_mons <- c(5:7) #months to select
    st_mon <- 11 #start month for grow year (rel for NH winter)
    
    sel_mon_l <- paste0(substr(month.abb[sel_mons], 1, 1), collapse='') #first letter of selected months
    
    
    pgrid$pdate <- paste0(pgrid$pdate, "-01")
    pgrid$mon <- month(pgrid$pdate)
    pgrid$year <- year(pgrid$pdate)
    
    #Add if statement for adjusting winter months to next season
    pgrid$adj_yr <- ifelse(pgrid$mon>=st_mon, 
                           pgrid$year+1, 
                           pgrid$year)


    pgrid$gr_seas <- ifelse(pgrid$mon %in% sel_mons,
                            sel_mon_l, 
                            "NA")

    gr_seas_df <- aggregate(pgrid[,c(3:5)], by=list(pgrid$gr_seas, pgrid$year), mean)
    gr_seas_df <- gr_seas_df[gr_seas_df$Group.1==sel_mon_l,]
    colnames(gr_seas_df[1:2]) <- c("gr_seas", "year")

    return(gr_seas_df)