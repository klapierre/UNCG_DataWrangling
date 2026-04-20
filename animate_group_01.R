# Setup -------------------------------------------------------------------
## Load Packages, Files, Directories

pacman::p_load(tidyverse,
              gganimate,
              gapminder,
              gifski)


# gg animate fundamentals -------------------------------------------------####
##Section 1.0: Fundamentals of gganimate

##Task: First, gganimate is integrated into tidyverse, but just in case load the packages below to ensure you have what you need

##Although we will talk about gifski indepth later, it is the easiest way to render and view our animations, so we will need to use it here as well

install.packages("ggplot2")
install.packages("gganimate")
install.packages("gifski")

##Task: Now write code to load all the packages so that we can use them

##Task: For this assignment we are going to use a dataset built into R, Load it usingthe code below

data("airquality")

##IMPORTANT: gganimate saves your animation as individual frames in your working directory

##Task: To prevent clutter, make a new folder in your current working directory and call it "gganimate", then set that folder as your working directory. (We will delete this folder, and change working directory at the end)

##Task: Write code using the head() function to get a glimpse of the dataset

##Question: One of the most basic animations is showing change overtime, what columns in could we use to show this?

##Task: Below is the skeleton of a line plot, rewrite the code to have Day as the x axis and temp as the y axis, then give the plot a discriptive title

ggplot(airquality, aes(x = ?, y = ?)) +
  geom_line()

##Task: Run the code below

airquality_temp <- ggplot(airquality, aes(x = Day, y = Temp)) +
  geom_line() +
  labs(title = "Temperature Over Days") +
  transition_time(Month)
anim_save("temperature.gif", animate(airquality_temp, renderer = gifski_renderer()))

##Task: Now run this code

airquality_temp <- ggplot(airquality, aes(x = Day, y = Temp)) +
  geom_line() +
  labs(title = "Temperature Over Days") +
  transition_time(Month)
animate(airquality_temp)

#Question: What is the difference in saved outcome between the two codes?

##Question: What is the animate() function doing?

##Question: What happens if we take out the transition_time() function?

##Now that we have a simple animation we can apply other functions to make the
##Animation easier to view and understand

##Task: The transition_time function can be integrated into labs to create ##descriptive titles for your animation: See by running the code below

airquality_temp <- ggplot(airquality, aes(x = Day, y = Temp)) +
  geom_line() +
  labs(title = "Month: {frame_time}") +
  transition_time(Month)
anim_save("temperature_titles.gif", animate(airquality_temp, renderer = gifski_renderer()))

##Question: What is the new title of the graph?

##Question: Why would someone choose to use the {frame_time} argument instead of just typing a whole new title?

##Question: Transitions can be used to control how smooth the animation plays
##What are some characteristics of the animation that might be helpful to modify?

##Run the code below
airquality_temp <- ggplot(airquality, aes(x = Day, y = Temp)) +
  geom_line() +
  ease_aes('linear')+
  labs(title = "Month: {frame_time}") +
  transition_time(Month)
anim_save("temperature_ease.gif", animate(airquality_temp, renderer = gifski_renderer()))

##Annotate the code above with descriptive comments
##Not only can speed be adjusted, but you can also add motion effects
airquality_temp <- ggplot(airquality, aes(x = Day, y = Temp)) +
  geom_line() +
  ease_aes('linear')+
  labs(title = "Month: {frame_time}") +
  shadow_trail()+
  transition_time(Month)
anim_save("temperature_trail.gif", animate(airquality_temp, renderer = gifski_renderer()))

airquality_temp <- ggplot(airquality, aes(x = Day, y = Temp)) +
  geom_line() +
  ease_aes('linear')+
  labs(title = "Month: {frame_time}") +
  shadow_mark()+
  transition_time(Month)
anim_save("temperature_mark.gif", animate(airquality_temp, renderer = gifski_renderer()))

##Question: What is the difference between shadow_trail and shadow_mark?

##transition_time gives us continuous animations, but we can also use transition_states to make discrete ones instead

##Quesion: Considering what you know about different graphs in ggplot, what types of graph should you use transition_states() instead of transition_time()?

##Below is an example of using transition_states()

airquality_discrete <- ggplot(airquality, aes(x = Day, y = Temp)) +
  geom_point() +
  transition_states(Month) +
  labs(title = "Month: {closest_state}")
anim_save("temperature_states.gif", animate(airquality_discrete, renderer = gifski_renderer()))

##Question: Other than the type of graph, what is the main difference in the code when using transition_states() instead of transition_time()?

##Below is an example using a 3rd transition, transition_reveal()

airquality_reveal <- ggplot(airquality, aes(x = Day, y = Temp)) +
  geom_line() +
  transition_reveal(Day)
anim_save("temperature_reveal.gif", animate(airquality_reveal, renderer = gifski_renderer()))

##Task/Question: Use the the help tab and the animation above to describe what transition_reveal does.

##If you have more complicated data, you can also use transition_components to animate by group, see below

airquality_group <- ggplot(airquality, aes(x = Day, y = Temp)) +
  geom_col() +
  ease_aes("linear") +
  labs(title = "Month: {frame_time}") +
  transition_time(Month)
anim_save("temperature_components.gif", animate(airquality_group, renderer = gifski_renderer()))

##Question: When would using transition_components be the most beneficial in visualizing data?

##Just like when you are animating a slideshow, often having elements disapear in
##in interesting ways helps draw people to your visual. In gganimate you can do 
##this by using enter and exit functions

airquality_discrete +
  enter_fade()+
  exit_shrink()

##Task: rewrite the code above to utilize alternative enter and exit functions: https://gganimate.com/reference/enter_exit.html

##Question: Take a look at the help for the animate() function, what other arguments can be used?

##Task: Using the airquality_temp animation, adjust the animation to have a height of ##400, a width of 600, 100 frames, and have a speed of 10 frames per second

##Task: Fix the code below, and insert comments to to inform on the changes you made

##There are 3 mistakes, hint, it should not be a line graph, and all other functions are correct, only the arguments may be incorrect

airquality_discrete <- ggplot(airquality, aes(x = Day, y = Temp)) +
  geom_line() +
  transition_states(Month) +
  labs(title = "Day: {frame_time}")
anim_save("temperature_discrete2.gif", animate(airquality_discrete, renderer = gifski_renderer()))

##Now it is time to test your skills. Make a new animation that shows ozone levels overtime. Call it airquality_ozone. Use a shadow functions, an ease_aes() function, and either an enter or exit function.

##GREAT JOB!!!

##Reminder to reset your working directory


# other useful packages ---------------------------------------------------
# gifski, magick, gapminder


