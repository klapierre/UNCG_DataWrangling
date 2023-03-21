library(tidyverse)
library(HistData)
library(gganimate)
library(gifski)

Nightingale %>% 
  select(Date, Month, Year, contains("rate")) %>% 
  pivot_longer(cols = 4:6, names_to = "Cause", values_to = "Rate") %>% 
  mutate(Cause = gsub(".rate", "", Cause),
         period = ifelse(Date <= as.Date("1855-03-01"), "April 1854 to March 1855", "April 1855 to March 1856"),
         Month = fct_relevel(Month, "Jul", "Aug", "Sep", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar", "Apr", "May", "Jun")) %>% 
  ggplot(aes(Month, Rate)) + 
  geom_col(aes(fill = Cause), width = 1, position = "identity") + 
  coord_polar() + 
  facet_wrap(~period) +
  scale_fill_manual(values = c("skyblue3", "grey30", "firebrick")) +
  scale_y_sqrt() +
  theme_void() +
  theme(axis.text.x = element_text(size = 9),
        strip.text = element_text(size = 11),
        legend.position = "bottom",
        plot.background = element_rect(fill = alpha("cornsilk", 0.5)),
        plot.margin = unit(c(10, 10, 10, 10), "pt"),
        plot.title = element_text(vjust = 5)) +
  ggtitle("Diagram of the Causes of Mortality")





