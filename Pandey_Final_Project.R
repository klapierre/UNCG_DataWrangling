
# Loading necessary packages ----------------------------------------------

#install.packages("tidyverse")
#install.packages("readxl")
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
  mutate(phase = ifelse(spindlelength_meiosis1 < 2.42, "Pre-meiosis /I",
                        ifelse (spindlelength_meiosis1 <= 5.66, "Early Anaphase B/I",
                                ifelse (spindlelength_meiosis1 <= 8.91, "Mid Anaphase B/I",
                                        "Late Anaphase B/I"))),
          phase = factor (phase, levels = c("Pre-meiosis /I", 
                                           "Early Anaphase B/I", 
                                           "Mid Anaphase B/I", 
                                           "Late Anaphase B/I")))


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
  mutate(average_percentage_per_strain_meiosis1 = mean(percentage_escrt_biorep_meiosis1),
         se_meiosis1 = sd(percentage_escrt_biorep_meiosis1)/sqrt(n())) %>% 
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

## Transforming the data such that all the spindle lengths, number of SPB observed, and
# number of ESCRTs in SPB are under same column

transform_meiosis2_1 <- fill_meiosis2 %>% 
  select(strain_meiosis2, date_meiosis2, meiosis, series_meiosis2, spindlelength_1_meiosis2, spb_observed_1_meiosis2, escrt_observed_1_meiosis2) %>% 
  rename(strain_meiosis2 = "strain_meiosis2",
         date_meiosis2 = "date_meiosis2",
         meiosis = "meiosis",
         series_meiosis2 = "series_meiosis2",
         spindlelength_meiosis2 = "spindlelength_1_meiosis2",
         spb_observed_meiosis2 = "spb_observed_1_meiosis2",
         escrt_observed_meiosis2 =  "escrt_observed_1_meiosis2")

colnames(transform_meiosis2_1)

transform_meiosis2_2<- fill_meiosis2 %>% 
  select(strain_meiosis2, date_meiosis2, meiosis, series_meiosis2, spindlelength_2_meiosis2, spb_observed_2_meiosis2, escrt_observed_2_meiosis2) %>% 
  rename(strain_meiosis2 = "strain_meiosis2",
         date_meiosis2 = "date_meiosis2",
         meiosis = "meiosis",
         series_meiosis2 = "series_meiosis2",
         spindlelength_meiosis2 = "spindlelength_2_meiosis2",
         spb_observed_meiosis2 = "spb_observed_2_meiosis2",
         escrt_observed_meiosis2 =  "escrt_observed_2_meiosis2")

colnames(transform_meiosis2_2)

transform_meiosis2 <- rbind(transform_meiosis2_1, transform_meiosis2_2)


## Assigning meiosis II phases

phase_meiosis2 <- transform_meiosis2 %>% 
  mutate(phase = ifelse(spindlelength_meiosis2 < 1.71, "Pre-meiosis /II",
                        ifelse (spindlelength_meiosis2 <= 3.68, "Early Anaphase B/II",
                                ifelse (spindlelength_meiosis2 <= 5.65, "Mid Anaphase B/II",
                                        "Late Anaphase B/II"))),
         phase = factor (phase, levels = c("Pre-meiosis /II", 
                                    "Early Anaphase B/II", 
                                    "Mid Anaphase B/II", 
                                    "Late Anaphase B/II")))


## Calculating percentage recruitment of ESCRT per SPB observed separately for different strains, bioreps, and phases
percentage_strains_bioreps_phase_meiosis2 <- phase_meiosis2 %>% 
  group_by(strain_meiosis2, date_meiosis2, phase) %>% 
  summarize(total_spb_observed_meiosis2 = sum(spb_observed_meiosis2),
            total_escrt_observed_meiosis2 = sum(escrt_observed_meiosis2),
            percentage_escrt_biorep_meiosis2 = (total_escrt_observed_meiosis2/total_spb_observed_meiosis2)*100) %>% 
  select(-total_spb_observed_meiosis2, - total_escrt_observed_meiosis2) %>% 
  ungroup()

## Calculating percentage recruitment of ESCRT per SPB observed separately for different strains and bioreps regardless of bioreps
percentage_strains_phase_meiosis2 <- percentage_strains_bioreps_phase_meiosis2 %>% 
  group_by(strain_meiosis2, phase) %>% 
  mutate(average_percentage_per_strain_meiosis2 = mean(percentage_escrt_biorep_meiosis2),
         se_meiosis2 = sd(percentage_escrt_biorep_meiosis2)/sqrt(n())) %>% 
  ungroup()


# Plotting the data -------------------------------------------------------

## Meiosis I data

### For 614 
biorep_614 <- percentage_strains_bioreps_phase_meiosis1 %>% 
  filter (strain_meiosis1 == "614")

summary_614 <- percentage_strains_phase_meiosis1 %>% 
  filter (strain_meiosis1 == "614")

ggplot ()+
  geom_point(data = biorep_614,
               aes (x = phase,
                    y = percentage_escrt_biorep_meiosis1),
               size = 2, alpha = 0.6, color = "brown" )+
  geom_point(data = summary_614,
                  aes(x = phase,
                      y = average_percentage_per_strain_meiosis1),
             color = "maroon")+
  geom_errorbar (data = summary_614,
                 aes (x = phase,
                      ymin = average_percentage_per_strain_meiosis1 - se_meiosis1,
                      ymax = average_percentage_per_strain_meiosis1 + se_meiosis1),
                 width = 0.2,
                 color ="maroon") +
  labs (x = "Meiosis I phases",
        y = "ESCRT recruitment (% of SPB)",
        title = "Recruitment of Cmp7 at Meiosis I")


