#Objectives ---------------------------------------------------------------####

# 1. Understand the core parts of an animation
# 2. Learn how to make a simple animation
# 3. Get fancy with it! How to further customize animations
# 4. Learn how to use packages to improve animations, and make them easier to #create

# Setup -------------------------------------------------------------------
## Load Packages, Files, Directories

# Pacman is a really convenient package for installing and  loading other packages
# install it if you haven't already
install.packages("pacman")
pacman::p_load(tidyverse,
               gganimate,
               gapminder,
               gifski,
               sf,
               rnaturalearth,
               rnaturalearthdata,
               countrycode)


# 1.0 gg animate fundamentals -------------------------------------------------####
##Section 1.0: Fundamentals of gganimate

##gganimate is integrated into tidyverse, but just in case load it manually to 
##ensure you have what you need

##Although we will talk about gifski indepth later, it is the easiest way to render 
##and view our animations, so we will need to use it here as well

##TASK: For this assignment we are going to use a dataset built into R, Load it 
##using the code below

data("airquality")

##IMPORTANT: gganimate saves your animation as individual frames in your working directory

##TASK: To prevent clutter, make a new folder in your current working directory 
##and call it "gganimate", then set that folder as your working directory. (We 
##will delete this folder, and change working directory at the end)
setwd("/Users/a_pandey2/Desktop/github/UNCG_DataWrangling/gganimate")

##TASK: Write code using the head() function to get a glimpse of the dataset
head(airquality)

##QUESTION: One of the most basic animations is showing change overtime, what 
##columns in could we use to show this?
# All the environmental variables like Ozone, Solar.R., Wind, Temp., can be
# used to show changes overtime when combined with time variables like month and
# day.

##TASK: Below is the skeleton of a line plot, rewrite the code to have Day as the 
##x axis and temp as the y axis, then give the plot a descriptive title

ggplot(airquality, aes(x = Day, y = Temp)) +
  geom_line()+
  labs(title = "Temperature Over Days",
       x = "Day",
       y = "Temperature")

##TASK: Run the code below

airquality_temp <- ggplot(airquality, aes(x = Day, y = Temp)) +
  geom_line() +
  labs(title = "Temperature Over Days") +
  transition_time(Month)
anim_save("temperature.gif", animate(airquality_temp, renderer = gifski_renderer()))


##TASK: Now run this code

airquality_temp <- ggplot(airquality, aes(x = Day, y = Temp)) +
  geom_line() +
  labs(title = "Temperature Over Days") +
  transition_time(Month)
animate(airquality_temp)

#QUESTION: What is the difference in saved outcome between the two codes?
# The first one saved as one single gif file while the second lines of code had it
# as multiple files. Animate is previewing the animation while anim_save saved the gif.

##QUESTION: What is the animate() function doing?
# Animate() function is animating the different files as one and previewing

##QUESTION: What happens if we take out the transition_time() function?
airquality_temp <- ggplot(airquality, aes(x = Day, y = Temp)) +
  geom_line() +
  labs(title = "Temperature Over Days")
animate(airquality_temp)
# It gave me an error message.

##Now that we have a simple animation we can apply other functions to make the
##Animation easier to view and understand

##TASK: The transition_time function can be integrated into labs to create 
##descriptive titles for your animation: See by running the code below

airquality_temp <- ggplot(airquality, aes(x = Day, y = Temp)) +
  geom_line() +
  labs(title = "Month: {frame_time}") +
  transition_states(Month)
anim_save("temperature_titles.gif", animate(airquality_temp, renderer = gifski_renderer()))
 
airquality_temp

##QUESTION: What is the new title of the graph?
# It displays different months.

##QUESTION: Why would someone choose to use the {frame_time} argument instead of 
##just typing a whole new title?
# Because it would be a lot of work to add title every time manually.

##QUESTION: Transitions can be used to control how smooth the animation plays
##What are some characteristics of the animation that might be helpful to modify?
# Based on what the frames are generated, speed of the frame.

