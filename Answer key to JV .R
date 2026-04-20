
================================
  Setting up the dataframe:
  ================================
  
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
---> In dates, the same days repeats meaning that if we were to graph the data
we would have many points stacking in a line on that day/month. This duplication
on the X-axis values can disrupt the flow of the chart. 

# There are only 2 variables that we need to retrieve from tempData: date and
# Air.temperature. Although, there are multiple temperatures with the same date! 
# We can tidy up the number of days by taking the average of each date.
dailyAvg <- tempData %>%
  group_by(date) %>%
  summarize(mean_temp = mean(Air.temperature, na.rm = TRUE)) %>%
  ungroup()

# Now that we have tidied our dataframe, we can start plotting!

================================
  Plotting Time vs temperature:
  ================================
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

# Create a new scatter plot by changing the labels of the y-axis to 
# "Daily Average Temperature" and the x-axis to "Months". Give it a title 
# called:"Daily Average Temp. in 2003".

# Between these two graphs, which graph would be better represent the
# dailyAvg dataframe? Why?
# Hint: The graph is comparing Date vs mean Temperature. 
---> The time series is more ideal due to it's purpose' to cover change over time
but, the scatterplot does work as it can show trends. Both are justifiable and work
with the animation packages. 

================================
  Gapminder: Another approach to complex graphing
================================
  library(gapminder)
library(hms)

# Similar to our 2 assignments covering ggplot2, Gapminder is another package 
# that covers more types of graphs. 
# For this part, we would be focusing on "Bubble graphs" but Gapminder does 
# cover time-series across countries and continent color comparisons. 

# What are your initial thoughts on what bubble graphs measure and their general
# purpose?
---> Bubble graphs utlize 3-4 variables to measure! The purpose of the bubble graph is 
to reveal patterns across groups by allowing the colors separate different groups.

# We will be using 3 variables: months, hour, and mean_temperature.
# To graph this, we will need to reformat our data. 

# We will need to convert the time into hms, it makes it easier to measure time. 
# Then we will create an column called hour that will simplify the time.
# Create a new column with the months.
rangeTemp <- tempData %>%
  mutate(time = hms::as_hms(time), hour = hour(time),
         month = month(date, label = TRUE, abbr = TRUE)
         
         # Why would it be a good idea to average the hourly temperatures instead of 
         # plotting each hour for this graph? 
         # HINT: Take a look at datapoints within rangeTemp and visualize the graph
         # it would make. 
         ---> By averaging the hours, we will not have multiple datapoints stacked one another! 
           We will have cohesive points that cover each hour.
         
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
         
         # When reviewing the data, the temperature is very low, why is that?
         # HINT: How do we measure temperature in science?
         ---> The temperature is in celsius, so we would need to do a little math if we wanted the data 
         to be formatted that way.
         
         # Correct this by changing the y label to "Average Temperature (°C)"!
         
         # Let's make a graph of the temperature in fahrenheit! 
         # Create a new dataframe called "f_hourMonthAvg" with a column labeled " 
         # mean_temp_F from the "mean_temp" column. Alter the data to go from celsius to 
         # fahrenheit.
         # HINT: Conversion rate of "F -> C" is [ C = (F - 32)*(5/9) ]
         
         hourMonthAvg <- rangeTemp %>%
           group_by(month, hour) %>%
           summarize(mean_temp = mean(Air.temperature, na.rm = TRUE)) %>%
           ungroup()
         # Use this code to guide you to creating the "f_hourMonthAvg" dataframe. If we
         # are creating a new column, what is the function to do that?
         ---> It would be mutate, but it should present in this 
         f_hourMonthAvg <- rangeTemp %>%
           group_by(month, hour) %>%
           summarize(mean_temp = mean(Air.temperature, na.rm = TRUE)) %>%
           mutate(mean_temp_F = (mean_temp * 9/5) + 32) %>% 
           ungroup()
         
         # With the new dataframe and the code before this, change the y label to "Average Temperature (°F)". What are the ranges for the y-axis now? 
         ---> It should be 0-100 since it's in (°F)'.
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
         
         ================================
           Gifski: Graph animation and export
         ================================
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
         --->  dailyAvg's easier to animate due' to it having only 2 variables.
         hourMonthAvg has 3 variables. 
         ~~~~~~
           # To start the animation process, we want to make a function that allows for 
           # flexibility so that the dataframe/graph can be adjusted if need to.
           # Take a look at the code below, what do you think ggplot is doing here? Does the
           # coding look familiar?
           --->  ggplot is here to make a graph! And yes, the data should be familiar
         as this is our time series coding from earlier!
           
           make_timeseries_plot <- function(data, day_index) {
             ggplot(data[1:day_index, ], aes(x = date,y = mean_temp)) +
               geom_line(color = "steelblue", linewidth = 1.2) +
               geom_point(color = "red", size = 3) +
               labs(x = "Date",y = "Average Temperature (°C)",title = "Daily Average Temperature Over Time",subtitle = paste("Day:", data$date[day_index])) +
               theme_bw() +
               theme(plot.title = element_text(size = 14, face = "bold")) }
         
         ---> ggplot(), the function itself is making a graph under the following conditions. We have seen this similiar ggplot structure just in a few lines before this under gapminder. 
         
         # in this ggplot, we will be graphing each day with it's corresponding temperature.
         # Essentially a time series!
         
         # Now that we have a function, we create a folder to hold the images to keep 
         # our workspace tidy.
         dir.create("frames_timeseries", showWarnings = FALSE)
         
         # What does dir.create stand for? And where do you expect this folder to end up?
         --->  Directory create, it makes a folder and expect to find in files
         within R-studios or the designated folder on your computer
         
         # Now we instruct R how we want the Frame-generation loop to work.
         
         # Why do you think we are start on day 2 and why may it be more useful?
         # HINT: We are making a time series graph, what makes it different from a 
         # scatter plot?
         --->  This is due to the line that connects datapoints in a time series.
         That is why we need start the line at day 2 so that there is 2 reference 
         points to draw a line. It is more beneficial to start off at day 2, than
         to ignore it as it may disrupt the display of data. 
           
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

--------------------------------
  Magick: Image editor
--------------------------------
  library(magick)

# MagicK, is an image editor so it's primary purposes involve combining images,
# text, cropping and layering. Think of as R-studios' version of photoshop!

# Although it's not intended for animation, it is a essential backbone to 
# making graph have essential markings that would be difficult to add to GIFs.

# What are some examples that Magick can be useful in animating a graph? 
--->  MagicK can add watermarks for universities on a animated graph. It can 
Change a image that did not have a favorable title. It can rescale the image or gif

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

# In your animation, what month has the highest temperature? 
--->  This should be July, even if they have a hard time getting the GIF 
from their files. They should still be able to reference back to the dataframe.


# Magick appears to take longer than Gifski to create the GIF in your files so 
# as I stated before, feel free to rerun the code to wake R-studio up. 



