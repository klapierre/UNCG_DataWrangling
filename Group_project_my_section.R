# For part  

library(tidyverse)
library(gganimate)
library(gifski)
library(RColorBrewer)

orange <- data.frame(Orange) %>% 
  group_by(Tree) %>% 
  mutate("Sample" = as.numeric(seq(1:7))) %>% 
  ungroup() 

ggplot(orange, aes(age, circumference, color= Tree, size=circumference)) +
  geom_point() +
  scale_fill_brewer(palette = "Set3") +
  transition_time(Sample) +
  labs(title = 'Orange Tree Circumference by Age', x = 'Age in Days', y = 'Circumference in mm')
orange_plot

orange_gif <- animate(orange_plot, renderer = gifski_renderer())
anim_save('orange_gif', animation = last_animation(), path = NULL)

ggplot(orange, aes(age, circumference)) +
  geom_col() +
  scale_fill_brewer(palette = "Set3") +
  facet_wrap("Tree") +
  transition_states(Sample) +
  shadow_mark() 
  
