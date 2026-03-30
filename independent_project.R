# Setup -------------------------------------------------------------------

# Load Packages
pacman::p_load(tidyverse,
               readxl,
               janitor,
               gganimate)

# Set file path
file <- "Kehrberger_Scientific_Reports.xlsx"

# Import spreadsheet pages as dataframes
# Clean names using janitor
# Manually rename other columns for clarity
T1 <- read_excel(file, sheet = "T1") %>% 
  as_tibble() %>% 
  janitor::clean_names() %>% 
  rename(
    j_day = julian_date_of_year_2015,
    flower_count = number_of_p_vulgaris_flowers,
    visitation_rate = day_specific_flower_visitation_rate_individuals_per_hour,
    competitor_count = day_specific_number_of_other_than_p_vulgaris_flowering_plant_species,
    temperature = temperature_c
  )

T2 <- read_excel(file, sheet = "T2") %>% 
  as_tibble() %>% 
  janitor::clean_names() %>% 
  rename(
    week = week_of_the_year_2015,
    flower_count = number_of_p_vulgaris_flowers,
    bee_abundance = mean_bee_abundance,
    visitation_rate = mean_bee_visitation_rate_on_p_vulgaris_flowers,
    competitor_count = total_number_of_other_flowering_plant_species
  )

T3 <- read_excel(file, sheet = "T3") %>% 
  as_tibble() %>% 
  janitor::clean_names() %>% 
  rename(
    j_open = julian_date_of_bud_opening,
    longevitiy = floral_longevity_days,
    pollinator_hours = flower_specific_number_of_pollinator_suitable_hours,
    seed_set = seed_set_percent,
    mean_temp = flower_specific_mean_temperature_c,
    bee_visits = estimated_total_number_of_bee_visits_per_flower_of_p_vulgaris
  )

T4 <- read_excel(file, sheet = "T4") %>% 
  as_tibble() %>% 
  janitor::clean_names() %>% 
  rename(
    j_open = julian_date_of_bud_opening,
    seed_set = seed_set_percent
  )

T5 <- read_excel(file, sheet = "T5") %>% 
  as_tibble() %>% 
  janitor::clean_names() %>% 
  rename(
    j_open = julian_date_of_bud_opening,
    seed_set = seed_set_percent
  )

# Convert Julian dates to Date objects
### if j_day = 1, date should = 2015-01-01
# Factorize categorical variables
# Fix incorrectly assigned numerical values (NAs as characters)

T1 <- T1 %>% 
  mutate(date = as.Date(j_day - 1, origin = "2015-01-01"),
         site = as.factor(site),
         visitation_rate = as.numeric(visitation_rate),
         temperature = as.numeric(temperature))

T2 <- T2 %>% 
  mutate(site = as.factor(site),
         bee_abundance = as.numeric(bee_abundance),
         visitation_rate = as.numeric(visitation_rate),
         competitor_count = as.numeric(competitor_count))

T3 <- T3 %>% 
  mutate(date_open = as.Date(j_open - 1 , origin = "2015-01-01"),
         site = as.factor(site),
         flower_id = as.factor(flower_id))

T4 <- T4 %>% 
  mutate(date_open = as.Date(j_open - 1, origin = "2015-01-01"),
         site = as.factor(site),
         pollen_limitation = as.numeric(pollen_limitation))

T5 <- T5 %>% 
  mutate(date_open = as.Date(j_open - 1, origin = "2015-01-01"),
         site = as.factor(site),
         treatment = as.factor(treatment))

# Verify data structure before proceeding
glimpse(c(T1, T2, T3, T4, T5))


# Data Transformation -----------------------------------------------------

# Summarize statistics across sites
T1_site_summary <- T1 %>% 
  group_by(site) %>% 
  summarize(
    mean_flowers = mean(flower_count, na.rm = TRUE),
    mean_visitation = mean(visitation_rate, na.rm = TRUE),
    mean_temp = mean(temperature, na.rm = TRUE),
    total_competitors = sum(competitor_count, na.rm = TRUE)
  ) %>% 
  ungroup()

T2_site_summary <- T2 %>% 
  group_by(site) %>% 
  summarize(
    mean_flowers = mean(flower_count, na.rm = T),
    mean_bees = mean(bee_abundance, na.rm = T),
    mean_visitation = mean(visitation_rate, na.rm = T)) %>% 
  ungroup()

T3_site_summary <- T3 %>% 
  group_by(site) %>% 
  summarize(
    mean_longevity = mean(longevitiy, na.rm = T),
    mean_pollinator_hours = mean(pollinator_hours, na.rm = T),
    mean_seed_set = mean(seed_set, na.rm = T)
  ) %>% 
  ungroup()

T4_site_summary <- T4 %>% 
  group_by(site) %>% 
  summarize(
    mean_pollen_limitation <- mean(pollen_limitation, na.rm = T),
    mean_seed_set = mean(seed_set, na.rm = T)
  ) %>% 
  ungroup()

T5_site_summary <- T5 %>% 
  group_by(site,treatment) %>% 
  summarize(
    mean_open_date = mean(j_open, na.rm = T),
    mean_seed_set = mean(seed_set, na.rm = T)
  ) %>% 
  ungroup()

# Summarize statistics across dates
T1_date_summary <- T1 %>% 
  group_by(date) %>% 
  summarize(
    mean_flowers = mean(flower_count, na.rm = TRUE),
    mean_visitation = mean(visitation_rate, na.rm = TRUE),
    mean_temp = mean(temperature, na.rm = TRUE),
    total_competitors = sum(competitor_count, na.rm = TRUE)
  ) %>% 
  ungroup()

T2_date_summary <- T2 %>% 
  group_by(week) %>% 
  summarize(
    mean_flowers = mean(flower_count, na.rm = T),
    mean_bees = mean(bee_abundance, na.rm = T),
    mean_visitation = mean(visitation_rate, na.rm = T)) %>% 
  ungroup()

