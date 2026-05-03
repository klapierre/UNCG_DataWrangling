# Cleaned up final project

# Load packages
library(ggplot2)
library(tidyverse)
library(maps)
library(mapview)
library(terra)
library(sf)
library(geodata)

# Read data
umbrinus <- read.csv("tamias_umbrinus_data.csv")

minimus <- read.csv("tamias_minimus_data.csv")

urocitellus <- read.csv("urocitellus_data.csv")

sorex <- read.csv("sorex_data.csv")

# Check data 
colnames(umbrinus)
colnames(minimus)
colnames(urocitellus)

# Each file has the same 50 columns, in the same order (a blessing)
# I will start by removing the columns that contain data I do not need for mapping (which is a majority of them) 

# Cleaning Tamias umbrinus (Uinta chipmunk) data
umbrinus <- umbrinus %>%
  select(-gbifID, -datasetKey, -occurrenceID,
         -kingdom, -phylum, -class, -infraspecificEpithet,
         -taxonRank,
         -scientificName, -verbatimScientificName,
         -verbatimScientificNameAuthorship,
         -occurrenceStatus,
         -individualCount,
         -publishingOrgKey,
         -coordinateUncertaintyInMeters, -coordinatePrecision,
         -elevationAccuracy,
         -depth, -depthAccuracy,
         -day, -month,
         -taxonKey, -speciesKey,
         -collectionCode, -catalogNumber, -recordNumber,
         -identifiedBy, -dateIdentified,
         -license, -rightsHolder, -recordedBy, -typeStatus,
         -establishmentMeans, -lastInterpreted, 
         -mediaType, -issue)

# Cleaning Tamias minimus (Least chipmunk) data
minimus <- minimus %>%
  select(-gbifID, -datasetKey, -occurrenceID,
         -kingdom, -phylum, -class, -infraspecificEpithet,
         -taxonRank,
         -scientificName, -verbatimScientificName,
         -verbatimScientificNameAuthorship,
         -occurrenceStatus,
         -individualCount,
         -publishingOrgKey,
         -coordinateUncertaintyInMeters, -coordinatePrecision,
         -elevationAccuracy,
         -depth, -depthAccuracy,
         -day, -month,
         -taxonKey, -speciesKey,
         -collectionCode, -catalogNumber, -recordNumber,
         -identifiedBy, -dateIdentified,
         -license, -rightsHolder, -recordedBy, -typeStatus,
         -establishmentMeans, -lastInterpreted, 
         -mediaType, -issue)

# Cleaning Urocitellus beldingi/mollis (Beldings ground squirrel and Piute ground squirrel) data
urocitellus <- urocitellus %>%
  select(-gbifID, -datasetKey, -occurrenceID,
         -kingdom, -phylum, -class, -infraspecificEpithet,
         -taxonRank,
         -scientificName, -verbatimScientificName,
         -verbatimScientificNameAuthorship,
         -occurrenceStatus,
         -individualCount,
         -publishingOrgKey,
         -coordinateUncertaintyInMeters, -coordinatePrecision,
         -elevationAccuracy,
         -depth, -depthAccuracy,
         -day, -month,
         -taxonKey, -speciesKey,
         -collectionCode, -catalogNumber, -recordNumber,
         -identifiedBy, -dateIdentified,
         -license, -rightsHolder, -recordedBy, -typeStatus,
         -establishmentMeans, -lastInterpreted, 
         -mediaType, -issue)

# Cleaning sorex (shrew) data
sorex <- sorex %>%
  select(-gbifID, -datasetKey, -occurrenceID,
         -kingdom, -phylum, -class, -infraspecificEpithet,
         -taxonRank,
         -scientificName, -verbatimScientificName,
         -verbatimScientificNameAuthorship,
         -occurrenceStatus,
         -individualCount,
         -publishingOrgKey,
         -coordinateUncertaintyInMeters, -coordinatePrecision,
         -elevationAccuracy,
         -depth, -depthAccuracy,
         -day, -month,
         -taxonKey, -speciesKey,
         -collectionCode, -catalogNumber, -recordNumber,
         -identifiedBy, -dateIdentified,
         -license, -rightsHolder, -recordedBy, -typeStatus,
         -establishmentMeans, -lastInterpreted, 
         -mediaType, -issue)

# Rename columns 
umbrinus <- rename(.data=umbrinus,   
                   country=countryCode,
                   state=stateProvince,,
                   date=eventDate,
                   lat=decimalLatitude,
                   lon=decimalLongitude,
                   institution=institutionCode)

