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

