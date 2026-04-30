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

td_drop_cols <- untidy_char_num_data %>%
  select(-care_in_males_binary,
         -care_in_females_binary,
         -nourishment_by_females,
         -nourishment_by_females_binary,
         -protection,
         -care_duration_in_males,
         -care_duration_in_females)

# The first step I'm making is to remove columns that I have no use for.
# The columns removed are ones that will end up redundant later.


## -- Part 2: Pivoting Type of Care Column -- ##

td_type_of_care <- td_drop_cols %>%
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

# Here, I'm pivoting the "type_of_care" column for a couple reasons:
# 1.) Remove character values from observations
# 2.) Transition to a binary system

# I am also removing one set of the observation values that would've become a column (either parent).
# This is because the article had explained that there were too few examples of this being used, so it wasn't even used in further analysis.

# I want to make an important point that you will see a couple instances of me filtering out NA values, while the end result will still carry them.
# This is due to the severity of the outcome.
# Instances where I removed NA values barely impacted the overall observation count.
# There were times where up to 80% of the observation count was removed due to filtering for NA values in certain columns.
# As much as I wanted to remove NA values entirely to make the data more tidy, it wasn't worth completely destroying the data.


## -- Part 3: Pivoting Direct Development Column -- ##

td_direct_development <- td_type_of_care %>%
  mutate(value = 1) %>%
  pivot_wider(names_from = direct_development,
              values_from = value,
              values_fill = 0) %>%
  rename(full_body_development = present,
         tadpole_development = absent)

# Once again, we are pivoting to change our observations to become column titles to allow for a binary system. 
# It's basically just another addition to the list.


## -- Part 4: Pivoting Care Duration Column -- ##

td_duration <- td_direct_development %>%
  filter(!is.na(care_duration)) %>%
  mutate(value = 1) %>%
  pivot_wider(names_from = care_duration,
              values_from = value,
              values_fill = 0) %>%
  select(-`0`) %>%
  rename(parental_egg_care = `1`,
         parental_tadpole_care = `2`,
         parental_juvenile_care = `3`)

# This is very similar to the other cases so far. We see the filtering on NA values, as well as another pivot.

# I am removing a column "0", but what is it?
# "0" was created because we are using a number system from 0-3, but are trying to make those numbers the columns and make it a binary system. 
# The problem was that "0" represented something I had already done "no care", so I didn't want to include it. 
# To account for the 0s, R made its own "0" column. So, I just removed it.


## -- Part 5.1: Creating Male Protection Data -- ##

td_male_protection <- td_duration %>%
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

# This is where we see similar steps, but begin to take different actions.

# Basically, there is a 0-5 scale for both male and female protection of their children. So, we are creating a lot of columns to make make binary observations out of.
# In the male version, we seem to be missing number 5, right?
# This is intentional, as there were no cases of male viviparity.

# It should be known that we are taking a detour here, but a required one.
# I initially tried to have male and female protection go straight into the main dataframe, but I kept getting an error about the same name.
# So, it forced me to split up the process, selecting certain columns.
# Note that I kept the Species column to call back between dataframes.


## -- Part 5.2: Creating Female Protection Data -- ##

td_female_protection <- td_duration %>%
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

# This is just as I had explained with the male protection segment.

# You can see we now have female viviparity, where male viviparity was nonexistent.

#Besides that and the names being "female" instead of "male", everything else is the same.


## -- Part 5.3: Combining Male and Female Protection Data -- ##

td_male_and_female <- left_join(td_male_protection,
                                td_female_protection,
                                by = "Species")

# This is where we take our male and female segments and joing them together, using "Species" as the glue. 


## -- Part 5.4: Reintegrating Protection Data Into Main Dataframe -- ##

td_reintegration <- left_join(td_male_and_female,
                              td_duration,
                              by = "Species") %>%
  select(-c("protection_in_males",
            "protection_in_females"))

# This is where we take the joined male and female segment, and reintegrate it with the main dataframe, using "Species" as the glue.
# Now, we're removing a couple of columns, but don't worry, they are the columns we used to make the male and female segments work, so they are nothing more than redundant now.


## -- Part 6: Renaming and Reordering -- ##

