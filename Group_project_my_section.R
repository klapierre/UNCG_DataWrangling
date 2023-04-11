library(tidyverse)
library(gganimate)
library(gifski)
library(RColorBrewer)

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

orange <- data.frame(Orange) %>% 
  group_by(Tree) %>% 
  mutate("Sample" = as.numeric(seq(1:7))) %>% 
  ungroup() 

  pivot_wider(names_from = "Sample", values_from = c(age, circumference))

ggplot(orange, aes(circumference, age, color= Tree, size=circumference)) +
  geom_point() +
  scale_fill_brewer(palette = "Set3") +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  transition_time(Sample) +
  labs(title = 'Size by Age', x = 'Age in Days', y = 'Circumference in mm')
orange_plot

orange_gif <- animate(orange_plot, renderer = gifski_renderer())
anim_save('orange_gif', animation = last_animation(), path = NULL)
