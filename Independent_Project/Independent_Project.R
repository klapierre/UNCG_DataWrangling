Average_US_Temps <- read.csv("Average Temperature 1900-2023.csv")
library(ggplot2)
library(dplyr)
library(tidyr)

ggplot(data = Average_US_Temps,
       aes(x = Year, y = Average_Fahrenheit_Temperature),) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)+
  labs(title = "Average US Temperatures by Year", x = "Year", y = "Average Temperature (°F)")+
  theme_dark() +
  theme(
    plot.background = element_rect(fill = "grey", colour = NA),
    panel.background = element_rect(fill = "grey"),
    legend.background = element_rect(fill = "grey")
  )
  