### For 615
biorep_615 <- percentage_strains_bioreps_phase_meiosis1 %>% 
  filter (strain_meiosis1 == "615")

summary_615 <- percentage_strains_phase_meiosis1 %>% 
  filter (strain_meiosis1 == "615")

ggplot ()+
  geom_point (data = biorep_615,
               aes (x = phase,
                    y = percentage_escrt_biorep_meiosis1),
               size = 2, alpha = 0.6, color = "brown" )+
  geom_point(data = summary_615,
             aes(x = phase,
                 y = average_percentage_per_strain_meiosis1),
             color = "maroon")+
  geom_errorbar (data = summary_615,
                 aes (x = phase,
                      ymin = average_percentage_per_strain_meiosis1 - se_meiosis1,
                      ymax = average_percentage_per_strain_meiosis1 + se_meiosis1),
                 width = 0.2,
                 color ="maroon") +
  labs (x = "Meiosis I phases",
        y = "ESCRT recruitment (% of SPB)",
        title = "Recruitment of Ist1 at Meiosis I")


### For 650
biorep_650 <- percentage_strains_bioreps_phase_meiosis1 %>% 
  filter (strain_meiosis1 == "650")

summary_650 <- percentage_strains_phase_meiosis1 %>% 
  filter (strain_meiosis1 == "650")

ggplot ()+
  geom_point (data = biorep_650,
               aes (x = phase,
                    y = percentage_escrt_biorep_meiosis1),
                size = 2, alpha = 0.6, color = "brown" )+
  geom_point(data = summary_650,
             aes(x = phase,
                 y = average_percentage_per_strain_meiosis1),
             color = "maroon")+
  geom_errorbar (data = summary_650,
                 aes (x = phase,
                      ymin = average_percentage_per_strain_meiosis1 - se_meiosis1,
                      ymax = average_percentage_per_strain_meiosis1 + se_meiosis1),
                 width = 0.2,
                 color ="maroon") +
  labs (x = "Meiosis I phases",
        y = "ESCRT recruitment (% of SPB)",
        title = "Recruitment of Vps32 at Meiosis I")


## Meiosis II data

### For 614 
biorep_614 <- percentage_strains_bioreps_phase_meiosis2 %>% 
  filter (strain_meiosis2 == "614")

summary_614 <- percentage_strains_phase_meiosis2 %>% 
  filter (strain_meiosis2 == "614")

ggplot ()+
  geom_point (data = biorep_614,
               aes (x = phase,
                    y = percentage_escrt_biorep_meiosis2),
                size = 2, alpha = 0.6, color = "brown" )+
  geom_point(data = summary_614,
             aes(x = phase,
                 y = average_percentage_per_strain_meiosis2),
             color = "maroon")+
  geom_errorbar (data = summary_614,
                 aes (x = phase,
                      ymin = average_percentage_per_strain_meiosis2 - se_meiosis2,
                      ymax = average_percentage_per_strain_meiosis2 + se_meiosis2),
                 width = 0.2,
                 color ="maroon") +
  labs (x = "Meiosis II phases",
        y = "ESCRT recruitment (% of SPB)",
        title = "Recruitment of Cmp7 at Meiosis II")


### For 615
biorep_615 <- percentage_strains_bioreps_phase_meiosis2 %>% 
  filter (strain_meiosis2 == "615")

summary_615 <- percentage_strains_phase_meiosis2 %>% 
  filter (strain_meiosis2 == "615")

ggplot ()+
  geom_point (data = biorep_615,
               aes (x = phase,
                    y = percentage_escrt_biorep_meiosis2),
                size = 2, alpha = 0.6, color = "brown" )+
  geom_point(data = summary_615,
             aes(x = phase,
                 y = average_percentage_per_strain_meiosis2),
             color = "maroon")+
  geom_errorbar (data = summary_615,
                 aes (x = phase,
                      ymin = average_percentage_per_strain_meiosis2 - se_meiosis2,
                      ymax = average_percentage_per_strain_meiosis2 + se_meiosis2),
                 width = 0.2,
                 color ="maroon") +
  labs (x = "Meiosis II phases",
        y = "ESCRT recruitment (% of SPB)",
        title = "Recruitment of Ist1 at Meiosis II")


### For 650
biorep_650 <- percentage_strains_bioreps_phase_meiosis2 %>% 
  filter (strain_meiosis2 == "650")

summary_650 <- percentage_strains_phase_meiosis2 %>% 
  filter (strain_meiosis2 == "650")

ggplot ()+
  geom_point (data = biorep_650,
               aes (x = phase,
                    y = percentage_escrt_biorep_meiosis2),
               size = 2, alpha = 0.6, color = "brown" )+
  geom_point(data = summary_650,
             aes(x = phase,
                 y = average_percentage_per_strain_meiosis2),
             color = "maroon")+
  geom_errorbar (data = summary_650,
                 aes (x = phase,
                      ymin = average_percentage_per_strain_meiosis2 - se_meiosis2,
                      ymax = average_percentage_per_strain_meiosis2 + se_meiosis2),
                 width = 0.2,
                 color ="maroon") +
  labs (x = "Meiosis II phases",
        y = "ESCRT recruitment (% of SPB)",
        title = "Recruitment of Vps32 at Meiosis II")