##Run the code below
airquality_temp <- ggplot(airquality, aes(x = Day, y = Temp)) + # it created a new file to save whatever we do with ggplot from airquality data with Day as x-axis and temp as y-axis
  geom_line() + # it is making a line with those data points
  ease_aes('linear')+ # it makes the animation move with uniform speed
  labs(title = "Month: {frame_time}") + # it makes the title of each month as title as it is animating
  transition_time(Month) # the animation transitioned based on month
anim_save("temperature_ease.gif", animate(airquality_temp, renderer = gifski_renderer())) # airquality_temp is stored as temperature_ease.gif using renderer gifski

##TASK: Annotate the code above with descriptive comments

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

##QUESTION: What is the difference between shadow_trail and shadow_mark?
#Shadow_trail shows evenly spaced trails of past data points as the animation proceeds.
#Shadow_mark shows the past, present, and future trails of data in the animation at the
#same time.

##transition_time gives us continuous animations, but we can also use 
##transition_states to make discrete ones instead

##Quesion: Considering what you know about different graphs in ggplot, what 
##types of graph should you use transition_states() instead of transition_time()?
# transition_states() would be used for discrete, categorical data like in bar graphs 
# instead of continuous time data.

##Below is an example of using transition_states()

airquality_discrete <- ggplot(airquality, aes(x = Day, y = Temp)) +
  geom_point() +
  transition_states(Month) +
  labs(title = "Month: {closest_state}")
anim_save("temperature_states.gif", animate(airquality_discrete, renderer = gifski_renderer()))

##QUESTION: Other than the type of graph, what is the main difference in the code 
##when using transition_states() instead of transition_time()?
airquality_discrete 
#the code used closest_state in the label rather than frame_time.

##Below is an example using a 3rd transition, transition_reveal()

airquality_reveal <- ggplot(airquality, aes(x = Day, y = Temp)) +
  geom_line() +
  transition_reveal(Day)
anim_save("temperature_reveal.gif", animate(airquality_reveal, renderer = gifski_renderer()))

##TASK/QUESTION: Use the the help tab and the animation above to describe what transition_reveal does.
?transition_reveal 
# It makes the data points appear/reveal gradually rather than doing it all at once.

##If you have more complicated data, you can also use transition_components to animate by group, see below

airquality_clean <- na.omit(airquality)
airquality_group <- ggplot(airquality_clean,aes(x = Temp, y = Ozone, group = Month, color = factor(Month))) +
  geom_point(size=2) +
  ease_aes("cubic-in-out") +
  labs(title = "Temperature vs Ozone (Day: {frame_time})",x = "Temperature",y = "Ozone",color = "Month") +
  shadow_trail(alpha=0.3)+
  transition_components(Day)
anim_save("temperature_group.gif", animate(airquality_group, renderer = gifski_renderer(),  nframes = 150,fps = 15,width = 600,height = 400))

#Airquality is not the ideal data set to use with components, but you can 
#still see how each month moves independently from eachother

##QUESTION: When would using transition_components be the most beneficial in visualizing data?
# It would be beneficial when we want to animate single data points or a group components at a time
# rather than entire plot at once.

##Just like when you are animating a slideshow, often having elements disapear in
##in interesting ways helps draw people to your visual. In gganimate you can do 
##this by using enter and exit functions

airquality_discrete +
  enter_fade()+
  exit_shrink()

##TASK: rewrite the code above to utilize alternative enter and exit functions: 
##https://gganimate.com/reference/enter_exit.html

airquality_discrete +
  enter_grow()+
  exit_drift()

##QUESTION: Take a look at the help for the animate() function, what other arguments can be used?
?animate()
#duration, detail, device, ref_frame, start_pause, end_pause, rewind