minimus <- rename(.data=minimus,   
                  country=countryCode,
                  state=stateProvince,,
                  date=eventDate,
                  lat=decimalLatitude,
                  lon=decimalLongitude,
                  institution=institutionCode)

urocitellus <- rename(.data=urocitellus,   
                      country=countryCode,
                      state=stateProvince,,
                      date=eventDate,
                      lat=decimalLatitude,
                      lon=decimalLongitude,
                      institution=institutionCode)

sorex <- rename(.data=sorex,   
                country=countryCode,
                state=stateProvince,,
                date=eventDate,
                lat=decimalLatitude,
                lon=decimalLongitude,
                institution=institutionCode)

# Combining dataframes so all species are represented in one df
NV_mammal_data <- rbind(minimus, umbrinus, urocitellus, sorex)

tamias <- rbind(umbrinus, minimus)

# Save mammal_data object ------------------------------------------------------
# Now I am going to save this cleaned up dataframe as an object so I don't have to re-run all of those lines each time I need the object: 
# Now I am going to save this cleaned up dataframe as an object so I don't have to re-run all of those lines each time I need the object: 
save(NV_mammal_data, file = "NV_mammal_data")
load("NV_mammal_data")

# saving by genus - sorex
save(sorex, file = "sorex_data")
load("sorex_data")

# saving by genus - tamias
save(tamias, file = "tamias_data")
load("tamias_data")

# saving by genus - urocitellus
save(urocitellus, file = "urocitellus_data")
load("urocitellus_data")

# Building the map using maps() ------------------------------------------------

# Using the function map_data() within the maps package, we can build a dataframe that provides all counties within Nevada
NV_map <- map_data("county", region = "nevada")

# Plotting Nevada map with target species captures
ggplot() +
  geom_polygon(data = NV_map,
               aes(x = long, y = lat, group = group),
               fill = "white",
               color = "black") +
  theme_classic() +
  coord_fixed(1.25) +
  geom_point(data = mammal_data,
             aes(x = lon, y = lat, color = species),
             size = 1,
             alpha = 0.7)


# Different method for building map with elevation raster----------------------

# This is how a former undergrad mentor of mine taught me how to read in climate/elevation data using the geodata package. I am now trying to figure out how to combine my ggplot/dataframe point data from above with the chunk of code below, but the following material is creating spatial vectors, so I will need to transform my mammal dataframe as well 

library(geodata)

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

# plot the counties on top of map 
NV_map <- lines(NV_county)

# Now that I have this base map built, I need to fix my data point object so that I can combine the material

# Because the elevation map is being plotted with plot() (base R), the sf or dataframe points won’t automatically layer on top unless the are converted to a compatible spatial format.

# convert mammal data to georeferenced object (joining lat and long)
sf_mamm <- NV_mammal_data %>% 
  st_as_sf(coords = c("lon", "lat"),
           crs = 4326)

# Convert sf object to a spatial vector
mamm_vect <- vect(sf_mamm)

# Make sure CRS matches raster
crs(mamm_vect) <- crs(nv_elevation)

# Now plot together and save as JPEG:
# Open a high-quality JPEG device
jpeg("nv_target_map.jpg", width = 3000, height = 3000, res = 375)

# Plot elevation
plot(nv_elevation, col = terrain.colors(100))

# Add county boundaries
lines(NV_county, alpha = .1)

#   FIGURE 1
# Now plot together and save as JPEG:   
jpeg("nv_summer_species.jpg", width = 3000, height = 3000, res = 300)

# Plot elevation
plot(nv_elevation, col = hcl.colors(100, palette = "BluYl"))

# Add county boundaries
lines(NV_county, alpha = .4)

# Assign custom species point colors
species_colors <- c("Sorex vagrans" = "hotpink",
                    "Sorex palustris" = "black",
                    "Urocitellus mollis" = "#FF6347",
                    "Urocitellus beldingi" = "grey30",
                    "Tamias minimus" = "#CDCD00",
                    "Tamias umbrinus" = "white")

point_cols <- species_colors[mamm_vect$species]

# Plot points onto map
points(mamm_vect,
       col= "black",
       bg = scales::alpha(point_cols, 0.5),
       pch = 21,
       cex = 1,
       alpha = 0.6)

# Add legend
legend("bottomleft",
       inset = c(0.20, 0.05), 
       legend = names(species_colors),
       pt.bg = scales::alpha(species_colors, 0.9), 
       col = "black",                               
       pch = 21,
       pt.cex = 1,
       title = "Species")

