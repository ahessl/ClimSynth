# grow.seas.R
# calculate a growing season mean of long form climate data
# grow.seas (pgrid, sel_mons = c(5:7), sel_vars = c(3:5), 
# st_mon = 11, sum_f = c(mean, sum))

sel_mons = c(5:7)
sel_vars = c(2)
st_mon = 11
sum_f = sum


library(lubridate)

source("Functions/read.prism.R")

pgrid.list <- read.prism("mon_cv")
pgrid <- pgrid.list[[1]]


# grow.seas using long form prism climate data (pgrid), select months to summarize (), starting month for 
# growing season year (st_mon), summary function (sum_f)
grow.seas <- function (pgrid, sel_mons, sel_vars, st_mon, 
                       sum_f){
  
    sel_mon_l <- paste0(substr(month.abb[sel_mons], 1, 1), collapse='') #first letter of selected months
    var_names <- colnames(pgrid[sel_vars])
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

    gr_seas_df <- aggregate(pgrid[,sel_vars], 
        by=list(pgrid$gr_seas, pgrid$year), sum_f)
    gr_seas_df <- gr_seas_df[gr_seas_df$Group.1==sel_mon_l,]
    colnames(gr_seas_df) <- c("gr_seas", "year", var_names)
    
    return(gr_seas_df)
}

x <- grow.seas (pgrid, sel_mons = c(5:7), sel_vars = c(3:5), 
    st_mon = 11, sum_f = mean)