##TASK: Using the airquality_temp animation, adjust the animation to have a 
##height of ##400, a width of 600, 100 frames, and have a speed of 10 frames per second
animate(airquality_temp, renderer = gifski_renderer(),  nframes = 100,fps = 10,width = 600,height = 400)

##TASK: Fix the code below, and insert comments to to inform on the changes you made
##There are 3 mistakes, hint, it should not be a line graph, and all other functions 
##are correct, only the arguments may be incorrect

airquality_discrete <- ggplot(airquality, aes(x = Day, y = Temp)) +
  geom_line() +
  transition_states(Month) +
  labs(title = "Day: {closest_state}") #changed to closest state
anim_save("temperature_discrete2.gif", animate(airquality_discrete, renderer = gifski_renderer()))

##Now it is time to test your skills. Make a new animation that shows ozone levels 
#overtime. Call it airquality_ozone. Use a shadow functions, an ease_aes() function, 
#and either an enter or exit function.

airquality_ozone <- ggplot(airquality_clean,aes(x = Day, y = Ozone))+
  geom_line() +
  ease_aes("linear") +
  labs(title = "Month: {frame_time}") +
  transition_time(Month)+
  shadow_trail(alpha=0.3)+
  enter_grow()
anim_save("ozone_time.gif", animate(airquality_ozone, renderer = gifski_renderer(),  nframes = 150,fps = 15,width = 600,height = 400))




##GREAT JOB!!!

##Reminder to reset your working directory
setwd("/Users/a_pandey2/Desktop/github/UNCG_DataWrangling")


# 1.1 Expanding on gganimate use cases ----------------------------------------####

## TASK: Load datasets used in this section

data("gapminder")
data("iris")

## These are the two datasets we'll be using for this section! Check them out using
## head() or glimpse()
## QUESTION: Which dataset is inherently time-based and why does that matter for animation?
head (gapminder)
head (iris)
# Gapminder is inherently time-based and it matters for animation because we have been
# looking at rate of change in an independent variable through time. In addition, we have
# also used time to make variations in the speed of animation as well.

## TASK: Create a filtered gapminder dataset for North America only
gapminder_americas <- gapminder %>% 
  filter (country %in% c("United States", "Canada", "Mexico"))

## TASK: Build a scatterplot of GDP vs life expectancy. Set size to population and
## group by country. Apply a log transform to the x-axis.
## Add transparency, labels, and a theme of your choice. Save this as an object named gap_plot.

gap_plot <- ggplot(gapminder_americas,
                   aes(x=gdpPercap,
                       y=lifeExp,
                       size=pop,
                       group=country))+
  geom_point(alpha = 0.5)+
  scale_x_log10()+
  labs(title = "GDP vs Life Expectancy in Americas",
       x = "GDP Per capita",
       y = "Life Expectancy",
       size = "Population")+
  theme_dark()

gap_plot                                    


## QUESTION: Why is grouping important when animating repeated entities like countries?
# So that it is consistently tracked over time.

## TASK: Animate by year using transition_time(). Save this as gap_anim.
gap_anim <- gap_plot+
  transition_time(year)


## We've already investigated the ease_aes() function using linear easing. This
## changes the ways that our frames are animated together. This is called tweening.
## Let's explore some other tweening use cases!
## TASK: Run the code below and descriptively annotate which each function does. 

# -in applies the easing function without any modification
gap_anim + ease_aes('cubic-in') # animation starts slow, accelerates, stops, repeats

gap_anim + ease_aes('elastic-in') # animation has stretching effect

gap_anim + ease_aes('circular-in') #starts slow, accelerates in circular motion

gap_anim + ease_aes("bounce-in") # starts with a bouncing effect

# -out applies the easing function in reverse
gap_anim + ease_aes('elastic-in') #these have same arguments as above? animation has stretching effect

gap_anim + ease_aes('circular-in') #starts slow, accelerates in circular motion

gap_anim + ease_aes("bounce-in") # starts with a bouncing effect 

