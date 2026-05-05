library(ggplot2)
library(dplyr)
library(tidyr)
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
