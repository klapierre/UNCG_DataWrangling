# Part 3! Plotting change over time ? 

#Packages to load
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
  
ggplot(orange, aes(age, circumference)) + 
  geom_boxplot() + 
  transition_states(
    Sample,
    transition_length = 2,
    state_length = 1
  ) +
  enter_fade() + 
  exit_shrink() +
  ease_aes('sine-in-out')

ggplot(orange, aes(age, circumference, group = Tree, color = Tree)
) +
  geom_line() +
  scale_color_viridis_d() +
  labs(title = 'Orange Tree Circumference by Age', x = 'Age in Days', y = 'Circumference in mm') +
  theme(legend.position = "top") +
  geom_point((aes(group = seq_along(age)))) +
  transition_reveal(age)

ggplot(orange, aes(age, circumference, fill = Tree)) +
  geom_col() +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    panel.grid.major.y = element_line(color = "white"),
    panel.ontop = TRUE
  ) +
  facet_wrap(~Tree) +
  transition_states(age, wrap = FALSE) +
  shadow_mark()