# we can combine them into -in-out
gap_anim + ease_aes('circular-in-out') # slow start and end

gap_anim + ease_aes("bounce-in-out") # bounce the beginning and the end

## QUESTION: What does the -in-out easing argument do to our animation? 
## Hint: Check ?ease_aes().
# First half of the transition it is applied as it is, while in the last half it is reversed.


## QUESTION: How does easing change the perception of movement over time?
# If it is bounce in, it makes me think of fluctuating within the same time period.
# If it is elastic, it makes me think of very flexible and dymnamic throughout time.

## gganimate also has view functions to change the framing of our animation
## over our data. 

## TASK: Add view_follow() to gap_anim to track evolving clusters
gap_anim+
  view_follow() 

## QUESTION: What does view_follow() do? Why might this be useful?
#It adjusts the plot dimensions so that we can follow the data.

## TASK: Try to apply view_step() to gap_anim.
gap_anim+
  view_step() 

## This gives us an animation, but something is wrong.
## QUESTION: What is wrong with your animation? Why do you think this is happening
## HINT: Remember that transition_time is continuous. Check out ?view_step()
?view_step
# Nothing appeared for me. It should have been because view_step() uses discrete
# data and jumps between frames while years is the continuous data and tracks
# moving frame.

## Remember that iris dataset we loaded earlier? Now we're gonna switch to it!
data("iris")
head(iris)

## TASK: Using iris, plot Petal Length (x) vs Petal Width (y), colored by species.
## Save this as iris_anim. Add the appropiate labels, title, and transition. 
## Remove the legend.
## Hint: For your title, remember that your data are discrete, not continuous.
iris_anim <- ggplot(iris,
                    aes(x = Petal.Length,
                        y = Petal.Width,
                        color = Species))+
  geom_point()+
  labs(title = "Species:{closest_state}",
       x ="Petal Length",
       y = "Petal Width")+
  theme(legend.position = "none")+
  transition_states(Species)

animate(iris_anim)

## We looked at enter_fade() and exit_shrink() previously, let's explore some more 
## animation effects. This, like easing, falls under the umbrella of Tweening!

## TASK: Add enter_fade() and exit_fade() effects
iris_anim+
  enter_fade()+
  exit_fade()

## TASK: Run the lines of code below and descriptively annotate what each function does.
## Hint: If you're unsure, run them piece-by-piece!

iris_anim + enter_fly(x_loc = 0) + exit_fly(x_loc = 1) #points fly in to the plot from left side and exit to the right

iris_anim + enter_drift(y_mod = 1) + exit_drift(x_mod = 1) #points drift in vertically and exit horizontally

iris_anim + enter_recolor(color = "pink") + exit_recolor(color = "brown") #points change color when they appear and disappear

iris_anim + enter_grow(size = 10) + exit_shrink(size = 0.1) #points grow large when appearing and shrink when disappearing

iris_anim + enter_grow(size = 0.1) + exit_shrink(size = 10) #points appear small and grow till they disappear

iris_ease <- iris_anim + #I changed it to iris_anim because iris_base was never introduced # it makes new iris_ease ggplot from iris_anim
  transition_states(Species) + # it transitions between species
  ease_aes("bounce-in-out") # it creates bouncing effect upon entering and exiting

## We can actually combine several transitions together. Let's take iris_anim,
## which has discrete transition_states and apply transition_reveal() by Petal.Length.
## TASK: Run the code below

(iris_reveal <- (iris_anim) + transition_reveal(Petal.Length))

## QUESTION: What does your animation look like? Why do you think this is the case?
## Hint: Look at the usage for transition_reveal().
?transition_reveal()
# The data points appear along the Petal Length as a continuous variable.

## TASK: Write 3 lines of code using different shadows to display point trajectories.
## Do not use shadow_null()

iris_reveal + shadow_trail()

iris_reveal + shadow_wake(wake_length = 0.1) #It asked me to add wake_length here.

