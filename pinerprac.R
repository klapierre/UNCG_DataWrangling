pines <- read.csv("observations-309667.csv")

llpsubset <- subset(pines, scientific_name == "Pinus palustris")

world <- map_data("world")

ggplot() + geom_polygon(data = world, aes(x=long, y = lat, group = group)) + 
  coord_fixed(1.3) 

ggplot() + geom_polygon(data = world, aes(x=long, y = lat, group = group), fill = "blue", col = "black") + 
  coord_fixed(1.5) + geom_point(data = pines, aes(x = longitude, y = latitude), color = "yellow", size = 0.1)


ggplot() + geom_polygon(data = world, aes(x=long, y = lat, group = group), fill = "blue", col = "black") + 
  coord_fixed(1.5) + geom_point(data = llpsubset, aes(x = longitude, y = latitude), color = "yellow", size = 0.1, pch = 2)