# Close the device 
dev.off()


# McLean lab data target specimen map ------------------------------------------

# Now I want to make the same map, but only plot specimens collected by McLean lab on previous field expeditions
# I already have a cleaned dataset of UNCG specimens that I downloaded from Arctos, where more of our most recent capture data has been uploaded

# filter only UNCG specimens from institution column
UNCG_mammal_data <- read_csv("NV_targets_species.csv")

unique(UNCG_mammal_data$species)

# Nevada map
NV_map <- map_data("county", region = "nevada")

# Plotting Nevada map with target species captures
ggplot() +
  geom_polygon(data = NV_map,
               aes(x = long, y = lat, group = group),
               fill = "white",
               color = "black") +
  theme_classic() +
  coord_fixed(1.25) +
  geom_point(data = UNCG_mammal_data,
             aes(x = lon, y = lat, color = species),
             size = 1,
             alpha = 0.7) 


# Applying elevation raster to map
library(geodata)

#global administrative data level 1 is state
NEV <- gadm(country = "USA", level = 1, path = ".")

# level 2 is counties
NV_county <- gadm(country = "USA", level = 2, path = ".")

# remove counties outside of nevada for map clarity: 
NV_county <- NV_county[NV_county$NAME_1 == "Nevada", ]

#plot shape of nevada no details
plot(NEV[NEV$NAME_1 == "Nevada", ]) 
nev <- NEV[NEV$NAME_1 == "Nevada", ]

# get elevation (30 seconds resolution)
nv_elevation <- elevation_30s(country = "USA", path = ".", mask=TRUE)

# mask to nevada - cropping just reduces the extent
nv_elevation <- crop(nv_elevation, nev, mask = TRUE) 

# using terra to map
plot(nv_elevation, col = terrain.colors(215))

# plot the counties on top of map 
NV_map <- lines(NV_county)

# convert mammal data to georeferenced object (joining lat and long)
UNCG_sf_mamm <- UNCG_mammal_data %>% 
  st_as_sf(coords = c("lon", "lat"),
           crs = 4326)

# Convert sf object to a spatial vector
UNCG_mamm_vect <- vect(UNCG_sf_mamm)

# Make sure CRS matches raster
crs(UNCG_mamm_vect) <- crs(nv_elevation)



#   FIGURE 2
# Open a high-quality JPEG device
jpeg("UNCG_target_map.jpg", width = 3000, height = 3000, res = 275)

# Plot elevation
plot(nv_elevation, col = terrain.colors(215))

# Add county boundaries
lines(NV_county, alpha = .3)

# Assign custom species point colors
species_colors <- c("Tamias minimus" = "#0293C7",
                    "Tamias umbrinus" = "ivory3",
                    "Urocitellus beldingi" = "#CD0000")

point_cols <- species_colors[UNCG_mamm_vect$species]

# Plot points onto map
points(UNCG_mamm_vect,
       col = "black",
       bg = scales::alpha(point_cols, 0.2),
       pch = 21,
       cex = 1.5,
       alpha = 0.6)

# Add legend
legend("bottomleft",
       inset = c(0.20, 0.05), 
       legend = names(species_colors),
       col = species_colors,
       pch = 21,
       title = "Species")

# Close the device 
dev.off()


# First attempt at thesis project target species elevation maps - built from Arctos data, only preserved specimen records (less accurate) ------------------
arctos_data <- read.csv("arctos_target_species.csv")

colnames(arctos_data)

# cleaning data: removing columns
arctos_data <- arctos_data %>%
  select(-USE_LICENSE_URL,
         -MINIMUM_ELEVATION)

# changing column names
arctos_data <- rename(.data=arctos_data,                                                              country=COUNTRY,
                      state=STATE_PROV,
                      locality=SPEC_LOCALITY,
                      date=VERBATIM_DATE,
                      lat=DEC_LAT,
                      lon=DEC_LONG,
                      elevation=MAXIMUM_ELEVATION,
                      sex=SEX,
                      life_stage=LIFE_STAGE,
                      genus=GENUS,
                      order=PHYLORDER,
                      family=FAMILY,
                      species=SPECIES)

# removing rows without elevation data
arctos_data <- arctos_data %>%
  drop_na(elevation)

# subset tamias genus data 
tamias <- arctos_data %>%
  filter(species == "Tamias minimus" | species == "Tamias umbrinus")

# subset urocitellus genus data
urocitellus <- arctos_data %>%
  filter(species == "Urocitellus mollis" | species == "Urocitellus beldingi")