iris_reveal + shadow_mark()

## gganimate can also be used to represent spatial data. We're going to bounce back
## to gapminder now! (You could say this section has bounce-in-out easing)

## TASK: Run the code below to setup our spatial data.
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

## TASK: Run the code to create an animation of European life expectancy over time.
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

## QUESTION: Why might animations be useful for visualizing spatial data?
# It helps us understand the change in spatial patterns over time.

## QUESTION: What are some potential weaknesses of animating. 
## Hint: Think about how slow your computer probably ran!
# It needs a lot of space to run the entire data.


# 1.2: FINALE: Other useful packages ---------------------------------------------------####
# gifski, magick, gapminder


#================================
#  Setting up the dataframe:
#  ================================

# As done many times before, we want to make sure that we have all the 
# data neccessary to navigate this last section.

# Please load in "LD_temperature_data_1.csv", this can be located in the 
# Powerpoint and likely to be in canvas as well!

library(tidyverse)
library(dplyr)


temp <- read.csv("LD_temperature_data_1.csv")

# We need to tidy our data before we start graphing the points. 
# First, drop all NA's. Second, separate the dates from the time. 
# We will name this dataframe "tempData".
tempData <- temp %>%
  drop_na() %>%
  separate(Date, into = c("date", "time"), sep = " ") %>%
  mutate(date = as.Date(date, format = "%m/%d/%Y"),time = hms::as_hms(time))

# Now, lets observe the timeTemp dataframe! Do you notice anything that would 
# make this data not ideal to graph? Why or why not?
# Hint: Think about how we would write the ggplot code. How would the datapoints 
# appear on the graph?
tempData
# There are multiple temperature measurements taken at different times for same 
# date, so there could be lots of overlap between points.

# There are only 2 variables that we need to retrieve from tempData: date and
# Air.temperature. Although, there are multiple temperatures with the same date! 
# We can tidy up the number of days by taking the average of each date.
dailyAvg <- tempData %>%
  group_by(date) %>%
  summarize(mean_temp = mean(Air.temperature, na.rm = TRUE)) %>%
  ungroup()

# Now that we have tidied our dataframe, we can start plotting!

#================================
# Plotting Time vs temperature:
#================================
library(ggplot2)
library(lubridate)

# For plotting, we will start with 2 types of graphs. 1) a time series or 
# 2) a scatterplot with a trend line.

# if you don't find the functions familiar, feel free to review assignments 6
# or 7 since they both cover ggplot. 

# Here is the data formatted to plot as a time series. Feel free to change
# the color of the graph for your visual appeal.
ggplot(dailyAvg, aes(x = date, y = mean_temp)) +
  geom_line(color = "steelblue", linewidth = 1.2) +
  geom_point(color = "orange", size = 2) +
  labs(x = "Date", y = "Daily Average Temperature", title = "Daily Average Temperature Over Time") +
  theme_bw() +
  theme(plot.title = element_text(size = 14, face = "bold"),axis.title = element_text(size = 12))

# Here is the data formatted to plot as a scatter plot with a smooth trend line.
ggplot(dailyAvg, aes(x = date, y = mean_temp)) +
  geom_point() +
  geom_smooth(method = "loess", se = FALSE, color = "red") +
  theme_bw()

# TASK: Create a new scatter plot by changing the labels of the y-axis to 
# "Daily Average Temperature" and the x-axis to "Months". Give it a title 
# called:"Daily Average Temp. in 2003".
ggplot(dailyAvg,
       aes(x = date, y = mean_temp))+
  geom_point()+
  geom_smooth(method = "loess", se = FALSE, color = "red") +
  labs (x = "Months",
        y = "Daily Average Temperature",
        title = "Daily Average Temp. in 2003")+
  theme_bw()

