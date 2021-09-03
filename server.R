#Define Server
server <- function(input, output, session) {
  #Call modules
  updateInput("basic")
  inp1 <- inputs1("basic")
  inp2 <- inputs2("basic")
  
  # Assign reactive variables
  inp_2 <- inp2
  inp_1 <- inp1
  
  # Assign reactive information from longest distance traveled by a ship
  # return oldest longitude and latitude, newest longitude and latitude, ship type, ship_id, date, meters
  information <- reactive({
    
    # Lazy assignment to initialize the system
    meters <- 0
    lat_old <- 0
    lon_old <- 0
    lat_new <- 0
    lon_new <- 0
    date <- 0
    
    # Filter data by ship type selected
    # Grouped filter so we only compute ships movement when it is on a different cartesian point 
    # We keep min and max dates for a same cartesian point to estimate ships movement between cartesian points
    vessel <- ships %>%
      filter(SHIP_ID == inp_2()) %>%
      group_by(LON, LAT, ship_type, SHIP_ID) %>%
      filter((DATETIME == max(DATETIME)) | (DATETIME == min(DATETIME)))
    
    
    # Calculate distance through points variation
    for(m in 1:length(vessel$SHIP_ID)) {
      # Get out of loop when we reach the last observation
      if(m == length(vessel$SHIP_ID)) break
      #Use distm() to calculate distance between old and new cartesian points 
      meters_ant <- distm(c(vessel$LON[m], vessel$LAT[m]), c(vessel$LON[m+1], vessel$LAT[m+1]), fun = distHaversine)
      
      #Check if recently calculated distance it's a longer distance than before
      if((meters < meters_ant) | (meters == meters_ant & date < vessel$DATETIME[m])) {
        #Assign new values
        meters <- meters_ant
        lat_old <- vessel$LAT[m]
        lon_old <- vessel$LON[m]
        lat_new <- vessel$LAT[m+1]
        lon_new <- vessel$LON[m+1]
        date <- vessel$DATETIME[m]
      }
    }
    
    #Return list of ships longest distance information
    info <- list(lat_old = lat_old, 
                 lon_old = lon_old, 
                 lat_new = lat_new, 
                 lon_new = lon_new, 
                 date = date, 
                 meters = meters, 
                 ship = inp_2(),
                 type = inp_1())
    info
    
  })
  
  
  # Define map output
  output$mymap <- renderLeaflet({
    
    # Get reactive information from ships longest distance 
    info <-information()
    
    # Return map from info
    leaflet() %>%
      addTiles() %>%  # Add default OpenStreetMap map tiles
      addMarkers(lng=c(info$lon_old, info$lon_new), lat=c(info$lat_old, info$lat_new), popup=paste("Distance:", info$meters))
  })
  
  output$distance <- renderText({ 
    #Get reactive information from ships longest distance 
    info <-information()
    
    # Return distance traveled
    paste(info$meters, 'M')
  })
  
  # Define ship type output
  output$type_ship <- renderText({ 
    # Get reactive information from ships longest distance 
    info <-information()
    
    # Return type of ship
    info$type
  })
  
  # Define ship id output
  output$id_ship <- renderText({ 
    # Get reactive information from ships longest distance 
    info <-information()
    
    # Return id of ship
    paste0('Ship: ', info$ship)
  })
  
}
