##ChickWeight (Jalyn)

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

  labs(title = 'Days: {frame_time}', x = 'Chick weight (grams)', y = 'Chick number') + #Labels the time as "Days" for the dot plot, labels the x and y axis
  transition_states(Time,  transition_length = 1,
                    state_length = 1) + #Tells rstudio what information the movement of the graph is based on
  ease_aes('linear')#Makes the movement of the graph smooother
  
#In case you get stuck or need further information, don't be afraid to use the animate help page!
?animate



##Task##
#Write code to save the animation and come up with whatever name you want to call that file.
##Hint: Look back at part 1 to see what function you use!##
  anim_save("Chick_Weights_over_time.gif", animation = last_animation(), path = )
  
#Cool! So now we have one graph in motion and saved...let's do another!
#Next we're going to create a bar graph
#Task#
#Assign your graph a name and write code to create a static bar graph where the time is on the y axis and the weight is on the x axis. 
#Answer:
Chickbar <-  ggplot(ChickWeight, aes(x=weight, y=Time, fill=Diet)) + 
    geom_bar(stat='identity')
 
#That wasn't so bad:)
#Now here comes the motion

##Task##
  
#Write code to show the movement in the graph. 
#Feel free to use the previous example as a reference

#Answer:
  
ggplot(ChickWeight, aes(x=weight, y=Time, fill=Diet)) + 
  geom_bar(stat='identity') +
  transition_states(Time,  transition_length = 1,
                     state_length = 1) +
ease_aes('linear')


##Task##
#Write code to save the gif
#Answer:
anim_save("Chick_Weights_over_time2.gif", animation = last_animation(), path = )

#Whoa! Good job now the graph is moving!
#Question: Why might it be important to use gganimate when tidying and working with datasets?

#Answer: gganimate can be useful in seeing change over time for datasets, especially huge datasets full of values.

#Question: What other graphs do you think would  be significant to use in gganimate when you are trying to #visulize datasets?

#Great job! Now let's go use more datasets!