# QUESTION: Between these two graphs, which graph would be better represent the
# dailyAvg dataframe? Why?
# Hint: The graph is comparing Date vs mean Temperature. 
# The former line graph would be better because we can analyze the fluctuations
# in the average temperature over time.


#================================
# Gapminder: Another approach to complex graphing
#================================
library(gapminder)
library(hms)

# Similar to our 2 assignments covering ggplot2, Gapminder is another package 
# that covers more types of graphs. 
# For this part, we would be focusing on "Bubble graphs" but Gapminder does 
# cover time-series across countries and continent color comparisons. 

# QUESTION: What are your initial thoughts on what bubble graphs measure and their general
# purpose?
# It measures three variables all at once and we compare one with other.

# We will be using 3 variables: months, hour, and mean_temperature.
# To graph this, we will need to reformat our data. 

# We will need to convert the time into hms, it makes it easier to measure time. 
# Then we will create an column called hour that will simplify the time.
# Create a new column with the months.
rangeTemp <- tempData %>%
  mutate(time = hms::as_hms(time), hour = hour(time),
         month = month(date, label = TRUE, abbr = TRUE))
         
         # QUESTION: Why would it be a good idea to average the hourly temperatures 
         # instead of plotting each hour for this graph? 
         # HINT: Take a look at datapoints within rangeTemp and visualize the graph
         # it would make. 
