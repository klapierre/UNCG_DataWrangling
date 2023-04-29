# --------------------------------------------------------------------------- #
####                         Welcome to GGanimate!                         ####
# --------------------------------------------------------------------------- #

## Let's get familiar with what GGanimate can actually do - but first, let's go
## ahead and set up our workspace.

install.packages('gganimate')
install.packages("gifski")
library(tidyverse)
library(gganimate)
library(gifski)

## Now that that's done, let's make a graph! We're going to use an embedded set 
## of data called 'iris' - you may remember this dataset from previous classes!

## TASK: Go ahead and load 'iris' in!

iris <- iris

## Graph time! Let's plot species by petal length - this dataset describes 3
## different species of iris by their petal and sepal lengths/widths, so we're 
## going to try to visualize it and see the lengths of each of their petals!

## TASK: Let's use a box and whisker plot for this, and color by species.

ggplot(iris, aes(x=Species, y = Petal.Length, fill=Species)) +
  geom_boxplot()
  

## If at anytime you want more info on GGanim, try this function to pull up the
## help page embedded in R: ?`gganimate-package`

## So now we have a stagnant graph - let's add some flare to it! Annotate the 
## different aspects of this graph and try to explain what each argument is for.

## Hint: Check the GGanimate help page, or the GGanimate website!
## (https://gganimate.com/articles/gganimate.html)

ggplot(iris, aes(x = Species, y = Petal.Length)) +
  geom_boxplot(aes(colour = Species)) +
  transition_states(Petal.Width, # specifies modification to transition states
                    transition_length = 1, # length of transition
                    state_length = 1) # length of pause at each state

## TASK: Play with the values for transition_length and state_length - what's 
## changing? Was this different from what you thought when you were annotating?

ggplot(iris, aes(x = Species, y = Petal.Length)) + 
  geom_boxplot(aes(colour = Species)) +
  transition_states(Petal.Width, 
                    transition_length = 4, 
                    state_length = 2) 


## Hmm... This graph is interesting, but it doesn't really give us a ton of info
## at first glance. Why don't we try and add some labels for our x and y axis,
## and a title for our chart?

ggplot(iris, aes(x = Species, y = Petal.Length)) + 
  geom_boxplot(aes(colour = Species)) +
  transition_states(Petal.Width, 
                    transition_length = 4, 
                    state_length = 2) +
  ylab("Petal Length") +
  ggtitle("Petal Length per Species") +
  enter_grow()+
  exit_fade()

## HINT: If you can't get your graph to look right at first, try just changing
## the graph without the transition states, so the process goes a little faster.

## Let's also add in a fun transition using the enter and exit arguments (just 
## like in PowerPoint!) to get more familiar with the other functions of gganimate.

## HINT: Take a look at ?enter and ?exit



## So now we have a cute little graph, showing the relationship between petal
## length and width by species. But how would we share this graph with other
## researchers, or put it into a presentation? We have to save it as a file!

## To do this we need to use some more new grammar - ggsave!

## First, assign your graph a name and save it into R.
iris_plot <- ggplot(iris, aes(x = Species, y = Petal.Length)) + 
  geom_boxplot(aes(colour = Species)) +
  transition_states(Petal.Width, 
                    transition_length = 4, 
                    state_length = 2) +
  ylab("Petal Length") +
  ggtitle("Petal Length per Species") +
  enter_grow()+
  exit_fade()


## Now that it's saved, we can use the animate() function - using gifski as our
## renderer. Use ?animate to learn some of the other functions, but for our
## purposes you just need to use the graph name and the renderer.

## HINT: Check out babytestfile.R in the original branch for an example, and 
## ?animate for more help with the package.

iris_anim <- animate(iris_plot, renderer = gifski_renderer())

## Finally, we need to save the animation to our computer. Gganimate defaults to
## using the last animation, so we don't need to select it. Use anim_save() for
## this, and check out ?anim_save for more help. (Or, babytestfile.R!)

anim_save('IrisPetalLenth.gif', animation = last_animation(), path = NULL)

## Enjoy your little .gif! Now let's move onto something a little spicier...

# --------------------------------------------------------------------------- #
####                            Chicken Graphs!                            ####
# --------------------------------------------------------------------------- #

#For the second part of this assignment, you will be working with a data set called ChickWeight. First you will need to load in gganimate and gifski packages so you can see these graphs move!
#Make sure you have the gifski package installed before loading in the package.
library(tidyverse)
library(gganimate)
library(gifski)


#The next step is to load in the data set ChickWeight already embedded in R by running the following code:
data(ChickWeight)

#Take a moment to look at the data set. You'll see 4 columns: weight, time, chick, and diet.
#The weight column is the mass of the chick
#The time represents the amount of days since birth when the weight was taken. 
#The chick column is a unique identifier for the chicks and diet represents which diet each chick received.

#In order to see a graph move, we need to make a graph!
#As an example, run the following code to see the growth of the chicks by creating a scatterplot: 

