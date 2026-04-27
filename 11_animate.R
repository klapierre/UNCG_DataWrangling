
#Objectives ---------------------------------------------------------------####

# 1. Understand the core parts of an animation
# 2. Learn how to make a simple animation
# 3. Get fancy with it! 
How to further customize animations
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
old_wd <- getwd()
dir.create("gganimate", showWarnings = FALSE)
setwd("gganimate")

##TASK: Write code using the head() function to get a glimpse of the dataset
head(airquality)

##QUESTION: One of the most basic animations is showing change overtime, what 
##columns in could we use to show this?
# Answer: We could use Day and Month to show change over time. 

##TASK: Below is the skeleton of a line plot, rewrite the code to have Day as the 
##x axis and temp as the y axis, then give the plot a descriptive title

ggplot(airquality, aes(x = Day, y = Temp)) +
  geom_line() +
  labs(title = "Temperature Over Days")

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
# Answer: The first code uses anim_save(), so it saves the animation as a GIF file called temperature.gif. The second code only uses animate(), so it shows the animation in RStudio but doesnt save it as a file.

##QUESTION: What is the animate() function doing?
# Answer: animate() turns the gganimate plot into an actual animation by creating frames and playing them. 

##QUESTION: What happens if we take out the transition_time() function?
# Answer: Without transition_time(), the plot is not animated over time. It will just show as a regular ggplot. 

##Now that we have a simple animation we can apply other functions to make the
##Animation easier to view and understand

##TASK: The transition_time function can be integrated into labs to create 
##descriptive titles for your animation: See by running the code below

airquality_temp <- ggplot(airquality, aes(x = Day, y = Temp)) +
  geom_line() +
  labs(title = "Month: {frame_time}") +
  transition_time(Month)
anim_save("temperature_titles.gif", animate(airquality_temp, renderer = gifski_renderer()))

##QUESTION: What is the new title of the graph?
# Answer: The title changes depending on the month.

##QUESTION: Why would someone choose to use the {frame_time} argument instead of 
##just typing a whole new title?
# Answer: It automatically updates the title for each part of the animation, so the people know what month or time period they are looking at.

##QUESTION: Transitions can be used to control how smooth the animation plays
##What are some characteristics of the animation that might be helpful to modify?
# Answer: It can be helpful to modify the speed, number of frames, how long each transition lasts etc. 

##Run the code below
airquality_temp <- ggplot(airquality, aes(x = Day, y = Temp)) +
  geom_line() +
  ease_aes('linear')+
  labs(title = "Month: {frame_time}") +
  transition_time(Month)
anim_save("temperature_ease.gif", animate(airquality_temp, renderer = gifski_renderer()))

##TASK: Annotate the code above with descriptive comments
# Answer: (airquality_temp <- ggplot(airquality, aes(x = Day, y = Temp)) +geom_line() +) This line creates a line graph of temperature by day. ( ease_aes('linear')+) This line makes the animation move at a steady speed. (labs(title = "Month: {frame_time}") +) This line of code updates the title based on the current month. ( transition_time(Month)) This line animates the graph over the Month variable. (anim_save("temperature_ease.gif", animate(airquality_temp, renderer = gifski_renderer()))) This line saves the animation as a GIF file called temperature_ease.gif using the gifski renderer. 

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
# Answer: shadow_trail() leaves a fadin trail behind the moving data, showing where the points recently were. shadow_mark() keeps past data visible, so you can see what has appeared in earlier frames.

##transition_time gives us continuous animations, but we can also use 
##transition_states to make discrete ones instead

##Quesion: Considering what you know about different graphs in ggplot, what 
##types of graph should you use transition_states() instead of transition_time()?
# Answer: Use trainsition_states() for graphs with separate categories or groups, like bar graphs, scatterplots, or plots comparing months, years, or categories as separate. 

##Below is an example of using transition_states()

airquality_discrete <- ggplot(airquality, aes(x = Day, y = Temp)) +
  geom_point() +
  transition_states(Month) +
  labs(title = "Month: {closest_state}")
anim_save("temperature_states.gif", animate(airquality_discrete, renderer = gifski_renderer()))

##QUESTION: Other than the type of graph, what is the main difference in the code 
##when using transition_states() instead of transition_time()?
# Answer: transition_states() uses groups/categories, while transition_time() uses a continuous time variable.

##Below is an example using a 3rd transition, transition_reveal()

airquality_reveal <- ggplot(airquality, aes(x = Day, y = Temp)) +
  geom_line() +
  transition_reveal(Day)
anim_save("temperature_reveal.gif", animate(airquality_reveal, renderer = gifski_renderer()))

