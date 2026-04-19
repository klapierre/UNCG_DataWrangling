# Setup -------------------------------------------------------------------
## Load Packages, Files, Directories

# Pacman is a really convenient package for installing and  loading other packages
# install it if you haven't already
# install.packages("pacman")
pacman::p_load(tidyverse,
              gganimate,
              gapminder,
              gifski,
              sf,
              rnaturalearth,
              rnaturalearthdata,
              countrycode)


# gg animate fundamentals -------------------------------------------------####
##Section 1.0: Fundamentals of gganimate

##gganimate is integrated into tidyverse, but just in case load it manually to ensure you have what you need

##Although we will talk about gifski indepth later, it is the easiest way to render and view our animations, so we will need to use it here as well

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
anim_save("temperature.gif", animate(airquality_temp, renderer = gifski_renderer()))

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


# Expanding on gganimate use cases ----------------------------------------

## Task: Load datasets used in this section

data("gapminder")
data("iris")

## These are the two datasets we'll be using for this section! Check them out using
## head() or glimpse()
## Question: Which dataset is inherently time-based and why does that matter for animation?

## Task: Create a filtered gapminder dataset for North America only

## Task: Build a scatterplot of GDP vs life expectancy. Set size to population and
## group by country. Apply a log transform to the x-axis.
## Add transparency, labels, and a theme of your choice. Save this as an object named gap_plot.

## Question: Why is grouping important when animating repeated entities like countries?

## Task: Animate by year using transition_time(). Save this as gap_anim.


## We've already investigated the ease_aes() function using linear easing. This
## changes the ways that our frames are animated together. This is called tweening.
## Let's explore some other tweening use cases!
## Task: Run the code below and descriptively annotate which each function does. 

# -in applies the easing function without any modification
gap_anim + ease_aes('cubic-in')

gap_anim + ease_aes('elastic-in')

gap_anim + ease_aes('circular-in')

gap_anim + ease_aes("bounce-in")
                
# -out applies the easing function in reverse
gap_anim + ease_aes('elastic-in')

gap_anim + ease_aes('circular-in')

gap_anim + ease_aes("bounce-in")
                
# we can combine them into -in-out
gap_anim + ease_aes('circular-in-out')

gap_anim + ease_aes("bounce-in-out")

## QUESTION: What does the -in-out easing argument do to our animation? 
## Hint: Check ?ease_aes().
                
## Question: How does easing change the perception of movement over time?

## gganimate also has view functions to change the framing of our animation
## over our data. 

## Task: Add view_follow() to gap_anim to track evolving clusters

## Question: What does view_follow() do? Why might this be useful?

## Task: Try to apply view_step() to gap_anim.

## This gives us an animation, but something is wrong.
## Question: What is wrong with your animation? Why do you think this is happening
## HINT: Remember that transition_time is continuous. Check out ?view_step()

## Remember that iris dataset we loaded earlier? Now we're gonna switch to it!

## Task: Using iris, plot Petal Length (x) vs Petal Width (y), colored by species.
## Save this as iris_anim. Add the appropiate labels, title, and transition. 
## Remove the legend.
## Hint: For your title, remember that your data are discrete, not continuous.

## We looked at enter_fade() and exit_shrink() previously, let's explore some more 
## animation effects. This, like easing, falls under the umbrella of Tweening!

## Task: Add enter_fade() and exit_fade() effects

## Task: Run the lines of code below and descriptively annotate what each function does.
## Hint: If you're unsure, run them piece-by-piece!

iris_anim + enter_fly(x_loc = 0) + exit_fly(x_loc = 1)

iris_anim + enter_drift(y_mod = 1) + exit_drift(x_mod = 1) 

iris_anim + enter_recolor(color = "pink") + exit_recolor(color = "brown")

iris_anim + enter_grow(size = 10) + exit_shrink(size = 0.1)

iris_anim + enter_grow(size = 0.1) + exit_shrink(size = 10)

iris_ease <- iris_base +
  transition_states(Species) +
  ease_aes("bounce-in-out")

## We can actually combine several transitions together. Let's take iris_anim,
## which has discrete transition_states and apply transition_reveal() by Petal.Length.
## TASK: Run the code below

(iris_reveal <- iris_anim + transition_reveal(Petal.Length))

## Question: What does your animation look like? Why do you think this is the case?
## Hint: Look at the usage for transition_reveal().

## Task: Write 3 lines of code using different shadows to display point trajectories.
## Do not use shadow_null()

iris_reveal + shadow_trail()

iris_reveal + shadow_wake()

iris_reveal + shadow_mark()

## gganimate can also be used to represent spatial data. We're going to bounce back
## to gapminder now! (You could say this section has bounce-in-out easing)

## Task: Run the code below to setup our spatial data.
world_sf <- ne_countries(scale = "medium", returnclass = "sf")
europe_sf <- filter(world_sf, continent == "Europe")
gap_europe <- gapminder %>%
  filter(continent == "Europe",
         year >= 1965) %>%
  mutate(iso_a3 = countrycode::countrycode(country,
                                           "country.name",
                                           "iso3c"))
europe_life <- europe_sf %>%
  left_join(gap_europe, by = "iso_a3")

## Task: Run the code to create an animation of European life expectancy over time.
(europe_anim <- ggplot(europe_life) +
  
  geom_sf(aes(fill = lifeExp),
          color = "white",
          linewidth = 0.2) +
  
  coord_sf(
    xlim = c(-15, 35),
    ylim = c(35, 72),
    expand = FALSE
  ) +
  
  scale_fill_viridis_c(option = "plasma",
                       na.value = "grey90") +
  
  labs(title = "European Life Expectancy Over Time: {frame_time}",
       fill = "Life Expectancy") +
  
  transition_time(year) +
  ease_aes("linear"))

## Question: Why might animations be useful for visualizing spatial data?

## Question: What are some potential weaknesses of animating. 
## Hint: Think about how slow your computer probably ran!
             

# other useful packages ---------------------------------------------------
# gifski, magick, gapminder


