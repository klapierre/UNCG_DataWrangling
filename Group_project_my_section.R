library(tidyverse)
library(gganimate)
install.packages('gifski')
library(gifski)
titanic <- read.csv("titanic.csv")

p <- ggplot(mtcars, aes(factor(cyl), mpg)) + 
  geom_bar(width = 1, stat = "identity") + 
  coord_polar("y", start=0) +
  transition_states(
    gear,
    transition_length = 2,
    state_length = 1
  ) +
  enter_fade() + 
  exit_shrink() +
  ease_aes('sine-in-out')
pq <- animate(p, renderer = gifski_renderer())
anim_save('filename.gif', animation = last_animation(), path = NULL)