td_rename_reorder <- td_reintegration %>%
  rename_with(~ str_to_lower(.)) %>%
  rename(male_parental_care = `male_parental care`,
         female_parental_care = `female_parental care`) %>%
  select(species,
         number_of_parents,
         no_parental_care,
         male_parental_care,
         female_parental_care,
         biparental_care,
         parental_egg_care,
         parental_tadpole_care,
         parental_juvenile_care,
         male_nest_protection,
         male_parental_attendance,
         male_back_carrying,
         male_internal_carrying,
         female_nest_protection,
         female_parental_attendance,
         female_back_carrying,
         female_internal_carrying,
         female_viviparity,
         tadpole_development,
         full_body_development,
         terrestrial_reproduction,
         female_svl,
         male_svl,
         average_male_female_svl,
         ssd,
         egg_diameter,
         log_egg_diameter,
         clutch_size,
         log_clutch_size,
         clutch_volume,
         log_clutch_volume)

# So, not everything was amazingly perfect at this point, so I felt it was best to do some renaming and reorganizing.

# I decided to make everything lowercase, since some terms like SSD and SVL would be difficult to work with unless making everything uppercase or individually changing every column name. 

# I had to manually rename a couple of column names because they carried syntax errors when running the code with the spaces they had.

# On top of that, every time we pivoted and inserted new material, we ended up moving those columns to the right of the table.
# To fix this, I manually reorganized each column to how I thought would be best.

# Alright, now we have a data set that is organized in it's values and observations. While there are still remaining NA values, I'd rather preserve the data rather than try and scrub it too clean.



### ------ Creating Figures ------ ###



## -- Bar Graph of Parental Care Type -- ##

plot_care_type <- td_rename_reorder %>%
  summarize(no_parental_care = sum(no_parental_care,
                                   na.rm = TRUE),
            male_parental_care = sum(male_parental_care,
                                     na.rm = TRUE),
            female_parental_care = sum(female_parental_care,
                                       na.rm = TRUE),
            biparental_care = sum(biparental_care,
                                           na.rm = TRUE)) %>%
  pivot_longer(everything(),
               names_to = "care_type",
               values_to = "count")

# In this step, I'm creating a dataframe that has been pivoted and can be called when actually making the plot.


ggplot(plot_care_type,
       aes(x = care_type,
           y = count,
           fill = care_type)) +
  geom_col() +
  theme_minimal() +
  labs(title = "Total Count of Parental Care Types",
       x = "Care Type",
       y = "Number of Observations") +
  theme(legend.position = "none")

# Here, we are taking our different parental care types and comparing them through a bar graph system. I thought this would be best, since I'm just summing up the binary 1s and counting them to show scale. 
# I figured I didn't need a legend, since it's a simple comparison where the axes tell us everything we need to know.


## -- Bar Graph of Parental Behaviors -- ##

plot_m_f_protection <- td_rename_reorder %>%
  summarize(male_nest_protection = sum(male_nest_protection,
                                   na.rm = TRUE),
            female_nest_protection = sum(female_nest_protection,
                                     na.rm = TRUE),
            male_parental_attendance = sum(male_parental_attendance,
                                       na.rm = TRUE),
            female_parental_attendance = sum(female_parental_attendance,
                                  na.rm = TRUE),
            male_back_carrying = sum(male_back_carrying,
                                             na.rm = TRUE),
            female_back_carrying = sum(female_back_carrying,
                                             na.rm = TRUE),
            male_internal_carrying = sum(male_internal_carrying,
                                             na.rm = TRUE),
            female_internal_carrying = sum(female_internal_carrying,
                                             na.rm = TRUE),
            female_viviparity = sum(female_viviparity,
                                             na.rm = TRUE)) %>%
  pivot_longer(everything(),
               names_to = "type",
               values_to = "count") %>%
  separate(type, into = c("sex", "behavior"),
           sep = "_", extra = "merge")

# Much like the last plot, I'm creating a dataframe that has been pivoted and can be called when actually making the plot.
# This version is slightly more complex, because we have more objects to use and the idea is to compare two groups together.


ggplot(plot_m_f_protection,
       aes(x = behavior,
           y = count,
           fill = sex)) +
  geom_col(position = "dodge") +
  coord_flip() +
  scale_y_continuous(breaks = seq(0,
                                  max(plot_m_f_protection$count),
                                  by = 25)) +
  theme_minimal() +
  labs(title = "Parental Behaviors by Sex",
       x = "Behvaior",
       y = "Number of Observations",
       fill = "sex")

# Here, we are actually making the plot. I changed the position and scale of everything to better fit the idea in my head to allow for the best comparison I could think of. I think this one turned out really well.
# Since we're comparing two groups in five different categories, we need the legend to discern what we're looking at, so we don't have the code removing it here.

### ------ END ------ ###