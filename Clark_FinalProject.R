#### Kelly's Final Project #### 

# ----------------------------------------------------------
#### Set Up ####
# ----------------------------------------------------------

rm(list = ls())
library(tidyverse)
library(ggplot2)
library(gganimate)

## Importing Data ##
rubus_cover <- read.csv("C:\\Users\\kelly\\OneDrive\\Documents\\BSS\\rubus_cover.csv")
rubus_count <- read.csv("C:\\Users\\kelly\\OneDrive\\Documents\\BSS\\plots_col_rub.csv")
rubus_FullData0 <- read.csv("C:\\Users\\kelly\\OneDrive\\Documents\\BSS\\rubus.data.csv")
rubus_FullData <- rubus_FullData0 %>% #combine annual, biennial, and perennial
  mutate(herb_t1 = annual_t1 + biennial_t1 + perennial_t1) %>% 
  mutate(herb_t2 = annual_t2 + biennial_t2 + perennial_t2)

#Removing annuals, biennials, and perennials at both times from dataset.
rubus_FullData$annual_t1  <- NULL
rubus_FullData$biennial_t1 <- NULL
rubus_FullData$perennial_t1 <- NULL
rubus_FullData$annual_t2  <- NULL
rubus_FullData$biennial_t2 <- NULL
rubus_FullData$perennial_t2 <- NULL

# ----------------------------------------------------------
#### Let's get to Cleaning ####
# ----------------------------------------------------------

## There are 10 fields that are sampled for the Buell-Small Successional (BSS) Study
# Five Fields are sampled on even years, and five fields are sampled on odd years. 
# For this project, I will be investigating the invasion of Rubus phoenioclasius between 2000 and 2021.
# All 10 fields were sampled in 2021 because no sampling took place in 2020. 

#Changing the 0's to NA for the unsampled years. 

rubus_cover2 <- rubus_cover %>% 
  mutate(across(c(C3, C4, C6, D2, E1), #these fields are sampled on even years
                ~ ifelse(YEAR %% 2 == 1 &. ==0, NA, .))) #make the 0's to NAs on odd years


rubus_cover3 <- rubus_cover2 %>% 
  mutate(across(c(C5, C7, D1, D3, E2), #these fields are sampled on odd years
                ~ ifelse(YEAR %% 2 == 0 &. ==0, NA, .)))  #make the 0's to NAs on even years

rub_cover_clean <- rubus_cover3 %>% 
  pivot_longer(cols = C3:E2,
               names_to = "field_id",
               values_to = "cover")

# Dropping the NA's for the unsampled years because they are not true NAs.
rub_cover_clean1 <- rub_cover_clean %>% 
  drop_na(cover)


## Now I want to look at if the fields were colonized by R. phoenocolaisus (Ruph). But I also need to drop the NAs 
# of the unsampled years. 
rubus_count2 <- rubus_count %>% 
  mutate(across(c(C3, C4, C6, D2, E1),
                ~ ifelse(YEAR %% 2 == 1 &. ==0, NA, .))) %>% 
  mutate(across(c(C5, C7, D1, D3, E2), 
                ~ ifelse(YEAR %% 2 == 0 &. ==0, NA, .))) %>% 
  pivot_longer(cols = C3:E2,
               names_to = "field_id",
               values_to = "count") %>% 
  drop_na(count) %>% 
  mutate(percent_colonized = count*100)

## merging the two data sets 
rubus_data <- merge(rub_cover_clean1, rubus_count2)

## Now, I want to make columns that are colonized vs uncolonized by Ruph. 
uncol_plots_t1 <- rubus_FullData %>% 
  filter(rp_cover_t1 == 0)

col_plots_t1 <- rubus_FullData %>% 
  filter(rp_cover_t1 > 0)

uncol_plots_t2 <- rubus_FullData %>% 
  filter(rp_cover_t2 == 0)

col_plots_t2 <- rubus_FullData %>% 
  filter(rp_cover_t2 > 0) %>%
  mutate(delta_rubus = rp_cover_t2 - rp_cover_t1)

# Making a dataset for plots colonized vs uncolonized. 
rubus_data1 <- rubus_data %>%
  mutate(colonized = round(count * 48),
         not_colonized = 48 - colonized) #plots colonized vs not colonized

# ----------------------------------------------------------
#### Cleaning the "Full Data" ####
# ----------------------------------------------------------
## This is the dataset I will mostly be using for my analyses. 