##TASK/QUESTION: Use the the help tab and the animation above to describe what transition_reveal does.
?transition_reveal
# answer: transition_reveal gradually reveals the data over time.

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
# answer: transition_components() is helpful when different groups move or change separately over time, like different countries or teams for example. 

##Just like when you are animating a slideshow, often having elements disapear in
##in interesting ways helps draw people to your visual. In gganimate you can do 
##this by using enter and exit functions

airquality_discrete +
  enter_fade()+
  exit_shrink()

##TASK: rewrite the code above to utilize alternative enter and exit functions: 
##https://gganimate.com/reference/enter_exit.html
airquality_discrete +
  enter_grow() +
  exit_fade()

##QUESTION: Take a look at the help for the animate() function, what other arguments can be used?
?animate
# Answer: Some other arguments are nframes, fps, duration, width, height, renderer, start_pause, and end_pause.

##TASK: Using the airquality_temp animation, adjust the animation to have a 
##height of ##400, a width of 600, 100 frames, and have a speed of 10 frames per second
animate(airquality_temp, renderer = gifski_renderer(), height = 400, width = 600, nframes = 100, fps = 10)

##TASK: Fix the code below, and insert comments to to inform on the changes you made
##There are 3 mistakes, hint, it should not be a line graph, and all other functions 
##are correct, only the arguments may be incorrect

airquality_discrete <- ggplot(airquality, aes(x = Day, y = Temp)) +
  geom_point() +
  transition_states(Month) +
  labs(title = "Month: {closest_state}")
anim_save("temperature_discrete2.gif", animate(airquality_discrete, renderer = gifski_renderer()))

# Answer: I changed from geom_line to geom_point because this should be discrete. Use Month as the discrete state instead of day, and I changed the title from frame_time to closest_state for transition_states(). 

##Now it is time to test your skills. Make a new animation that shows ozone levels 
#overtime. Call it airquality_ozone. Use a shadow functions, an ease_aes() function, 
#and either an enter or exit function.
airquality_ozone <- ggplot(airquality, aes(x = Day, y = Ozone)) +
  geom_point() +
  ease_aes("linear") +
  shadow_trail() +
  enter_fade() +
  labs(title = "Ozone Levels Over Time: Month {frame_time}", x = "Day", y = "Ozone") +
  transition_time(Month)

anim_save("ozone_levels.gif", animate(airquality_ozone, renderer = gifski_renderer()))

##GREAT JOB!!!

##Reminder to reset your working directory
setwd(old_wd)

# 1.1 Expanding on gganimate use cases ----------------------------------------####

## TASK: Load datasets used in this section

data("gapminder")
data("iris")

## These are the two datasets we'll be using for this section! Check them out using
## head() or glimpse()
head(gapminder)
head(iris)

## QUESTION: Which dataset is inherently time-based and why does that matter for animation?
# Answer: The gapminder dataset is inherently time based because it has a year column. That matters because animation works well when it can show how values change over time. 

## TASK: Create a filtered gapminder dataset for North America only
gap_na <- gapminder %>%
  filter(continent == "Americas")

## TASK: Build a scatterplot of GDP vs life expectancy. Set size to population and
## group by country. Apply a log transform to the x-axis.
## Add transparency, labels, and a theme of your choice. Save this as an object named gap_plot.
gap_plot <- ggplot(gap_na, aes(x = gdpPercap, y - lifeExp, size = pop, group = country, color = country)) +
  geom_point(alpha = 0.7) +
  scale_x_log10() +
  labs(title = "GDP per Capita vs Life Expectancy in North America", x = "GDP per Capita", y = "Life Expectancy", size = "Population", color = "Country") +
  theme_minimal()

## QUESTION: Why is grouping important when animating repeated entities like countries?
# Answer: Grouping is important because it tells R which points belong to the same country across different years. Without grouping, the animation might not connect each country's changes correctly. 

## TASK: Animate by year using transition_time(). Save this as gap_anim.
gap_anim <- gap_plot +
  transition_time(year) +
  labs(title = "GDP per Capita vs Life Expectancy in North America: {frame_time}")

## We've already investigated the ease_aes() function using linear easing. This
## changes the ways that our frames are animated together. This is called tweening.
## Let's explore some other tweening use cases!
## TASK: Run the code below and descriptively annotate which each function does. 

# -in applies the easing function without any modification
# Answer: Starts movement using a cubic easing pattern. 
gap_anim + ease_aes('cubic-in')

# Answer: creates a stretchy, elastic movement.
gap_anim + ease_aes('elastic-in')

# Answer: starts movement in a circular easing pattern.
gap_anim + ease_aes('circular-in')

# Answer: Adds a bouncing movement at the start.
gap_anim + ease_aes("bounce-in")

