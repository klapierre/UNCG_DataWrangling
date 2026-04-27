
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

colnames(rename_meiosis1)

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


## Calculating percentage recruitment of ESCRT per SPB observed separately for different strains, bioreps, and phases
percentage_strains_bioreps_phase_meiosis1 <- phase_meiosis1 %>% 
  group_by(strain_meiosis1, date_meiosis1, phase) %>% 
  summarize(total_spb_observed_meiosis1 = sum(spb_observed_meiosis1),
            total_escrt_observed_meiosis1 = sum(escrt_observed_meiosis1),
            percentage_escrt_biorep_meiosis1 = (total_escrt_observed_meiosis1/total_spb_observed_meiosis1)*100) %>% 
  select(-total_spb_observed_meiosis1, - total_escrt_observed_meiosis1) %>% 
  ungroup()

## Calculating percentage recruitment of ESCRT per SPB observed separately for different strains and bioreps regardless of bioreps
percentage_strains_phase_meiosis1 <- percentage_strains_bioreps_phase_meiosis1 %>% 
  group_by(strain_meiosis1, phase) %>% 
  mutate(average_percentage_per_strain_meiosis1 = mean(percentage_escrt_biorep_meiosis1)) %>% 
  ungroup()


# For meiosis II ----------------------------------------------------------


## Change column names
colnames(raw_meiosis2)

rename_meiosis2 <- rename(.data = raw_meiosis2,
                          strain_meiosis2="Strain",
                          date_meiosis2="Date",
                          meiosis="Meiosis",
                          series_meiosis2="Series",
                          spindlelength_1_meiosis2="Spindle Length 1",
                          spb_observed_1_meiosis2="Number of SPB observed 1",
                          escrt_observed_1_meiosis2="Number SPB with ESCRT 1",
                          spindlelength_2_meiosis2="Spindle Length 2",
                          spb_observed_2_meiosis2="Number of SPB observed 2",
                          escrt_observed_2_meiosis2="Number SPB with ESCRT 2")

colnames(rename_meiosis2)


## Fill empty fields with data above it for columns strain_meiosis2,""date_meiosis2,"           
## and "meiosis"

fill_meiosis2<- rename_meiosis2%>%
  fill(strain_meiosis2:meiosis)



