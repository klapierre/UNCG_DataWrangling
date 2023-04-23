# ---------------------------------------------------------------------#
#                     Section 3: More graphs! But now with              #
#                                ~Orange trees~                         #
# ---------------------------------------------------------------------#

#This section is just building off what you've already learned in 
#sections 1 and 2, but with a new data set and new graphs!

#Packages to load, most you should already have but just in case
library(tidyverse)
library(gganimate)
library(gifski)
library(RColorBrewer)

#For this section, we will be using a data set looking at the growth of 
#orange trees, more info on the set can be found here 
#https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/Orange.html

#Lets load the data as a data frame
orange <- data.frame(Orange)

#The data looks pretty tidy already which is great for us! However, # let's change the Tree column to numeric data. It'll make things easier
#for graphing! While we're at it, let's also add a column that states #which sampling point each measurement is from!
orange <- data.frame(Orange) %>% 
  mutate("Sample"= rep(c(1:7), times=5)) %>% 
  group_by(Tree, age, circumference, Sample) %>% 
  summarise(Tree=as.numeric(Tree)) %>% 
  ungroup()

#Let's start with our first graph! We're going to create a simple line graph!

line_graph <- ggplot(orange, aes(age, circumference, group = Tree, color = as.factor(Tree))) +
  scale_colour_brewer(palette = "Dark2") +
  geom_line() +
  labs(title = 'Orange Tree Circumference by Age', x = 'Age in Days', y = 'Circumference in mm') +
  theme(legend.position = "top") +
  geom_point(aes(group = seq_along(age)), size=2) 
line_graph

#TASK: play around with the colors, point shapes, and sizes!
display.brewer.all()

#Looks awesome, right? Now, lets add the animation! We're going to have
#it animate in by tree age
line_graph +
  transition_reveal(age)

#Question: When would this type of graph and animation be an appropriate way to communicate your data?
#To show change over time

#Now for graph 2!We're going to do a bar graph!

#Let's start by making a simple bar graph
bar_graph <- ggplot(orange, aes(age, circumference, fill=as.factor(Tree))) +
  geom_bar(stat="identity", position=position_dodge()) + 
  scale_fill_brewer(palette = "Accent") 
bar_graph

#TASK: Add titles! Change the width! Flip the axis! Cause chaos!!!
bar_graph <- ggplot(orange, aes(age, circumference, fill=as.factor(Tree))) +
  geom_bar(stat="identity", position=position_dodge()) + 
  scale_fill_brewer(palette = "Accent") +
  labs(title = 'Orange Tree Circumference by Age', x = 'Age in Days', y = 'Circumference in mm') +
  theme(legend.position = "top") +
  coord_flip()
bar_graph  

#Now for the transitions!
bar_graph +
  transition_states(age) +
  shadow_mark() +
  enter_grow() +
  enter_fade()

#Question: When would this type of graph and animation be an appropriate way to communicate your data?
#show how data changes over time

#TASK: Create a "racing bar graph" that shows the change in circumference over time! What you'll need to do is:
#1. Create a bar plot similar to the last example
#2. Add your transition states (including transition_length and state_length)
#3. Add an interactive title using title='{closest_state}'
#4. Change the colors using scale_fill_brewer and Rcolorbrewer
#5. Save as a gif!

ggplot(orange, aes(x=age, y=circumference, fill=as.factor(Tree))) + 
  geom_bar(colour="black", stat="identity",
           position=position_dodge()) +
  scale_fill_brewer(palette = "Accent")+
  transition_states(Sample,
  transition_length = 3, state_length = 0, wrap = FALSE) +
  view_follow(fixed_x = TRUE)  +
  ease_aes('linear')+
  enter_fade()+
  exit_fade()

#This is a true racing bar graph that I felt was too complicated to dump on y'all, but wanted to share anyways (because it took me forever to get it to work)! geom_tile allows for the bars to actually pass each other and race
ggplot(orange, aes(circumference, group = Tree)) +  
  geom_tile(aes(y = circumference/2,
                height = circumference, fill = as.factor(Tree),
                width = 5), alpha = 0.8, color = NA) +
  coord_flip(clip = "off", expand = FALSE) +
  scale_y_continuous(labels = scales::comma) +
  scale_x_reverse() +
  transition_states(Sample,
                    transition_length = 3, state_length = 0, wrap = FALSE) +
  view_follow(fixed_x = TRUE)  +
  ease_aes('linear')+
  enter_fade()+
  exit_fade() +
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        panel.background=element_blank(),
        panel.border=element_blank(),
        panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major.x = element_line( size=.1, color="grey" ),
        panel.grid.minor.x = element_line( size=.1, color="grey" ),
        plot.margin = margin(1,1, 1, 2, "cm")) +
  geom_text(aes(y = 0, label = paste(Tree)), vjust = 0.2, hjust = 1) +
  geom_text(aes(y=circumference,label = circumference, hjust=0)) +
  labs(title = 'Circumference over 7 Sampling Points : {closest_state}')

#End of my section

ggplot(orange, aes(circumference, group = Tree, 
                          fill = as.factor(Tree), color = as.factor(Tree))) +
  geom_tile(aes(y = age,
                height = circumference,
                width = 0.9), alpha = 0.8, color = NA) +
  transition_states(Sample, transition_length = 4, state_length = 1) +
  view_follow(fixed_x = TRUE)

+
  geom_text(aes(y = 0, label = paste(Tree)), vjust = 0.2, hjust = 1) +
  geom_text(aes(y=value,label = Value_lbl, hjust=0)) +
  coord_flip(clip = "off", expand = FALSE) +
  scale_y_continuous(labels = scales::comma) +
  scale_x_reverse() 

+
  guides(color = FALSE, fill = FALSE) +
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        legend.position="none",
        panel.background=element_blank(),
        panel.border=element_blank(),
        panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major.x = element_line( size=.1, color="grey" ),
        panel.grid.minor.x = element_line( size=.1, color="grey" ),
        plot.title=element_text(size=25, hjust=0.5, face="bold", colour="grey", vjust=-1),
        plot.subtitle=element_text(size=18, hjust=0.5, face="italic", color="grey"),
        plot.caption =element_text(size=8, hjust=0.5, face="italic", color="grey"),
        plot.background=element_blank(),
        plot.margin = margin(2,2, 2, 4, "cm"))

ggplot(orange, aes(age, group=Tree, fill=as.factor(Tree))) +
  geom_tile(aes(y = circumference,
                height = age,
                width = 5)) + 
  scale_fill_brewer(palette = "Accent") +
  labs(title = 'Orange Tree Circumference by Age', x = 'Age in Days', y = 'Circumference in mm') +
  theme(legend.position = "top")+
  coord_flip()

ggplot(orange, aes(age, circumference, fill=as.factor(Tree))) +
  geom_tile(aes(y = circumference,
                height = age,
                width = 50)) + 
  scale_fill_brewer(palette = "Accent") +
  labs(title = 'Orange Tree Circumference by Age', x = 'Age in Days', y = 'Circumference in mm') +
  theme(legend.position = "top") +
  coord_flip() +
  transition_states(Sample, transition_length = 4, state_length = 1) +
  view_follow(fixed_x = TRUE) +
  labs(title = 'Orange Tree Circumference by Age: Sampling Point {closest_state}')

animate(tile, 200, fps = 20,  width = 1200, height = 1000, 
        renderer = gifski_renderer("gganim.gif"))


ggplot(orange, aes(age, circumference, color= Tree, size=circumference)) +
  geom_point() +
  scale_fill_brewer(palette = "PRGn") +
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
