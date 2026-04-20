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
~~~~~~
  # To start the animation process, we want to make a function that allows for 
  # flexibility so that the dataframe/graph can be adjusted if need to.
  # Take a look at the code below, what do you think ggplot is doing here? Does the
  # coding look familiar?
  
  make_daily_plot <- function(data, day_index) {
    ggplot(data[1:day_index, ], aes(x = date,y = mean_temp)) +
      geom_point(aes(size = mean_temp, color = mean_temp), alpha = 0.7) +
      scale_size(range = c(4, 12)) +
      scale_color_viridis_c() +
      labs(x = "Date",y = "Average Temperature (°C)",size = "Temperature",color = "Temperature",title = "Daily Average Temperature Over Time",subtitle = paste("Day:", data$date[day_index])) +
      theme_bw() +
      theme(plot.title = element_text(size = 14, face = "bold"),legend.position = "bottom") }
  
  ---> ggplot(), the function itself is making a graph under the following conditions. We have seen this similiar ggplot structure just in a few lines before this under gapminder. 
  
  # in this ggplot, we will be graphing each day as a bubble.The size and color of 
  # the bubbles will correlate to temperature. While on x-axis, time will be moving.
  
  # Now that we have a function, we create a folder to hold the images to keep 
  # our workspace tidy.
  dir.create("frames_daily", showWarnings = FALSE)
  
  # What does dir.create stand for? And where do you expect this folder to end up?
  
  # Now we instruct R how we want the Frame-generation loop to work.
  # 
  # The value p creates a plot for day 1, which begins the data or the start
  # of the animation.
  
  
  # lastly, with ggsave(), we save the data as a PNG file. the frames will come 
  # out with the name frames_001, frames_002 and so on.
  for (i in seq_len(nrow(dailyAvg))) {
    p <- make_daily_plot(dailyAvg, i)
    
    ggsave(filename = sprintf("frames_daily/frame_%04d.png", i),plot = p,width = 8, height = 5) }
  
  # The png_file() function will keep all the images in order.
  png_files <- list.files("frames_daily", full.names = TRUE, pattern = "*.png")
  
  # Lastly, this following code will create a gif within your R files. Take a look right now in R-studios. You might want to filter by the most recently Modified. But the gif should be there! Feel free to drag into your browser and see it play!
  gifski(png_files,gif_file = "1dailyAvg_bubble.gif",width = 900,height = 600,delay = 0.1)
  
  
  make_timeseries_plot <- function(data, day_index) {
    ggplot(data[1:day_index, ], aes(
      x = date,
      y = mean_temp
    )) +
      geom_line(color = "steelblue", linewidth = 1.2) +
      geom_point(color = "red", size = 3) +
      labs(
        x = "Date",
        y = "Average Temperature (°C)",
        title = "Daily Average Temperature Over Time",
        subtitle = paste("Day:", data$date[day_index])
      ) +
      theme_bw() +
      theme(
        plot.title = element_text(size = 14, face = "bold")
      )
  }
  dir.create("frames_timeseries", showWarnings = FALSE)
  
  for (i in 2:nrow(dailyAvg)) {
    p <- make_timeseries_plot(dailyAvg, i)
    ggsave(
      filename = sprintf("frames_timeseries/frame_%04d.png", i),
      plot = p,
      width = 8,
      height = 5
    )
  }
  
  
  library(gifski)
  
  png_files <- list.files("frames_timeseries", full.names = TRUE, pattern = "*.png")
  
  gifski(
    png_files,
    gif_file = "dailyAvg_timeseries.gif",
    width = 900,
    height = 600,
    delay = 0.1
  )
  
  
  
  
  +++++++