ggplot(ChickWeight, aes(weight, Chick)) + 
  geom_point(aes(color=Diet))

#Next we need to get some gganimate code going!


##TASK##
#For the following code annotate each line for what you think each function does.
ggplot(ChickWeight, aes(weight, Chick)) + #standard setup, dataframe and x/y-axis specified 
  geom_point(aes(color=Diet))+ # points organized by color by diet
  labs(title = 'Days: {frame_time}', x = 'Chick weight (grams)', y = 'Chick number') + #title and axis names
  transition_states(Time,  transition_length = 1, #set transition times
                    state_length = 1) + 
  ease_aes('linear') # linear progression through data points

#In case you get stuck or need further information, don't be afraid to use the animate help page!
?animate

##Task##
#Write code to save the animation and come up with whatever name you want to call that file.
##Hint: Look back at part 1 to see what function you use!##

chicken_plot <- ggplot(ChickWeight, aes(weight, Chick)) + 
  geom_point(aes(color=Diet))+ 
  labs(title = 'Days: {frame_time}', x = 'Chick weight (grams)', y = 'Chick number') +
  transition_states(Time,  transition_length = 1, 
                    state_length = 1) + 
  ease_aes('linear') 
chicken_anim <- animate(chicken_plot, renderer = gifski_renderer())
anim_save('ChickenWeight.gif', animation = last_animation(), path = NULL)

#Cool! So now we have one graph in motion and saved...let's do another!
#Next we're going to create a bar graph
#Task#
#Assign your graph a name and write code to create a static bar graph where the time is on the y axis and the weight is on the x axis. 

chicken_bar <- ggplot(ChickWeight, aes(weight, Time)) + 
  geom_bar(aes(color=Diet)) 

#That wasn't so bad :)
#Now here comes the motion!

##Task##

#Write code to show the movement in the graph. 
#Feel free to use the previous example as a reference

chicken_bar <- ggplot(ChickWeight, aes(weight, Time)) + 
  geom_bar(aes(color=Diet))+ 
  labs(title = 'Days: {frame_time}', x = 'Chick weight (grams)', y = 'Chick number') +
  transition_states(Time,  transition_length = 1, 
                    state_length = 1) + 
  ease_aes('linear') 



##Task##
#Write code to save the gif

chicken_bar_anim <- animate(chicken_bar_1, renderer = gifski_renderer())
anim_save('ChickenWeightBar.gif', animation = last_animation(), path = NULL)

#Whoa! Good job - now the graph is moving!
#Question: Why might it be important to use gganimate when tidying and working with datasets?

#you can show what would be a handful of separate graphs as a single animation.

#Question: What other graphs do you think would  be significant to use in gganimate when you are trying to #visulize datasets?

#gganimate would be a nice addition to map datasets, seeing changes over time

#Great job! Now let's go use more datasets!

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

#The data looks pretty tidy already which is great for us! However, 
#let's change the Tree column to numeric data. It'll make things easier
#for graphing! While we're at it, let's also add a column that states 
#which sampling point each measurement is from!
orange <- data.frame(Orange) %>% 
  mutate("Sample"= rep(c(1:7), times=5)) %>% 
  group_by(Tree, age, circumference, Sample) %>% 
  summarise(Tree=as.numeric(Tree)) %>% 
  ungroup()

#Let's start with our first graph! We're going to create a simple line graph!

line_graph <- ggplot(orange, aes(age, circumference, group = Tree, color = as.factor(Tree))) + #orange dataset, age and circumference set as x and y axis respectively, group trees and deferentiate by color
  scale_colour_brewer(palette = "Dark2") + #setting color palette
  geom_line() + # line graph
  labs(title = 'Orange Tree Circumference by Age', x = 'Age in Days', y = 'Circumference in mm') + #adding/changing labels
  theme(legend.position = "top") + #set legend position
  geom_point(aes(group = seq_along(age)), size=2) #add points over the line graph
line_graph

#TASK: Annotate each line on what it does for the graph
#TASK: play around with the colors, point shapes, and sizes!
display.brewer.all()

#Looks awesome, right? Now, lets add the animation! We're going to have
#it animate in by tree age
line_graph +
  transition_reveal(age)

#Question: When would this type of graph and animation be an appropriate way to communicate your data?
# when following trends

#Now for graph 2!We're going to do a bar graph!

#Let's start by making a simple bar graph
bar_graph <- ggplot(orange, aes(age, circumference, fill=as.factor(Tree))) + # setting up graph like above
  geom_bar(stat="identity", position=position_dodge(), width=10) + # create bar graph
  scale_fill_brewer(palette = "Accent") + # set color scheme
  labs(title = 'Orange Tree Circumference by Age', x = 'Age (Days)', y = 'Circumference (mm)') +
  scale_y_log10()
bar_graph

#TASK: Annotate each line on what it does for the graph
#TASK: Add titles! Change the width! Flip the axis! Cause chaos!!!


