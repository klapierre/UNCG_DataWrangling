# R markdown 8.2 つ ◕_◕༽つ

#load lib
library(tidyverse)

#load df
df <- read.csv("TEMPEST_SERC_understory sppcomp_2021.csv", header = T)

#set a theme
theme_minimal()

# Create df: A species list that contains a column of all plant species found within the experiment 
# (no repeats and be sure to remove non-plants!).