# It would crowd the plot if we ploted each hour for this graph. Averaging makes the graph clean
# and trend clearer.
         
         # You will group by month and hour and the summarize the final column to find 
         # the mean Air. temperature. We will double check if there are any NA's we
         # missed.Then ungroup to have 3 columns/variables in a dataframe
         # called hourMonthAvg.
         hourMonthAvg <- rangeTemp %>%
           group_by(month, hour) %>%
           summarize(mean_temp = mean(Air.temperature, na.rm = TRUE)) %>%
           ungroup()
         
         # It is time to plot our bubble graph! You will utilize ggplot and graph by hour
         # vs mean_temp. Make sure to set the color to follow the months and the size to 
         # measure the mean_temp as well. There are further graph elements covered in 
         # this code. 
         
         ggplot(hourMonthAvg, aes(x = hour,y = mean_temp,color = month,size = mean_temp)) +
           geom_point(alpha = 0.7) +
           scale_size(range = c(3, 12)) +
           scale_x_continuous(breaks = seq(0, 23, 2)) +
           labs(x = "Hour of Day (0–23)",y = "Average Temperature ",color = "Month",size = "Temperature",title = "Hourly Average Temperature by Month") +
           theme_bw() +
           theme(plot.title = element_text(size = 14, face = "bold"),legend.position = "bottom")
         
         # QUESTION: When reviewing the data, the temperature is very low, why is that?
         # HINT: How do we measure temperature in science?
         # Because it is in Celsius.
         
         # Correct this by changing the y label to "Average Temperature (°C)"!
         ggplot(hourMonthAvg, aes(x = hour,y = mean_temp,color = month,size = mean_temp)) +
           geom_point(alpha = 0.7) +
           scale_size(range = c(3, 12)) +
           scale_x_continuous(breaks = seq(0, 23, 2)) +
           labs(x = "Hour of Day (0–23)",y = "Average Temperature in Celsius ",color = "Month",size = "Temperature",title = "Hourly Average Temperature by Month") +
           theme_bw() +
           theme(plot.title = element_text(size = 14, face = "bold"),legend.position = "bottom")
         
         
         # Let's make a graph of the  temperature in fahrenheit! 
         # Create a new dataframe called "f_hourMonthAvg" with a column labeled " 
         # mean_temp_F from the "mean_temp" column. Alter the data to go from celsius to 
         # fahrenheit.
         # HINT: Conversion rate of "F -> C" is would look something like this 
         # (mean_temp * 9/5) + 32)
         
         hourMonthAvg <- rangeTemp %>%
           group_by(month, hour) %>%
           summarize(mean_temp = mean(Air.temperature, na.rm = TRUE)) %>%
           ungroup()
      
         f_hourMonthAvg <- hourMonthAvg %>% 
           mutate(mean_temp_F = (mean_temp * 9/5) + 32)
         
         # Use this code to guide you to creating the "f_hourMonthAvg" dataframe. If we
         # are creating a new column, what is the function to do that?
         # Mutate
         
         # With the new dataframe and the code before this, change the y label to "Average Temperature (°F)". What are the ranges for the y-axis now? 
         ggplot(f_hourMonthAvg, aes(x = hour,y = mean_temp_F,color = month,size = mean_temp_F)) +
           geom_point(alpha = 0.7) +
           scale_size(range = c(3, 12)) +
           scale_x_continuous(breaks = seq(0, 23, 2)) +
           labs(x = "Hour of Day (0–23)",y = "Average Temperature (°F)",color = "Month",size = "Temperature (°F)",title = "Hourly Average Temperature by Month") +
           theme_bw() +
           theme(plot.title = element_text(size = 14, face = "bold"),legend.position = "bottom")
         
         # Although there is a bit of clutter in our bubble graph, it shows a nice 
         # overlapping on the temperatures throughout their given months. 
         
         # Now, lets consider how to animate this graph!
         
         #================================
         # Gifski: Graph animation and export
         #================================
         install.packages("gganimate")
         library(gganimate)
         library(gifski)
         
         # Gifski, as mentioned before primarily focuses on animating graphs into a gif. 
         # This is done by taking multiple photos of the graph at different intervals or 
         # of the variables and then putting it together. The end result is almost like
         # a slideshow but continuous.
         # We will learn how to create these collages of photos and download the gif!
         
         # FOR CLARITY: Gifski does not animate the data itself. It takes photos (PNG's) 
         # created from the date and combine them in a presentation compressed into a gif. 
         # Like a wheel of photos. 
         
         # For this section, we are using the dataframe "dailyAvg", why do you think this 
         # is an easier dataframe to animate versus the hourMonthAvg?
         # It will not crowd the plot and will have fewer points.
         
         # To start the animation process, we want to make a function that allows for 
         # flexibility so that the dataframe/graph can be adjusted if need to.
         # QUESTION: Take a look at the code below, what do you think ggplot is doing here? Does the
         # coding look familiar?
         # Yes, it is making a time series plot where points are added progressively.
         
         make_timeseries_plot <- function(data, day_index) {
           ggplot(data[1:day_index, ], aes(x = date,y = mean_temp)) +
             geom_line(color = "steelblue", linewidth = 1.2) +
             geom_point(color = "red", size = 3) +
             labs(x = "Date",y = "Average Temperature (°C)",title = "Daily Average Temperature Over Time",subtitle = paste("Day:", data$date[day_index])) +
             theme_bw() +
             theme(plot.title = element_text(size = 14, face = "bold")) }
         
         # in this ggplot, we will be graphing each day with it's corresponding temperature.
         # Essentially a time series!
         
         # Now that we have a function, we create a folder to hold the images to keep 
         # our workspace tidy.
         dir.create("frames_timeseries", showWarnings = FALSE)
         
         # QUESTION: What does dir.create stand for? And where do you expect this folder to end up?
         # It will create a new folder called frames_timeseries inside the current working directory.
         
         # Now we instruct R how we want the Frame-generation loop to work.
         
         # QUESTION: Why do you think we are start on day 2 and why may it be more useful?
         # HINT: We are making a time series graph, what makes it different from a 
         # scatter plot?
         # It would ensure that we see a visible starting line as it starts animates.
         
         # The value p creates a plot for day 1, which begins the data or the start
         # of the animation.
         for (i in 2:nrow(dailyAvg)) {
           p <- make_timeseries_plot(dailyAvg, i)
           ggsave(filename = sprintf("frames_timeseries/frame_%04d.png", i),plot = p,width = 8,height = 5) }
         
