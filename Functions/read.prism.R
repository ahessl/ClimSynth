#read.prism.R
#Function to read PRISM time series data
#add argument for assigning the directory
read.prism <- function(data.dir) {
    data.path <- paste0("Data/", data.dir)
    
    prism.files <- list.files(data.path) ##how can I assign names from filenames?
    grid.names <- sub('.*201*07_', '', prism.files)
    
    glob.path <- paste0(data.path, "/*.csv")   
    
    #dataFiles <- lapply(Sys.glob("data/daily_cv/*.csv"), read.csv, skip=11, head=F)
    dataFiles <- lapply(Sys.glob(glob.path), read.csv, skip=11, head=F)
    
    
    climvars <- c("pdate", "ppt", "tmin", "tmean", "tmax")
    dataFiles <- lapply(dataFiles, setNames, climvars)
    
    #Create a mean of the dataFrames list
    #abind combines dataframes (or matrices, vectors etc) into arrays along a dimension
    #first remove the date column and save it
    dataFiles.num <- lapply(dataFiles, function(x) { x["pdate"] <- NULL; x })
    pdate <- dataFiles[[1]]$pdate ###Problem for monthly data
    
    dataFiles.mn <- apply(abind::abind(dataFiles.num, along = 3), 1:2, mean, na.rm=T) #returns matrix 
    
    pgrid.df <- data.frame(dataFiles.mn)
    pgrid.df$pdate <- pdate
    
    pgrid.output <- list (prism.files=prism.files, grid.names=grid.names, dataFiles=dataFiles, pgrid.df=pgrid.df)

}

