

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



-----
  
library(tidyverse)

temp <- read.csv("temperature_data_1.csv")
  
streamTemp <- temp %>%
  drop_na() %>%
  separate(Date, into = c("date", "time"), sep = " ") %>%
  mutate(date = as.Date(date, format = "%m/%d/%Y"),time = hms::as_hms(time))

timeTemp <- streamTemp %>%
  select(-time, -Hour, -Minute, -X)

dailyAvg <- streamTemp %>%
  group_by(date) %>%
  summarize(mean_temp = mean(Air.temperature, na.rm = TRUE)) %>%
  ungroup()

--------------------------------
 Plotting Time vs temperature:
--------------------------------

ggplot(dailyAvg, aes(x = mean_temp)) +
  geom_histogram(binwidth = 1, fill = "skyblue", color = "black") +
  labs(
    x = "Daily Average Temperature",
    y = "Count of Days",
    title = "Histogram of Daily Average Temperatures"
  ) +
  theme_bw()


--------------------------------
  Gapminder
--------------------------------

ggplot(dailyAvg, aes(x = date, y = mean_temp)) +
  geom_line(color = "steelblue", linewidth = 1.2) +
  geom_point(color = "orange", size = 2) +
  labs(
    x = "Date",
    y = "Daily Average Temperature",
    title = "Daily Average Temperature Over Time (Gapminder Style)"
  ) +
  theme_bw() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    axis.title = element_text(size = 12)
  )

--------------------------------
  Gifski
--------------------------------

# Gif are the main priotity of this package! 
  
# FOR CLARITY: Gifski does not animate the date itself. It takes photos (PNG's) created from the date and combine them in a presentation compressed into a gif. Like a wheel of photos. 
  
# To start creating a GIF, we need to convert our data into PNGs. What would be a good parameter for the photo creation? 
# HINT: Look at the columns made 



str(timeTemp)

daily_temp <- df %>%
  group_by(date) %>%
  summarize(mean_temp = mean(temp, na.rm = TRUE))

ggplot(daily_temp, aes(x = date, y = mean_temp)) +
  geom_line() +
  geom_point()