# -out applies the easing function in reverse
# Answer: elastic movement effect toward the end. 
gap_anim + ease_aes('elastic-in')

# Answer: circular easing effect toward the end. 
gap_anim + ease_aes('circular-in')

# Answer: adds a bouncing movement at the end. 
gap_anim + ease_aes("bounce-in")

# we can combine them into -in-out
# Answer: smooths movement at both the beginning and end.
gap_anim + ease_aes('circular-in-out')

# Answer: adds bounce effects at both the beginning and end. 
gap_anim + ease_aes("bounce-in-out")

## QUESTION: What does the -in-out easing argument do to our animation? 
## Hint: Check ?ease_aes().
?ease_aes()
# Answer: The -in-out easing argument applies the easing effect at the beginning and end of the animation movement. 

## QUESTION: How does easing change the perception of movement over time?
# Answer: Easing changes how movement feels. It can make changes look smoother.

## gganimate also has view functions to change the framing of our animation
## over our data. 

## TASK: Add view_follow() to gap_anim to track evolving clusters
gap_anim + view_follow()

## QUESTION: What does view_follow() do? Why might this be useful?
# Answer: view_follow() changes the frame/view so it follows the moving data. This can be useful when the data points move across a large plot and you want people to focus on the moving cluster. 

## TASK: Try to apply view_step() to gap_anim.
gap_anim + view_step()

## This gives us an animation, but something is wrong.
## QUESTION: What is wrong with your animation? Why do you think this is happening
## HINT: Remember that transition_time is continuous. Check out ?view_step()
?view_step()
# answer: The animation looks jumpy and strange. This is because transition_time() is continuous, while view_step() works better with discrete changes. 

## Remember that iris dataset we loaded earlier? Now we're gonna switch to it!

## TASK: Using iris, plot Petal Length (x) vs Petal Width (y), colored by species.
## Save this as iris_anim. Add the appropiate labels, title, and transition. 
## Remove the legend.
## Hint: For your title, remember that your data are discrete, not continuous.

iris_base <- ggplot(iris, aes(x = Petal.Length, y = Petal.Width, color = Species, group = Species)) +
  geom_point(alpha = 0.7) +
  labs(title = "Species: {closest_state}", x = "Petal Length", y = "Petal Width") +
  theme_minimal() +
  theme(legend.position = "none")

iris_anim <- iris_base +
  transition_states(Species)

## We looked at enter_fade() and exit_shrink() previously, let's explore some more 
## animation effects. This, like easing, falls under the umbrella of Tweening!

## TASK: Add enter_fade() and exit_fade() effects
iris_anim + enter_fade() + exit_fade()

## TASK: Run the lines of code below and descriptively annotate what each function does.
## Hint: If you're unsure, run them piece-by-piece!

# Answer: points fly in from x = 0 and fly out toward x = 1. 
iris_anim + enter_fly(x_loc = 0) + exit_fly(x_loc = 1)

# Answer: points drift in vertically and drift out horizontally.
iris_anim + enter_drift(y_mod = 1) + exit_drift(x_mod = 1) 

# Answer; points enter as pink and exit as brown.
iris_anim + enter_recolor(color = "pink") + exit_recolor(color = "brown")

# Answer: points enter large and shrink very small as they exit. 
iris_anim + enter_grow(size = 10) + exit_shrink(size = 0.1)

# answer: points enter very small and grow/shrink differently as they leave.
iris_anim + enter_grow(size = 0.1) + exit_shrink(size = 10)

# answer: adds a bouncing effect when transitioning between species. 
iris_ease <- iris_base +
  transition_states(Species) +
  ease_aes("bounce-in-out")

## We can actually combine several transitions together. Let's take iris_anim,
## which has discrete transition_states and apply transition_reveal() by Petal.Length.
## TASK: Run the code below

(iris_reveal <- iris_anim + transition_reveal(Petal.Length))

## QUESTION: What does your animation look like? Why do you think this is the case?
## Hint: Look at the usage for transition_reveal().
?transition_reveal()
# Answer: The animation looks a bit strange because transition_reveal() is meant to reveal data along a continuous variable, but iris_anim was already using discrete species states. 

## TASK: Write 3 lines of code using different shadows to display point trajectories.
## Do not use shadow_null()

iris_reveal + shadow_trail()

iris_reveal + shadow_wake()

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
# Answer: Animations are useful for spatial data because they can show how patterns change across places over time, like how life expectancy increases or decreases in different countries. 

## QUESTION: What are some potential weaknesses of animating. 
## Hint: Think about how slow your computer probably ran!
# Answer: They can run slowly and take a lot of computer power.

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

