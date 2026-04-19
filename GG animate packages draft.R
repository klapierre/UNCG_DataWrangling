

library(tidyverse)

cells <- read.csv("Cell_Density_Bernhardt.csv")
colnames(cells)
  
  
ggplot(cells, aes(x = temperature, y = cell_density)) +
  geom_point(aes(color = as.factor(cell_density)))

ggplot(cells, aes(x = temperature, y = cell_density)) +
  geom_point() +
  geom_smooth(method = "lm")

cells_clean <- cells %>%
  separate(date, into = c("date", "time"), sep = " ")


ggplot(cells_clean, aes(x = time, y = cell_density)) +
  geom_point()

cells_clean %>%
  slice(1:5) %>%
  ggplot(aes(x = time, y = cell_density)) +
  geom_point()


  
  ggplot(redband, aes(x = Length, y = Weight)) +
    geom_point(aes(color = as.factor(ScaleAge))) +
    geom_smooth(method = "lm",
                formula = y ~ poly(x, 2),
                color = "black",
                size = 2)
  
remove(cells_Clean)



-----

temp <- read.csv("temperature_data_1.cvs")


