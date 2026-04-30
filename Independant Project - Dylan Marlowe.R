### ------ Preparation ------ ###



## Obtaining resources:

# The data used is within this link:
# https://datadryad.org/dataset/doi:10.5061/dryad.8c4092n

# Download the .csv file at the top of the page (under "Data files"). 
# After downloading the file, it should look like this:

Vagi+et+al_S3+Supplementary+data.csv

# Read through the complete article through this DOI link:
# (This is optional for the viewer)
# https://royalsocietypublishing.org/rspb/article/286/1900/20182737/85002/Parental-care-and-the-evolution-of-terrestriality


## Set up the resources and packages needed to begin this project:

library(tidyverse)

# Here, we are just loading the "tidyverse" package.

# "tidyverse" is a key package in tidying our data, as it contains many functions that allow us to alter and visualize our data in future steps.

untidy_data <- read.csv2("Vagi+et+al_S3+Supplementary+data.csv")

# Here, we are creating a dataframe, that we can use as a baseline for the rest of this project, out of the data we downloaded earlier.

# So, if you opened the .csv file you downloaded, you would notice that everything seemed smashed into one column.

# We seem to have a problem before we can even start.

# The "read.csv" function does not work, so we need to use the "read.csv2" function. 

# The "read.csv" function reads through comma-separated files while the "read.csv2" function reads through semicolon-separated files.

# Basically, we had to download a .csv version of a .csv2 file, forcing us to re-read it as such within R Studio.

# Now we're back on track!



### ------ Splitting One Dataframe Into Three Dataframes ------ ###



# Our "untidy_data" dataset can be broken down into three sections:

# 1.) Names (Species, Family, and Clade)
# 2.) Character/numerical data
# 3.) Authors of references

# We are only going to be focusing on the character/numerical data, so we don't need the extra clutter.

# At the same time, we don't want to delete the rest of the data, so we will just separate them into three distinct datasets.

names_data <- untidy_data[, c("Species", "Family", "Clade")]

# This will create a dataframe specific to the names.

untidy_char_num_data <- untidy_data[, !names(untidy_data) %in% c("Family", "Clade", "Parental.care.references", "Terrestrial...aquatic.reproduction.references", "Direct.development.references", "Female.size.references", "Male.size.references", "Egg.size.references", "Clutch.size.references")]

# This will create a dataframe specific to the character/numerical data.

# When creating a new dataframe for the character/numerical data, it was easier choosing what to remove than what to add.

references_data <- untidy_data[, c("Species", "Parental.care.references", "Terrestrial...aquatic.reproduction.references", "Direct.development.references", "Female.size.references", "Male.size.references", "Egg.size.references", "Clutch.size.references")]

# This will create a dataframe specific to the author references.


# Each dataframe still contains the "Species" column, because we need to make sure the data ties together even when separated.

# The "Species" column is unique in every instance, so it works well.



### ------ Tidying Our Character/Numerical Data ------ ###


## -- Part 1: Dropping Unused Columns -- ##

tidy_data_part_1 <- untidy_char_num_data %>%
  select(-care_in_males_binary,
         -care_in_females_binary,
         -nourishment_by_females,
         -nourishment_by_females_binary,
         -protection,
         -care_duration_in_males,
         -care_duration_in_females)
  
## -- Part 2: Pivoting Type of Care Column -- ##

tidy_data_part_2 <- tidy_data_part_1 %>%
  filter(!is.na(type_of_care)) %>%
  mutate(value = 1) %>%
  pivot_wider(names_from = type_of_care,
              values_from = value,
              values_fill = 0) %>%
  rename(`no_parental_care` = `no care`,
         `female_parental care` = `female-only care `,
         `male_parental care` = `male-only care `,
         `biparental_care` = `biparental care`) %>%
  select(-"either parent")

## -- Part 3: Pivoting Direct Development Column -- ##

tidy_data_part_3 <- tidy_data_part_2 %>%
  mutate(value = 1) %>%
  pivot_wider(names_from = direct_development,
              values_from = value,
              values_fill = 0) %>%
  rename(full_body_development = present,
         tadpole_development = absent)

## -- Part 4: Pivoting Care Duration Column -- ##

tidy_data_part_4 <- tidy_data_part_3 %>%
  filter(!is.na(care_duration)) %>%
  mutate(value = 1) %>%
  pivot_wider(names_from = care_duration,
              values_from = value,
              values_fill = 0) %>%
  select(-`0`) %>%
  rename(parental_egg_care = `1`,
         parental_tadpole_care = `2`,
         parental_juvenile_care = `3`)

## -- Part 5.1: Creating Male Protection Data -- ##

tidy_data_males <- tidy_data_part_4 %>%
  filter(!is.na(protection_in_males)) %>%
  mutate(value = 1) %>%
  pivot_wider(names_from = protection_in_males,
              values_from = value,
              values_fill = 0) %>%
  select(-`0`) %>%
  rename(male_nest_protection = `1`,
         male_parental_attendance = `2`,
         male_back_carrying = `3`,
         male_internal_carrying = `4`) %>%
  select("Species",
         "male_nest_protection", 
         "male_parental_attendance", 
         "male_back_carrying", 
         "male_internal_carrying")

## -- Part 5.2: Creating Female Protection Data -- ##

tidy_data_females <- tidy_data_part_4 %>%
  filter(!is.na(protection_in_females)) %>%
  mutate(value = 1) %>%
  pivot_wider(names_from = protection_in_females,
              values_from = value,
              values_fill = 0) %>%
  select(-`0`) %>%
  rename(female_nest_protection = `1`,
         female_parental_attendance = `2`,
         female_back_carrying = `3`,
         female_internal_carrying = `4`,
         female_viviparity = `5`) %>%
  select("Species",
         "female_nest_protection",
         "female_parental_attendance",
         "female_back_carrying",
         "female_internal_carrying",
         "female_viviparity")
  
## -- Part 5.3: Combining Male and Female Protection Data -- ##

tidy_data_m_f <- left_join(tidy_data_males,
                           tidy_data_females,
                           by = "Species")

## -- Part 5.4: Reintegrating Protection Data Into Main Dataframe -- ##

tidy_data_part_5 <- left_join(tidy_data_m_f,
                              tidy_data_part_4,
                              by = "Species") %>%
  select(-c("protection_in_males",
            "protection_in_females"))