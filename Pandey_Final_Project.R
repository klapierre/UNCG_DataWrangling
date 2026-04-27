
# Loading necessary packages ----------------------------------------------

install.packages("tidyverse")
install.packages("readxl")
library(tidyverse)
library(readxl)


# Loading the raw files in R ---------------------------------------------------
raw_meiosis1 <- read_excel("Pandey_meiosis_1.xlsx")
raw_meiosis2 <- read_excel("Pandey_meiosis_2.xlsx")


# For meiosis I ---------------------------------------

## Change column names
colnames(raw_meiosis1)
rename_meiosis1 <- rename(.data = raw_meiosis1,
                       strain_meiosis1="Strain",
                       date_meiosis1="Date",
                       meiosis="Meiosis",
                       series_meiosis1="Series",
                       spindlelength_meiosis1="Spindle Length",
                       spb_observed_meiosis1="Number of SPB observed",
                       escrt_observed_meiosis1="Number SPB with ESCRT")

## Fill empty fields with data above it for columns strain_meiosis1,""date_meiosis1,"           
# and "meiosis"

fill_meiosis1<- rename_meiosis1%>%
  fill(strain_meiosis1:meiosis)

# Assigning meiosis I phases


