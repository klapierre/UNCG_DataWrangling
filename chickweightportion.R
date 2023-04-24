##ChickWeight (Jalyn)

#For the second part of this assignment, you will be working with a data set called ChickWeight. First you will need to load in gganimate so you can see these graphs move!
library(tidyverse)
library(gganimate)
library("gifski")


#The next step is to load in the data set ChickWeight already embedded in R by running the following code:
data(ChickWeight)

#Take a moment to look at the data set. You'll see 4 columns: weight, time, chick, and diet. 

#The weight column is the mass of the chick

#The time represents the amount of days since birth when the weight was taken. 

#The chick column is a unique identifier for the chicks and diet represents which diet each chick received.

#In order to see a graph move, we need to make a graph!
#As an example, run the following code to see the growth of the chicks by creating a scatterplot: 

ChickWeight %>% 
  ggplot(aes(weight, Chick, color=Diet)) + 
  geom_point()

#Next we need to get some gganimate code going!
#Run each line of the following code and annotate each line to say what the role of that code is.
ChickWeight %>% 
  ggplot(aes(weight, Chick, color=Diet)) +
  geom_point() +
  
##TASK##
#For the following code annotate each line for what you think each function does.
labs(title = 'Days: {frame_time}', x = 'Chick weight (grams)', y = 'Chick number') +
  transition_time(Time) +
  ease_aes('linear')
?gganimate

ChickWeight <- p +
  transition_states()



##Task##