
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
## and "meiosis"

fill_meiosis1<- rename_meiosis1%>%
  fill(strain_meiosis1:meiosis)

## Assigning meiosis I phases

phase_meiosis1 <- fill_meiosis1 %>% 
  mutate(phase = ifelse(spindlelength_meiosis1 < 2.42, "Pre-meiosis",
                        ifelse (spindlelength_meiosis1 <= 5.66, "Early Anaphase B",
                                ifelse (spindlelength_meiosis1 <= 8.91, "Mid Anaphase B",
                                        "Late Anaphase B"))))


## Calculating percentage recruitment of ESCRT per SPB observed
percentage_meiosis1 <- phase_meiosis1 %>% 
  group_by(strain_meiosis1, date_meiosis1, phase) %>% 
  summarize(total_spb_observed_meiosis1 = sum(spb_observed_meiosis1),
            total_escrt_observed_meiosis1 = sum(escrt_observed_meiosis1),
            percentage_escrt_per_spb_meiosis1 = (total_escrt_observed_meiosis1/total_spb_observed_meiosis1)*100) %>% 
  ungroup()


