# cropping map
library(geodata)
library(terra)
library(sf)

# Loading in mammal data
load("NV_mammal_data")
load("sorex_data")
load("tamias_data")
load("urocitellus_data")

# Building map -----------------------------------------------------------------
# global administrative data level 1 is state
NEV <- gadm(country = "USA", level = 1, path = ".")

# level 2 is counties
NV_county <- gadm(country = "USA", level = 2, path = ".")

# remove counties outside of nevada for map clarity: 
NV_county <- NV_county[NV_county$NAME_1 == "Nevada", ]

# plot shape of nevada no details
plot(NEV[NEV$NAME_1 == "Nevada", ]) 
nev <- NEV[NEV$NAME_1 == "Nevada", ]

# get elevation (30 seconds resolution)
nv_elevation <- elevation_30s(country = "USA", path = ".", mask=TRUE)

# mask to nevada - cropping just reduces the extent
nv_elevation <- crop(nv_elevation, nev, mask = TRUE) 

# using terra to map
plot(nv_elevation, col = terrain.colors(215))

# CROP MAP ---------------------------------------------------------------------
# Toiyabe approximate coordinates
toiyabe <- c(-117.948733, 38.457651)

# Ruby approximate coordinates 
ruby <- c(-114.802819, 41.230889)

# Creating a bounding box
ext_box <- ext(min(toiyabe[1], ruby[1]),  # xmin (west)
               max(toiyabe[1], ruby[1]),  # xmax (east)
               min(toiyabe[2], ruby[2]),  # ymin (south)
               max(toiyabe[2], ruby[2]))   # ymax (north)

# now crop raster to this extent
nv_crop <- crop(nv_elevation, ext_box)

# plot
plot(nv_crop, col = terrain.colors(215))
lines(NV_county)







# convert sorex data for map ---------------------------------------------------
sf_sorex <- sorex %>% 
  st_as_sf(coords = c("lon", "lat"),
           crs = 4326)

# Convert sf object to a spatial vector
sorex_vect <- vect(sf_sorex)

# Make sure CRS matches raster
crs(sorex_vect) <- crs(nv_elevation)

#  save ------------------------------------------------------------------------
jpeg("nv_sorex.jpg", width = 3000, height = 3000, res = 300)

# Plot elevation
plot(nv_crop, col = hcl.colors(100, palette = "BluYl"))

# Add county boundaries
lines(NV_county, alpha = .4)

# Assign custom species point colors
sorex_colors <- c("Sorex vagrans" = "hotpink",
                  "Sorex palustris" = "black")

sorex_cols <- sorex_colors[sorex_vect$species]

# Plot points onto map
points(sorex_vect,
       col = scales::alpha(sorex_cols, 0.5),
       pch = 19,
       cex = 1,
       alpha = 0.6)

# Add legend
legend("topleft",
       inset = c(0.20, 0.05), 
       legend = names(sorex_colors),
       col = sorex_colors,
       pch = 19,
       title = "Species")

# Close the device 
dev.off()






# convert urocitellus data for map ---------------------------------------------------
sf_urocitellus <- urocitellus %>% 
  st_as_sf(coords = c("lon", "lat"),
           crs = 4326)

# Convert sf object to a spatial vector
urocit_vect <- vect(sf_urocitellus)

# Make sure CRS matches raster
crs(urocit_vect) <- crs(nv_elevation)

#  save ------------------------------------------------------------------------
jpeg("nv_urocitellus.jpg", width = 3000, height = 3000, res = 300)

# Plot elevation
plot(nv_crop, col = hcl.colors(100, palette = "BluYl"))

# Add county boundaries
lines(NV_county, alpha = .4)

# Assign custom species point colors
urocit_colors <- c("Urocitellus mollis" = "#FF6347",
                  "Urocitellus beldingi" = "grey30")

urocit_cols <- urocit_colors[urocit_vect$species]

# Plot points onto map
points(urocit_vect,
       col = scales::alpha(urocit_cols, 0.5),
       pch = 19,
       cex = 1,
       alpha = 0.6)

# Add legend
legend("topleft",
       inset = c(0.20, 0.05), 
       legend = names(urocit_colors),
       col = urocit_colors,
       pch = 19,
       title = "Species")

# Close the device 
dev.off()








# convert tamias data for map ---------------------------------------------------
sf_tamias <- tamias %>% 
  st_as_sf(coords = c("lon", "lat"),
           crs = 4326)

# Convert sf object to a spatial vector
tamias_vect <- vect(sf_tamias)

# Make sure CRS matches raster
crs(tamias_vect) <- crs(nv_elevation)

#  save ------------------------------------------------------------------------
jpeg("nv_tamias.jpg", width = 3000, height = 3000, res = 300)

# Plot elevation
plot(nv_crop, col = hcl.colors(100, palette = "BluYl"))

# Add county boundaries
lines(NV_county, alpha = .4)

# Assign custom species point colors
tamias_colors <- c("Tamias minimus" = "#CDCD00",
                  "Tamias umbrinus" = "white")

tamias_cols <- tamias_colors[tamias_vect$species]

# Plot points onto map
points(tamias_vect,
       col = scales::alpha(tamias_cols, 0.5),
       pch = 19,
       cex = 1,
       alpha = 0.6)

# Add legend
legend("topleft",
       inset = c(0.20, 0.05), 
       legend = names(tamias_colors),
       col = tamias_colors,
       pch = 19,
       title = "Species")

# Close the device 
dev.off()
