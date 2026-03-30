# Asked chat how to do the whole thing in ggplot

# re-loading everything I need to get to this point: 
#global administrative data level 1 is state
NEV <- gadm(country = "USA", level = 1, path = ".")
NEV$NAME_1 #get state names 

#level 2 is counties
NV_county <- gadm(country = "USA", level = 2, path = ".")
NV_county <- NV_county[NV_county$NAME_1 == "Nevada", ]

#plot shape of nevada no details
plot(NEV[NEV$NAME_1 == "Nevada", ]) 
nev <- NEV[NEV$NAME_1 == "Nevada", ]

# get elevation (30 seconds resolution)
nv_elevation <- elevation_30s(country = "USA", path = ".", mask=TRUE)

# mask to nevada - cropping just reduces the extent
nv_elevation <- crop(nv_elevation, nev, mask = TRUE) 



# Now chat help: 
# First, convert the spatial raster to a dataframe:
library(terra)
library(ggplot2)
library(sf)

elev_df <- as.data.frame(nv_elevation, xy = TRUE)
colnames(elev_df)[3] <- "elevation"

# convert counties to sf object
NV_county_sf <- st_as_sf(NV_county)

# minus all the data cleaning, re-load dataframe for points: 
mammal_data <- rbind(minimus, umbrinus, urocitellus)



# Plot it all 
ggplot() +
  # Elevation layer
  geom_raster(data = elev_df,
              aes(x = x, y = y, fill = elevation)) +
  
  # Custom elevation colors
  scale_fill_gradientn(
    colors = c("darkgreen", "gold", "brown", "white"),
    name = "Elevation"
  ) +
  # County boundaries
  geom_sf(data = NV_county_sf,
          fill = NA,
          color = "black",
          linewidth = 0.3) +
  # Points
  geom_point(data = mammal_data,
             aes(x = lon, y = lat, color = species),
             size = 1.5,
             alpha = 0.6) +
  
  # Manual species colors
  scale_color_manual(values = c(
    "Tamias minimus" = "blue",
    "Tamias umbrinus" = "green",
    "Urocitellus beldingi" = "red",
    "Urocitellus mollis" = "yellow"
  )) +
  
  coord_fixed() +
  theme_classic()




















ggplot() +
  # Elevation
  geom_raster(data = elev_df,
              aes(x = x, y = y, fill = elevation)) +
  
  scale_fill_gradientn(
    colors = c("darkgreen", "gold", "brown", "black")
  ) +
  
  # County boundaries
  geom_sf(data = NV_county_sf,
          fill = NA,
          color = "black",
          linewidth = 0.3) +
  
  # Points
  geom_point(data = mammal_data,
             aes(x = lon, y = lat, color = species),
             size = 1.5) +
  
  # Manual species colors
  scale_color_manual(values = c(
    "Tamias minimus" = "blue",
    "Tamias umbrinus" = "green",
    "Urocitellus beldingi" = "red",
    "Urocitellus mollis" = "yellow"
  )) +
  
  
  coord_sf() +
  theme_classic()


