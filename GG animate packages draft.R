

library(tidyverse)

cells <- read.csv("Cell_Density_Bernhardt.csv")
colnames(cells)
  
  
ggplot(cells, aes(x = temperature, y = cell_density)) +
  geom_point(aes(color = as.factor(cell_density)))

ggplot(cells, aes(x = temperature, y = cell_density)) +
  geom_point() +
  geom_smooth(method = "lm")

cells_clean <- cells %>%
  separate(date, into = c("date", "time"), sep = " ")


ggplot(cells_clean, aes(x = time, y = cell_density)) +
  geom_point()

cells_clean %>%
  slice(1:5) %>%
  ggplot(aes(x = time, y = cell_density)) +
  geom_point()


  
  ggplot(redband, aes(x = Length, y = Weight)) +
    geom_point(aes(color = as.factor(ScaleAge))) +
    geom_smooth(method = "lm",
                formula = y ~ poly(x, 2),
                color = "black",
                size = 2)
  
remove(cells_Clean)


===================================
  
--------------------------------
  Setting up the dataframe:
--------------------------------
  
# As done many times before, we want to make sure that we have all the 
# data neccessary to navigate this last section.
  
# Please load in "LD_temperature_data_1.csv", this can be located in the 
# Powerpoint and likely to be in canvas as well!
  
library(tidyverse)

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

# There are only 2 variables that we need to retrieve from tempData: date and
# Air.temperature. Although, there are multiple temperatures with the same date! 
# We can tidy up the number of days by taking the average of each date.
dailyAvg <- tempData %>%
  group_by(date) %>%
  summarize(mean_temp = mean(Air.temperature, na.rm = TRUE)) %>%
  ungroup()

# Now that we have tidied our dataframe, we can start plotting!

--------------------------------
 Plotting Time vs temperature:
--------------------------------

# For plotting, we will start with 2 types of graphs. 1) a time series or 
# 2) a scatterplot with a trend line.
  
# if you don't find the functions familiar, feel free to review assignments 6
# or 7 since they both cover ggplot. 
  
# Here is the data formatted to plot as a time series. Feel free to change
# the color of the graph for your visual appeal.
  ggplot(dailyAvg, aes(x = date, y = mean_temp)) +
  geom_line(color = "steelblue", linewidth = 1.2) +
  geom_point(color = "orange", size = 2) +
  labs(x = "Date", y = "Daily Average Temperature", title = "Daily Average Temperature Over Time (Gapminder Style)") +
  theme_bw() +
  theme(plot.title = element_text(size = 14, face = "bold"),axis.title = element_text(size = 12))

# Here is the data formatted to plot as a scatter plot with a smooth trend line.
ggplot(dailyAvg, aes(x = date, y = mean_temp)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "loess", se = FALSE, color = "red") +
  theme_bw()

# Between these two graphs, which graph would be better represent the
# dailyAvg dataframe? Why?
# Hint: The graph is comparing Date vs mean Temperature. 


--------------------------------
  Gapminder: Another approach to complex graphing
--------------------------------

# Similar to our 2 assignments covering ggplot2, Gapminder is another package 
# that covers more types of graphs. 
# For this part, we would be focusing on "Bubble graphs" but Gapminder does 
# cover time-series across countries and continent color comparisons. 
  
# What are your initial thoughts on what observations bubble graphs are trying 
# to express?
  
# Bubble graphs utlize 3-4 variables to measure! We will be using 3 variables: 
# months, hour, and mean_temperature.
  
# To graph by these 3 variables, we will need to reformat our data. 

  
library(dplyr)
library(hms)
library(lubridate)
install.packages("gganimate")
library(gganimate)


rangeTemp <- tempData %>%
  mutate(
    time = hms::as_hms(time),     # convert "15:00:00" to time object
    hour = hour(time),            # extract hour 0–23
    month = month(date, label = TRUE, abbr = TRUE)  # extract month as Jan, Feb, Mar...
  )

hourMonthAvg <- rangeTemp %>%
  group_by(month, hour) %>%
  summarize(mean_temp = mean(Air.temperature, na.rm = TRUE)) %>%
  ungroup()

library(ggplot2)

ggplot(hourMonthAvg, aes(
  x = hour,
  y = mean_temp,
  color = month,
  size = mean_temp
)) +
  geom_point(alpha = 0.7) +
  scale_size(range = c(3, 12)) +
  scale_x_continuous(breaks = seq(0, 23, 2)) +
  labs(
    x = "Hour of Day (0–23)",
    y = "Average Temperature (°C)",
    color = "Month",
    size = "Temperature",
    title = "Bubble Chart: Hourly Average Temperature by Month"
  ) +
  theme_bw() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    legend.position = "bottom"
  )

=====

p <- ggplot(hourMonthAvg, aes(
  x = hour,
  y = mean_temp,
  size = mean_temp,
  color = month
)) +
  geom_point(alpha = 0.7) +
  scale_size(range = c(3, 12)) +
  scale_x_continuous(breaks = seq(0, 23, 2)) +
  labs(
    x = "Hour of Day (0–23)",
    y = "Average Temperature (°C)",
    size = "Temperature",
    color = "Month",
    title = "Hourly Average Temperature by Month",
    subtitle = "Month: {closest_state}"
  ) +
  theme_bw() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    legend.position = "bottom"
  ) +
  transition_states(month, transition_length = 2, state_length = 1) +
  ease_aes("cubic-in-out")

anim_save("hourly_temp_gapminder.gif")

====
  
  p <- ggplot(hourMonthAvg, aes(
    x = hour,
    y = mean_temp,
    size = mean_temp,
    color = month
  )) +
  geom_point(alpha = 0.7) +
  scale_size(range = c(3, 12)) +
  scale_x_continuous(breaks = seq(0, 23, 2)) +
  labs(
    x = "Hour of Day",
    y = "Average Temperature",
    title = "Hourly Average Temperature by Month",
    subtitle = "Month: {closest_state}"
  ) +
  theme_bw() +
  transition_states(month, transition_length = 2, state_length = 1) +
  ease_aes("cubic-in-out")

animate(p, fps = 10)


--------------------------------
  Gifski
--------------------------------

# Gif are the main priotity of this package! 
  
# FOR CLARITY: Gifski does not animate the date itself. It takes photos (PNG's) created from the date and combine them in a presentation compressed into a gif. Like a wheel of photos. 
  
# To start creating a GIF, we need to convert our data into PNGs. What would be a good parameter for the photo creation? 
# HINT: Look at the columns made 



--------------------------------
  Magick
--------------------------------

  dir.create("frames")

library(ggplot2)

months <- unique(hourMonthAvg$month)

for (m in months) {
  
  p <- ggplot(hourMonthAvg %>% filter(month == m), aes(
    x = hour,
    y = mean_temp,
    size = mean_temp,
    color = month
  )) +
    geom_point(alpha = 0.7) +
    scale_size(range = c(3, 12)) +
    scale_x_continuous(breaks = seq(0, 23, 2)) +
    labs(
      x = "Hour of Day",
      y = "Average Temperature",
      size = "Temperature",
      color = "Month",
      title = "Hourly Average Temperature by Month",
      subtitle = paste("Month:", m)
    ) +
    theme_bw()
  
  ggsave(
    filename = paste0("frames/frame_", m, ".png"),
    plot = p,
    width = 8,
    height = 6,
    dpi = 150
  )
}

===

install.packages("magick")

library(magick)

frames <- list.files("frames", full.names = TRUE)

img <- image_read(frames) %>%
  image_scale("800x600") %>%
  image_animate(fps = 2)   # adjust speed here

image_write(img, "hourly_temp_magick.gif")



