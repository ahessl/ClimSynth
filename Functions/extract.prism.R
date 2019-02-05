#extract.prism -INCOMPLETE SINCE DOWNLOADABLE!
#Function to read in prism data from online source and extract a single lat/lon gridpoint
#lat.box is vector of 4L (minlat, maxlat, minlon, maxlon)

extract.prism <- function (mon.var, lat.box) {
    stopifnot(length(lat.box)==4)
    library(prism)
    library(raster)
    library(reshape2)

    #get prism monthly
    prism.path <- 'Data/'
    mon.var <- 'tmax'
    get_prism_monthlys(type=mon.var, years = 1895:2014, mon = c(1:12))
    
    ls_prism_data(name=TRUE)
    
    #Use prism_slice?
    p <- prism_slice(c(38.6, -79.3), ls_prism_data())
    
#########    
    
    #OR?
    #Convert to dataframe
    #Stack
    RS <- prism_stack(ls_prism_data()) ##stacked raster file
  
    # Get proj from raster stack
    mycrs <- RS@crs@projargs
    
    # Convert points to spatial points data frame
    
    #coordinates(mypoints) <- c('long', 'lat')
    #proj4string(mypoints) <- CRS(mycrs)
    
    df <- data.frame(rasterToPoints(RS)) ##creates a dataframe of points
    month.df <- melt(df, c("x", "y"))
    names(month.df)[1:2] <- c("lon", "lat") #rename columns
    
    #extract by lat lon box
    minLat=38.6
    maxLat=39.2
    minLon=-79.9
    maxLon=-79.3
    
    month.df.balsam<-month.df%>%filter(minLat < lat, lat < maxLat, minLon < lon, lon <maxLon)%>%
      mutate(ppt = value)%>%
      select(-value)
    
    dim(month.df)
    dim(month.df.balsam)
    
}