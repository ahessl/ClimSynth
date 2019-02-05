#read.prism.R
#Function to read PRISM time series data

prism.files <- list.files("data/") ##how can I assign names from filenames?
grid.names <- sub('.*201*0110_', '', prism.files)

     
dataFiles <- lapply(Sys.glob("data/*.csv"), read.csv, skip=11, head=F)
lapply(Sys.glob("data/*.csv"), read.csv, skip=11, head=F)

climvars <- c("pdate", "ppt", "tmin", "tmean", "tmax")
dataFiles <- lapply(dataFiles, setNames, climvars)




