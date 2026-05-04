# My date focuses on the effects of naringenin on lipid droplet diameter in 
# adipocytes. There were 3 treatments done to the adipocytes: Control, DMSO, and 
# Naringenin. 

# The data will observe how the lipid droplets within the adipocyte were changed.
# The hypothesis will observe that naringenin will decrease the size of the
# lipid droplets. 

~~~~~~~~~
First, packages. 

install.packages("tidyverse")
library(tidyverse)
library(dplyr)
install.packages("ggplot2")
library(ggplot2)
~~~~~~~~~

========================
  Tidying the data!
========================
# We will be pulling the data from the "Trial3_JV.csv". This 
# file contains all of the data that was collected from Trial 3 of the lipid 
# droplet count. 

Trial3 <- read_csv("Trial_3_JV.csv")


  
