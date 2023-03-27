library(tidyverse)
library(gganimate)
install.packages('gifski')
library(gifski)
titanic <- read.csv("titanic.csv")

mtcars
p <- ggplot(mtcars, aes(factor(hp), mpg)) + 
  geom_bar(width = 1, stat = "identity") + 
  coord_polar("y", start=0) +
  transition_states(
    gear,
    transition_length = 2,
    state_length = 1
  ) +
  enter_fade() + 
  exit_shrink() +
  ease_aes('bounce-in')
pq <- animate(p, renderer = gifski_renderer())
anim_save('filename2.gif', animation = last_animation(), path = NULL)

tit1 <- titanic %>% 
  ggplot(x="", y= Age)) + 
  geom_bar(width = 1, stat = "identity") + 
  coord_polar("y", start=0) 
tit1
  
  transition_states(
    gear,
    transition_length = 2,
    state_length = 1
  ) +
  enter_fade() + 
  exit_shrink() +
  ease_aes('bounce-in')
titanic_chart <- animate(tit1, renderer = gifski_renderer())
anim_save('titanic1.gif', animation = last_animation(), path = NULL)
