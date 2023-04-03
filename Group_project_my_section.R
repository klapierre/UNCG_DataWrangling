library(tidyverse)
library(gganimate)
library(gifski)
titanic <- read.csv("titanic.csv")

mtcars
p <- ggplot(mtcars, aes(factor(cyl), mpg)) + 
  geom_boxplot() + 
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

tic <- ggplot(titanic, aes(factor(Pclass), Survived)) + 
  geom_boxplot() + 
  transition_states(
    gear,
    transition_length = 2,
    state_length = 1
  ) +
  enter_fade() + 
  exit_shrink() +
  ease_aes('sine-in-out')
tic1 <- animate(tic, renderer = gifski_renderer())
anim_save('tic.gif', animation = last_animation(), path = NULL)