#Now for the transitions!
bar_graph +
  transition_states(age) +
  shadow_mark() +
  enter_grow() +
  enter_fade()

#Question: When would this type of graph and animation be an appropriate way to communicate your data?
#similar to dot/line plots it is good for communiating trends

#TASK: Create a "racing bar graph" that shows the change in circumference over time! What you'll need to do is:
#1. Create a bar plot similar to the last example
#2. Add your transition states (including transition_length and state_length)
#3. Add an interactive title using title='{closest_state}'
#4. Change the colors using scale_fill_brewer and Rcolorbrewer
#5. Save as a gif!





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

# --------------------------------------------------------------------------- #
####                      Section 4: *THE* Titanic                         ####
# --------------------------------------------------------------------------- #


# Now that you've had some practice with gganimate, it's time to really test your knowledge!

# In this section, we're going to use the power of gganimate to better display 
# how different factors affected who would survive the sinking of the Titanic

# But first, lets get some new data to mess around with.
# Make sure you have the "titanic.csv" file downloaded from the github branch or Canvas.
# Then load it into R as an object and name it "rawTitanic"



# This data is a passenger list for the RMS Titanic, including information on the
# different passengers' names, if they survived, sex, age, number of siblings/spouses aboard, number of parents/children aboard, ticket number, ticket fare,
# cabin number, passenger class, and where they boarded the ship.

# Take a moment to look it over and see how the different variables are named
# Note that siblings/spouses (SibSp) and parents/children (Parch) are only 2 columns rather than 4

# Question: What problems could the SibSp and Parch columns make for us due to 
# how they are recorded?

#may result in more people than there actually were

# Question: What columns seem to be missing information?

#age and cabin

# Now, as we can see, this data is pretty untidy with lots of empty cells and
# columns that are tricky to work with. So lets trim it down to just what we want

# Task: Make a new dataframe called "titanicTidyAge" and have it only include the
# PassengerId, Survived, Pclass, Name, Sex, and Age columns.
# Filter out any N/A values in any of the cells. Try using the na.omit() function.
# Then make a new column with the age as a 10 year range or age in decades
# (Make sure the highest age is "60+")
titanicTidyAge <- titanic %>% 
  select(c(PassengerId, Survived, Pclass, Name, Sex, Age)) %>% 
  na.omit() %>% 
  mutate(AgeDecade = floor(Age/10)*10) %>% 
  mutate(AgeDecade = ifelse(AgeDecade>=60,
                            "60+",
                            AgeDecade))


# Once you have that we'll make a second data frame named "titanicTidyCabin" 
# 1) Include the PassengerId, Survived, Pclass, Sex, Age, and Cabin columns
# 2) Make a new column that includes just the starting letter from the cabin number, and an N/A if the cell is empty. (try out grepl() functions for this)
# This letter is the deck the cabin was located, A was the topmost deck and B the
# next, and so on
titanicTidyCabin <- titanic %>% 
  select(c(PassengerId, Survived, Pclass, Sex, Age, Cabin)) %>% 
  mutate(Cabin2 = str_extract(Cabin, "[aA-zZ]+")) %>% 
  na.omit()


# Next you'll be using each of those to make a graph.

# Task: Make a bar plot using the titanicTidyAge data frame that:
# 1) Plots Sex against number of survivors 
# 2) Animate the length of the bars by decade age groups
# 3) Include a label for what age range is currently shown
# 4) Be sure to add appropriate x- and y-axes labels and title
# 5) Color the columns something other than the default
# Reminder: You may need to further filter the data frame
titanicTidySurvivors <- titanicTidyAge %>% 
  filter(Survived==1)

ggplot(titanicTidySurvivors, aes(x=Sex, fill = Sex)) +
  geom_bar() +
  transition_states(AgeDecade) +
  scale_fill_brewer(palette = "Dark2") +
  labs(title = "Titanic Passengers Survival by Class", x = "Class", y = "Age (years)")



# Task: Make a scatter plot using the titanicTidyCabin data frame:
# 1) Plotting age of passengers on the y-axes and deck level on the x-axes
# 2) Coloring points by Survived, with point shape by Sex
# 3) Animating the point position by Pclass
# 4) Jitter the points so they don't all overlap
# 5) Add code to display what Pclass you're currently showing
# 6) Add appropriate x- and y-axes labels
# 
# Hint: Try aes(group = seq_along(...)) to get all your points to disappear 
# between frames rather than some disappearing and some moving
# see https://cran.r-project.org/web/packages/gganimate/vignettes/gganimate.html
# for examples

ggplot(titanicTidyCabin, aes(x=Cabin2, y=Age, fill=as.factor(Survived), shape=Sex)) +
  geom_point(aes(group = seq_along(Pclass)), position = "jitter") +
  scale_shape_manual(values = c(21, 24)) +
  transition_states(Pclass) +
  enter_grow() +
  exit_fade() +
  labs(title = "Titanic Passengers Survival by Class", x = "Class", y = "Age (years)")