#         ggsave(filename = sprintf("frames_daily/frame_%04d.png", i),plot = p,width = 8, height = 5)) # This line was already in the code and I had no idea what it did.

# lastly, with ggsave(), we save the data as a PNG file. the frames will come 
# out with the name frames_001, frames_002 and so on. 

# The png_file() function will keep all the images in order.
png_files <- list.files("frames_timeseries", full.names = TRUE, pattern = "*.png")

# Lastly, this following code will create a gif within your R files. Take a look right now in R-studios. You might want to filter by the most recently Modified. But the gif should be there! Feel free to drag into your browser and see it play!
gifski(png_files,gif_file = "dailyAvg_timeseries.gif",width = 900,height = 600,delay = 0.1)

# The file may take a couple of minutes to load in, feel free to run the code 
# a couple times to see if it'll wake up R-studio as animation is a demanding
# activity. 

#--------------------------------
# Magick: Image editor
#--------------------------------
library(magick)

# MagicK, is an image editor so it's primary purposes involve combining images,
# text, cropping and layering. Think of as R-studios' version of photoshop!

# Although it's not intended for animation, it is a essential backbone to 
# making graph have essential markings that would be difficult to add to GIFs.

# QUESTION: What are some examples that Magick can be useful in animating a graph?
# It be useful in adding watermarks to your animations or adjust brightness/contrast
# of your animation.

# We will start with a function, that will plot our dataframe into a adjustable graph.

make_daily_bubble <- function(data, day_index) {
  ggplot(data[1:day_index, ], aes(x = date,y = mean_temp)) +
    geom_point(aes(size = mean_temp, color = mean_temp), alpha = 0.7) +
    scale_size(range = c(4, 12)) +
    scale_color_viridis_c() +
    labs(x = "Date",y = "Average Temperature (°C)",title = "Daily Average Temperature Over Time",subtitle = paste("Day:", data$date[day_index])) +
    theme_bw() +
    theme(plot.title = element_text(size = 14, face = "bold"),legend.position = "bottom") }

#This animation will display the bubble chart. Where the color and size correlate
# with the temperature as the dates move horiztonally. 

#Create your folder to hold the photos for the GIF.
dir.create("frames_daily_magick", showWarnings = FALSE)

# Again, we instruct R how we want the Frame-generation loop to work. 
# Utilize ggsave to save our image!

for (i in seq_len(nrow(dailyAvg))) {
  p <- make_daily_bubble(dailyAvg, i)
  ggsave(
    filename = sprintf("frames_daily_magick/frame_%04d.png", i),plot = p,width = 8, height = 5 ) }

# MagicK differs from Gifski in creation steps of the GIF, but the end result 
# is the essentially the same but with cosmetic attributes.

# The images are gathered into one value. 
frames <- list.files("frames_daily_magick", full.names = TRUE, pattern = "*.png")

# img_list is a magick function that makes the package recognize as a 
# interactable object. 
img_list <- lapply(frames, image_read)

# In celebration of my cat turning 2 years old in this month, I will be 
# showcasing how magicK can watermark my cat into your animated GIF! 
# The image of my cat will likely be found in the slides or on canvas.

# These codes import the image and readjust the scaling of the image.
logo <- image_read("My_cat_as_a_watermark.png")
logo_small <- image_scale(logo, "150x150")

# This will overlay it onto the graph.
watermarked <- lapply(img_list, function(frame) {
  image_composite(frame, logo_small, offset = "+20+20") })

# This will combine the frames into a compressed GIF.
animation <- image_animate(image_join(watermarked), fps = 10)

# Lastly, this will save your GIF into your files!
image_write(animation, "dailyAvg_bubble_watermarked.gif")

# QUESTION: In your animation, what month has the highest temperature? 
# July

# Magick appears to take longer than Gifski to create the GIF in your files so 
# as I stated before, feel free to rerun the code to wake R-studio up. 