#   FIGURE 3
# creating Tamias histogram based on elevation 
ggplot(tamias, aes(x = elevation,
                   fill = species)) + 
  scale_fill_manual(values = c("#88bc5e", "#364b25")) +
  geom_histogram(binwidth=100) +
  xlim(1500, 10000) +
  theme_classic() +
  labs(title = "Tamias elevation")

#   FIGURE 4
# creating Urocitellus histogram based on elevation 
ggplot(urocitellus, aes(x = elevation,
                        fill = species)) + 
  scale_fill_manual(values = c("#812c1f", "#d74a35")) +
  geom_histogram(binwidth=100) +
  xlim(1500, 10000) +
  theme_classic() +
  labs(title = "Urocitellus elevation")

# new attempt at elevation maps - built from GBIF specimen records (all types, more accurate) ----------------------------------------------------------------
species_accounts <- read.csv("all_accounts.csv")

# remove columns
species_accounts <- species_accounts %>%
  select(-gbifID, -datasetKey, -occurrenceID,
         -kingdom, -phylum, -class, -infraspecificEpithet,
         -taxonRank,
         -scientificName, -verbatimScientificName,
         -verbatimScientificNameAuthorship,
         -occurrenceStatus,
         -individualCount,
         -publishingOrgKey,
         -coordinateUncertaintyInMeters, -coordinatePrecision,
         -elevationAccuracy,
         -depth, -depthAccuracy,
         -day, -month,
         -taxonKey, -speciesKey,
         -collectionCode, -catalogNumber, -recordNumber,
         -identifiedBy, -dateIdentified,
         -license, -rightsHolder, -recordedBy, -typeStatus,
         -establishmentMeans, -lastInterpreted, 
         -mediaType, -issue)

# Rename columns 
species_accounts <- rename(.data=species_accounts,   
                           country=countryCode,
                           state=stateProvince,,
                           date=eventDate,
                           lat=decimalLatitude,
                           lon=decimalLongitude,
                           institution=institutionCode)

# removing rows without elevation data
species_accounts <- species_accounts %>%
  drop_na(elevation)

# subset tamias genus data 
tamias <- species_accounts %>%
  filter(species == "Tamias minimus" | species == "Tamias umbrinus")

# subset urocitellus genus data
urocitellus <- species_accounts %>%
  filter(species == "Urocitellus mollis" | species == "Urocitellus beldingi")

#   FIGURE 5
# creating Tamias histogram based on elevation 
ggplot(tamias, aes(x = elevation,
                   fill = species)) + 
  scale_fill_manual(values = c("#88bc5e", "#364b25")) +
  geom_histogram(binwidth=80) +
  xlim(1000, 3500) +
  ylim(0, 150) +
  theme_classic() +
  labs(title = "Tamias elevation")

#   FIGURE 6
# creating Urocitellus histogram based on elevation 
ggplot(urocitellus, aes(x = elevation,
                        fill = species)) + 
  scale_fill_manual(values = c("#812c1f", "#d74a35")) +
  geom_histogram(binwidth=80) +
  xlim(1000, 3000) +
  ylim(0, 30) +
  theme_classic() +
  labs(title = "Urocitellus elevation")



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
plot(nv_crop, col = hcl.colors(100, palette = "BluYl"))
lines(NV_county)



# convert sorex data for map ---------------------------------------------------
sf_sorex <- sorex %>% 
  st_as_sf(coords = c("lon", "lat"),
           crs = 4326)

# Convert sf object to a spatial vector
sorex_vect <- vect(sf_sorex)

# Make sure CRS matches raster
crs(sorex_vect) <- crs(nv_elevation)

#   FIGURE 7
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



# convert urocitellus data for map --------------------------------------------
sf_urocitellus <- urocitellus %>% 
  st_as_sf(coords = c("lon", "lat"),
           crs = 4326)

# Convert sf object to a spatial vector
urocit_vect <- vect(sf_urocitellus)

# Make sure CRS matches raster
crs(urocit_vect) <- crs(nv_elevation)

#   FIGURE 8
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



# convert tamias data for map -------------------------------------------------
sf_tamias <- tamias %>% 
  st_as_sf(coords = c("lon", "lat"),
           crs = 4326)

# Convert sf object to a spatial vector
tamias_vect <- vect(sf_tamias)

# Make sure CRS matches raster
crs(tamias_vect) <- crs(nv_elevation)

#   FIGURE 9
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