head(tempData)
# Now, lets observe the timeTemp dataframe! Do you notice anything that would 
# make this data not ideal to graph? Why or why not?
# Hint: Think about how we would write the ggplot code. How would the datapoints 
# appear on the graph?
# Answer: There are mutiple temperature readings for the same data because data is recorded every 15 minutes. This would create too many overlapping points on a graph, making it cluttered.

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
ggplot(dailyAvg, aes(x = date, y = mean_temp)) +
  geom_point() +
  geom_smooth(method = "loess", se = FALSE, color = "red") +
  labs(x = "Months", y = "Daily Average Temperature", title = "Daily Average Temp.in 2003") +
  theme_bw()

# QUESTION: Between these two graphs, which graph would be better represent the
# dailyAvg dataframe? Why?
# Hint: The graph is comparing Date vs mean Temperature. 
# answer: The time series line graph is better because the data is comparing data and temperature over time. a line graph makes it easier to see show temp changes. 

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
# Answer: Bubble graphs show relationships between variables, comparing more than two variables at once. 

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
# answer: Averaging hourly temperatures makes the graph less cluttered. If every reading was plotted there would be too many overlapping points. 

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
# answer: The temp is low because scientific temperature data is usally measured in Celsius. 

# Correct this by changing the y label to "Average Temperature (°C)"!
 
# Let's make a graph of the temperature in fahrenheit! 
# Create a new dataframe called "f_hourMonthAvg" with a column labeled " 
# mean_temp_F from the "mean_temp" column. Alter the data to go from celsius to 
# fahrenheit.
# HINT: Conversion rate of "F -> C" is would look something like this 
# (mean_temp * 9/5) + 32)

hourMonthAvg <- rangeTemp %>%
  group_by(month, hour) %>%
  summarize(mean_temp = mean(Air.temperature, na.rm = TRUE)) %>%
  ungroup()
# Use this code to guide you to creating the "f_hourMonthAvg" dataframe. If we
# are creating a new column, what is the function to do that? 
# Answer: use mutate to create a new column. 
f_hourMonthAvg <- hourMonthAvg  %>%
  mutate(mean_temp_F = (mean_temp * 9/5) + 32)

# With the new dataframe and the code before this, change the y label to "Average Temperature (°F)". What are the ranges for the y-axis now? 
# Answer: The y-axis is now in fahrenheit.

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
# a slideshow but continous.
# We will learn how to create these collages of photos and download the gif!

# FOR CLARITY: Gifski does not animate the data itself. It takes photos (PNG's) 
# created from the date and combine them in a presentation compressed into a gif. 
# Like a wheel of photos. 

# For this section, we are using the dataframe "dailyAvg", why do you think this 
# is an easier dataframe to animate versus the hourMonthAvg?
# Answer: dailyAvg is easier because it has one average temperature per date. hourMonthAvg has both months and hours, making it more complex. 

# To start the animation process, we want to make a function that allows for 
# flexibility so that the dataframe/graph can be adjusted if need to.
# QUESTION: Take a look at the code below, what do you think ggplot is doing here? Does the
# coding look familiar?
# Answer: it is creating a time series graph using date on the x-axis and average temp on the y-axis. The function lets the graph build one day at a time for the animation.

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
# Answer: dir.create() creates a new folder.directory. It will end up in my current working directory. 

# Now we instruct R how we want the Frame-generation loop to work.

# QUESTION: Why do you think we are start on day 2 and why may it be more useful?
# HINT: We are making a time series graph, what makes it different from a 
# scatter plot?
# Answer: a line graph needs at least two points to make a line.

# The value p creates a plot for day 1, which begins the data or the start
# of the animation.
for (i in 2:nrow(dailyAvg)) {
  p <- make_timeseries_plot(dailyAvg, i)
  ggsave(filename = sprintf("frames_timeseries/frame_%04d.png", i),plot = p,width = 8,height = 5) }

ggsave(filename = sprintf("frames_daily/frame_%04d.png", i),plot = p,width = 8, height = 5) }

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
# answer: Magick can be used to add watermarks, labels, logos, captions etc.

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
  image_composite(frame, logo_faded, offset = "+20+20") })

# This will combine the frames into a compressed GIF.
animation <- image_animate(image_join(watermarked), fps = 10)

# Lastly, this will save your GIF into your files!
image_write(animation, "dailyAvg_bubble_watermarked.gif")

# QUESTION: In your animation, what month has the highest temperature? 
# answer: August. 
dailyAvg %>%
  mutate(month = month(date, label = TRUE, abbr = TRUE)) %>%
  group_by(month) %>%
  summarize(avg_temp = mean(mean_temp, na.rm = TRUE)) %>%
  arrange(desc(avg_temp))

# Magick appears to take longer than Gifski to create the GIF in your files so 
# as I stated before, feel free to rerun the code to wake R-studio up. 





