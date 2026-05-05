library(ggplot2)
library(dplyr)
library(tidyr)
library(tidyverse)
library(ggplot2)
library(maps)
library(dplyr)
library(tigris)
library(sf)
Average_US_Temps <- read.csv("Average Temperature 1900-2023.csv")
Average_US_Temps <- rename(Average_US_Temps, "Temperatures" = "Average_Fahrenheit_Temperature")

ggplot(data = Average_US_Temps,
       aes(x = Year, y = Temperatures)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)+
  labs(title = "Average US Temperatures by Year", x = "Year", y = "Average Temperature (°F)")+
  theme_dark() +
  theme(
    plot.background = element_rect(fill = "grey", colour = NA),
    panel.background = element_rect(fill = "grey"),
    legend.background = element_rect(fill = "grey")
  )
Rearanged_Temps <- column_to_rownames(Average_US_Temps, var = "Year")
ggplot(data = Average_US_Temps,
       aes(x = Year, y = Temperatures)) +
  geom_col() +
  labs(title = "Average US Temperatures by Year", x = "Year", y = "Average Temperature (°F)")+
  theme_dark() +
  theme(
    plot.background = element_rect(fill = "grey", colour = NA),
    panel.background = element_rect(fill = "grey"),
    legend.background = element_rect(fill = "grey")
  )
Average_State_Temps <- read.csv("average_monthly_temperature_by_state_1950-2022.csv")
Average_State_Temps <- select(Average_State_Temps, "month", "year", "state", "average_temp") %>% 
 rename("Month" = "month", "Year" = "year", "State" = "state", "Temperature" = "average_temp", )