# Making a column for Ruph cover over time
rubus_FullData <- rubus_FullData %>%
  mutate(delta_rubus = rp_cover_t2 - rp_cover_t1)

# Making columns of Ruph invasions at different times. 
rubus_FullData1 <- rubus_FullData %>% 
  mutate(Ruph_invaded_t1 = ifelse(rp_cover_t1 > 0,1,0),
         Ruph_invaded_t2 = ifelse(rp_cover_t2 > 0,1,0))

rubus_FullData2 <- rubus_FullData %>%
  mutate(delta_rubus = rp_cover_t2 - rp_cover_t1, #change in Ruph
         delta_rich = under_rich_t2 - under_rich_t1, #change in understory richenss
         delta_herb = herb_t2 - herb_t1) #change in herbaceous cover.

# ----------------------------------------------------------
#### Adding other invaders and natives at t1 and t2 ####
# ----------------------------------------------------------
other_t1 <- read.csv("C:\\Users\\kelly\\OneDrive\\Documents\\BSS\\Clark-BSS_invad-native-cover_T1.csv") %>% 
  rename_with(tolower) %>% 
  rename(A.petiolata_t1 = x53) %>% 
  rename(M.vimineum_t1 = x311) %>% 
  rename(E.rugosum_t1 = x316) %>% 
  rename(H.virginiana_t1 = x361) %>% 
  rename(litter_t1 = x420) %>% 
  rename(L.maackii_t1 = x438) %>% 
  rename(P.virginianum_t1 = x566) %>% 
  rename(R.multiflora_t1 = x620) %>% 
  rename(Ru.occidentialis_t1 = x635) %>% 
  rename(fieldname = x)

other_t2 <- read.csv("C:\\Users\\kelly\\OneDrive\\Documents\\BSS\\Clark-BSS_invad-native-cover_T2.csv") %>% 
  rename_with(tolower) %>% 
  rename(A.petiolata_t2 = x53) %>% 
  rename(M.vimineum_t2 = x311) %>% 
  rename(E.rugosum_t2 = x316) %>% 
  rename(H.virginiana_t2 = x361) %>% 
  rename(litter_t2 = x420) %>% 
  rename(L.maackii_t2 = x438) %>% 
  rename(P.virginianum_t2 = x566) %>% 
  rename(R.multiflora_t2 = x620) %>% 
  rename(Ru.occidentialis_t2 = x635)

## Again, some fields are sampled on odd years, others on even.
even_fields <- c("C3", "C4", "C6", "D2", "E1")
odd_fields  <- c("C5", "C7", "D1", "D3", "E2")

other_t1_clean <- other_t1 %>%
  filter((year %% 2 == 0 & fieldname %in% even_fields) |
           (year %% 2 == 1 & fieldname %in% odd_fields)) %>% 
  mutate(across(ends_with("_t1"), ~as.numeric(.x))) %>% 
  mutate(across(ends_with("_t1"), ~replace_na(.x, 0)))

#All 10 fields were sampled in 2021. So, all the NAs are true 0s. But some of the NAs were characters and some were numeric. 
other_t2_clean <- other_t2 %>% 
  mutate(across(ends_with("_t2"), ~as.numeric(.x))) %>% 
  mutate(across(ends_with("_t2"), ~replace_na(.x, 0)))

# ----------------------------------------------------------
#### Joining the datasets ####
# ----------------------------------------------------------

FullData <- rubus_FullData2 %>% 
  left_join(other_t1_clean, by = c("plotid", "fieldname")) %>% 
  left_join(other_t2_clean, by = c("plotid", "fieldname"))

FullData <- FullData %>% 
  mutate(invaders_t1 = A.petiolata_t1 + M.vimineum_t1 + L.maackii_t1 + R.multiflora_t1) %>% 
  mutate(invaders_t2 = A.petiolata_t2 + M.vimineum_t2 + L.maackii_t2 + R.multiflora_t2) %>%
  mutate(natives_t1 = E.rugosum_t1 + H.virginiana_t1 + P.virginianum_t1 + Ru.occidentialis_t1) %>%
  mutate(natives_t2 = E.rugosum_t2 + H.virginiana_t2 + P.virginianum_t2 + Ru.occidentialis_t2)
# ----------------------------------------------------------
#### Data Summarization ####
# ----------------------------------------------------------

