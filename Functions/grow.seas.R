# grow.seas.R
# calculate a growing season mean of long form prism monthly data
# arguments include pgrid (longform monthly climate data)
# months to select for growing season 1:12 (sel_mons) , 
# variables to select from the climate data (sel_vars),
# month to start the growth year (st_mon) - only relevant
# if including winter months, and summary method mean or sum
# (sum_f)

# grow.seas (pgrid, sel_mons = c(5:7), sel_vars = c(3:5), 
# st_mon = 11, sum_f = c(mean, sum))

library(lubridate)

# growing season year (st_mon), summary function (sum_f)
grow.seas <- function (pgrid, sel_mons, sel_vars, st_mon, 
                       sum_f){
    
    stopifnot(is.numeric(sel_mons), is.numeric(sel_vars),
              is.numeric(st_mon), max(sel_mons)<=12, st_mon<=12, 
              is.character(sum_f))
  
    sel_mon_l <- paste0(substr(month.abb[sel_mons], 1, 1), collapse='') #first letter of selected months
    var_names <- colnames(pgrid[sel_vars])
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




