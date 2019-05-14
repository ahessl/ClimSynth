#read.prism.R
#Function to read PRISM monthly time series data from a directory
#Rename the col headings, return a list of all prism files in directory
#read.prism()
read.prism <- function(site) {
    data.path <- paste0("Data/", site)
    
    prism.files <- list.files(data.path) 

    glob.path <- paste0(data.path, "/*.csv")   
    
    dataFiles <- lapply(Sys.glob(glob.path), read.csv, skip=11, head=F)
    
    
    climvars <- c("pdate", "ppt", "tmin", "tmean", "tmax")
    dataFiles <- lapply(dataFiles, setNames, climvars)
}

