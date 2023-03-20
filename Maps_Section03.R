install.packages(c("ggplot2", "devtools", "dplyr", "stringr"))

install.packages(c("maps", "mapdata"))

devtools::install_github("dkahle/ggmap")

library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)

chatgpt

install.packages('tidygeocoder')
devtools::install_github("jessecambon/tidygeocoder")

# here is the data set we are going to use
# we only want the starbucks in NY 
# and we only want the columns "latitude" and "longitude"
# tidy it up!

starb <- read.csv("starbucks_2018_11_12.csv", stringsAsFactors = TRUE) %>% 
  subset(city == "New York") %>% 
  select(state, name, latitude, longitude)