fields <- FullData %>% 
  group_by(fieldname) %>% 
  summarize(rubus_t1 = mean(rp_cover_t1, na.rm = TRUE),
            rubus_t2 = mean(rp_cover_t2, na.rm = TRUE),
            invaders_t1 = mean(invaders_t1, na.rm = TRUE),
            invaders_t2 = mean(invaders_t2, na.rm = TRUE), 
            natives_t1 = mean(natives_t1, na.rm = TRUE),
            natives_t2 = mean(natives_t2, na.rm = TRUE))



# ----------------------------------------------------------
#### Plotting ####
# ----------------------------------------------------------
# Plotting Ruph cover over time for all 10 fields
ggplot(rubus_data, aes(x = YEAR, y = cover, color = field_id)) +
  geom_line() +
  geom_point() +
  facet_wrap(~field_id, ncol= 5, nrow=2) +
  labs(y = "% Cover", x = "Year") +
  theme_bw()

# Plotting Ruph cover over time for all 10 fields on one plot
ggplot(rubus_data, aes(x = YEAR, y = cover, color = field_id, group = field_id)) +
  geom_line() +
  geom_point() +
  labs(y = "% Cover", x = "Year", color = "Field ID") +
  theme_bw()

# Same as above but animated. Commented out because of the billion images in the report. 
# ggplot(rubus_data, aes(x = YEAR, y = cover, color = field_id, group = field_id)) +
#   geom_line() +
#   geom_point() +
#   labs(y = "% Cover", x = "Year", color = "Field ID") +
#   theme_bw() +
#   transition_reveal(YEAR)

# Plotting fields that are colonized
ggplot(rubus_data, aes(x = YEAR,y = percent_colonized, color = field_id, group = field_id)) +
  geom_line() +
  geom_point() +
  labs(y = "% of Plots Colonized", x = "Year") +
  theme_bw()

# Plotting native herbaceous cover vs Ruph cover at T1 for all 10 fields. 
ggplot(FullData, aes(x = natives_t1, y = rp_cover_t1, color = fieldname)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE ) +
  facet_wrap(~fieldname, ncol= 5, nrow = 2) +
  labs(x = "% Native Cover", y = "% Ruph Cover", title = "Native Herbaceous Cover vs Ruph Cover (T1)") +
  theme_bw()

# Plotting invasive herbaceous cover vs Ruph cover at T1 for all 10 fields. 
ggplot(FullData, aes(x = invaders_t1, y = rp_cover_t1, color = fieldname)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE ) +
  facet_wrap(~fieldname, ncol= 5, nrow = 2) +
  labs(x = "% Invasive Cover", y = "% Ruph Cover", title = "Invasive Herbaceous Cover vs Ruph Cover (T1)") +
  theme_bw()

# Plotting native herbaceous cover vs Ruph cover at T2 for all 10 fields. 
ggplot(FullData, aes(x = natives_t2, y = rp_cover_t2, color = fieldname)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE ) +
  facet_wrap(~fieldname, ncol= 5, nrow = 2) +
  labs(x = "% Native Cover", y = "% Ruph Cover", title = "Native Herbaceous Cover vs Ruph Cover (T2)") +
  theme_bw()

# Plotting invasive herbaceous cover vs Ruph cover at T1 for all 10 fields. 
ggplot(FullData, aes(x = invaders_t2, y = rp_cover_t2, color = fieldname)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE ) +
  facet_wrap(~fieldname, ncol= 5, nrow = 2) +
  labs(x = "% Invasive Cover", y = "% Ruph Cover", title = "Invasive Herbaceous Cover vs Ruph Cover (T2)") +
  theme_bw()

# Plotting how Natives, Invaders, and Ruph changed over time in each field.
plot_fields <- data.frame(
  fieldname = rep(fields$fieldname, 3),
  group = rep(c("Ruph", "Invaders", "Natives"), each = nrow(fields)),
  t1 = c(fields$rubus_t1, fields$invaders_t1, fields$natives_t1),
  t2 = c(fields$rubus_t2, fields$invaders_t2, fields$natives_t2))

ggplot(plot_fields) +
  geom_segment(aes(x = "T1", xend = "T2",
                   y = t1, yend = t2,
                   group = fieldname, color = fieldname)) +
  geom_point(aes(x = "T1", y = t1,  color = fieldname)) +
  geom_point(aes(x = "T2", y = t2,  color = fieldname)) +
  facet_wrap(~group) +
  theme_bw() +
  labs(x = "", y = "% Cover", title = "Change in % Cover over Time")
