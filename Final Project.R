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
library(stringr)
install.packages("ggplot2")
library(ggplot2)
~~~~~~~~~

===============================================================================
 Sec 1.0: Tidy up - Breaking down to 3 Treatments
===============================================================================
# We will be pulling the data from the "Trial3_JV.csv". This 
# file contains all of the data that was collected from Trial 3 of the lipid 
# droplet count. 

trial3 <- read_csv("Trial3_JV.csv")

# Once, I import this dataset, I want to see if the data is numerical or 
# characters. I can do this by running the function str().
str(trial3)
$ Sample     : chr [1:837] "CA1" "CA2" "CA3" "CA4" ...
$ Area       : num [1:837] 330.7 391.1 29.1 168.4 377.2 ...
$ Mean       : num [1:837] 93.7 101.3 115.5 107 94.8 ...
$ Min        : num [1:837] 41 69 93 71 44 58 71 77 85 103 ...
$ Max        : num [1:837] 255 255 255 255 255 255 255 255 255 255 ...
$ Radius     : num [1:837] 10.26 11.16 3.04 7.32 10.96 ...
$ Diameter   : num [1:837] 20.52 22.32 6.09 14.64 21.92 ...
$ Cell counts: logi [1:837] NA NA NA NA NA NA ...

# The results provided shows that sample is characters (as expected) and 
# the rest are numbers. Execpt "Cell counts", which were all empty in the 
# original csv. This can be deleted from the dataset using select().

trial3_Com <- trial3 %>% 
  select(-"Cell counts")

# I will double check if this column has been removed. Which it has! Now, the 
# dataframe has all real values that R can recognize.

str(trial3_Com)
$ Sample  : chr [1:837] "CA1" "CA2" "CA3" "CA4" ...
$ Area    : num [1:837] 330.7 391.1 29.1 168.4 377.2 ...
$ Mean    : num [1:837] 93.7 101.3 115.5 107 94.8 ...
$ Min     : num [1:837] 41 69 93 71 44 58 71 77 85 103 ...
$ Max     : num [1:837] 255 255 255 255 255 255 255 255 255 255 ...
$ Radius  : num [1:837] 10.26 11.16 3.04 7.32 10.96 ...
$ Diameter: num [1:837] 20.52 22.32 6.09 14.64 21.92 ...

# If I wanted to compare the 3 treatments, I would need to seperate the values
# by Control, DMSO, and Naringenin (Nar). I can do this by the filter() 
# function.

# This pulls all the controls. We can double check the observations to determine
# if the dataframe sorted correctly. Which, the total number of observations 
# is currently 837. When filtering out the control, it becomes 397, signifying
# that the dataframe has been split out perfectly.

con_3 <- trial3_Com %>% 
  filter(str_detect(Sample, "C"))

# This pulls the DMSO. 837 observations to 372 observations.

dmso_3 <- trial3_Com %>% 
  filter(str_detect(Sample, "D"))

# This pulls the Nar. 837 observations to 301 observations.

nar_3 <- trial3_Com %>% 
  filter(str_detect(Sample, "N"))

# Hold on! How did the 3 dataframes created not equal to 837 observations? 
# Clearly, I didn't account for something in my code. 

# By double checking, the Sample column, we see that all values does have the 
# desired treatment letter (C, D, N) but each treatment is paired through A-B. 
# This means I must be more specific on how I identify the filter!

con_3 <- trial3_Com %>% 
  filter(substr(Sample, 1, 1) == "C")

# By running substr, we can determine the order that we are looking for the 
# desired trial! For example: 1, 1 shows that you are looking for one C and 
# that is should be in the 1st spot of the value.

# The observations of con_3 went from 397 to 266 observations!

# Now lets follow up with the following dataframes:

dmso_3 <- trial3_Com %>% 
  filter(substr(Sample, 1, 1) == "D")

# 372 observations down to 270.

nar_3 <- trial3_Com %>% 
  filter(substr(Sample, 1, 1) == "N")

# nar_3 stays at 301 observations but this due to N not reappearing in the 2nd
# character.
# Just to double check, I will add the values. You can do this by manually 
# adding or by using "==" to determine if it's a true or false statement.

# Manually adding:
266 + 270 + 301
--> 837

# True or False: 
266 + 270 + 301 == 837
--> TRUE

===============================================================================
  Sec 1.1: Tidy up - Group by ranges
===============================================================================

# Now that we have our treatments sorted, we want to compare the diameters of 
# the lipid droplets per trial. In order to reduce the number of individual
# points, we want to sort them into 3 ranges: small(x < 8.0), 
# medium (8.1-16.09), and Large (16.1).

# We will start with control: 
# First, I create a new column that will label each row's diameter to their 
# range size.

con3_range <- con_3 %>%
  mutate(DiameterRange = case_when(
      Diameter <= 8 ~ "<= 8",
      Diameter > 8 & Diameter <= 16 ~ "8–16",
      Diameter > 16 ~ "> 16"))

# Then, we tally up the total number of each range. We can double check the
# numbers to observations by using count() within the desired column. 
# We combine all the samples that fall under these 3 ranges to create 3 groups.

con3_range %>%
  count(DiameterRange)

con3_TotalRange <- con3_range %>%
  group_by(DiameterRange) %>%
  summarize(n = n())

# I will rename the n column to Control_Sample.

con3_TotalRange <- con3_TotalRange %>%
  rename(Control_Sample = n )

# The row order is mismatched and not ascending order. 

con3_TotalRange <- con3_TotalRange %>% arrange(DiameterRange)

# Due to the nature of the labeling, I have to manually reorder the rows. So I

con3_TotalRange <- con3_TotalRange %>%
  mutate(DiameterRange = factor(DiameterRange, levels = c("<= 8", "8–16", "> 16"))) %>%
  arrange(DiameterRange)

# Finally, we can double check the format of the data by visualizing the data
# in a column graph. The tile of the column graph will be "Diameter Range of 
# Control Samples", x axis will be "Diameter Range (um)" since the diameters 
# are measured in micrometer, and lastly, the y axis will be called "Control 
# Sample Count". I'll break the y intervals by 10 due to the highest number 
# being 134. 

ggplot(con3_TotalRange , aes(x = DiameterRange, y = Control_Sample)) +
  geom_col(fill = "purple") +
  scale_y_continuous(
    breaks = seq(0, max(con3_TotalRange$Control_Sample, na.rm = TRUE), by = 10)) +
  labs(
    title = "Diameter Range of Control Samples",
    x = "Diameter Range (um)",
    y = "Control Sample Count") +
  theme_minimal()

# This creates a column graph that shows the range distribution of the control
# data. It helps understand how the lipid droplet diameters would look across 
# 5 different samples within the control treatment. 

# Now, we will repeat the same for the DMSO and Nar treatments.

dmso3_range <- dmso_3 %>%
  mutate(DiameterRange = case_when(
    Diameter <= 8 ~ "<= 8",
    Diameter > 8 & Diameter <= 16 ~ "8–16",
    Diameter > 16 ~ "> 16"))

dmso3_range %>%
  count(DiameterRange)

# Count() makes sure that the data range did set up correctly. If there are 
# any NA's. The graphing will error out or miss a data point. 

dmso3_TotalRange <- dmso3_range %>%
  group_by(DiameterRange) %>%
  summarize(n = n())

dmso3_TotalRange <- dmso3_TotalRange %>%
  rename(Control_Sample = n )

dmso3_TotalRange <- dmso3_TotalRange %>% arrange(DiameterRange)

dmso3_TotalRange <- dmso3_TotalRange %>%
  mutate(DiameterRange = factor(DiameterRange, levels = c("<= 8", "8–16", "> 16"))) %>%
  arrange(DiameterRange)

# Graph the dataset to make sure everything lined up well!

ggplot(dmso3_TotalRange , aes(x = DiameterRange, y = Control_Sample)) +
  geom_col(fill = "blue") +
  scale_y_continuous(
    breaks = seq(0, max(dmso3_TotalRange$Control_Sample, na.rm = TRUE), by = 10)) +
  labs(
    title = "Diameter Range of DMSO Samples",
    x = "Diameter Range (um)",
    y = "DMSO Sample Count") +
  theme_minimal()

# Awesome!Lets wrap up with Nar!

nar3_range <- nar_3 %>%
  mutate(DiameterRange = case_when(
    Diameter <= 8 ~ "<= 8",
    Diameter > 8 & Diameter <= 16 ~ "8–16",
    Diameter > 16 ~ "> 16"))

nar3_range %>%
  count(DiameterRange)

# Count() makes sure that the data range did set up correctly. If there are 
# any NA's. The graphing will error out or miss a data point. 

nar3_TotalRange <- nar3_range %>%
  group_by(DiameterRange) %>%
  summarize(n = n())

nar3_TotalRange <- nar3_TotalRange %>%
  rename(Control_Sample = n )

nar3_TotalRange <- nar3_TotalRange %>% arrange(DiameterRange)

nar3_TotalRange <- nar3_TotalRange %>%
  mutate(DiameterRange = factor(DiameterRange, levels = c("<= 8", "8–16", "> 16"))) %>%
  arrange(DiameterRange)


# Graph the dataset to make sure everything lined up well!

ggplot(nar3_TotalRange , aes(x = DiameterRange, y = Control_Sample)) +
  geom_col(fill = "red") +
  scale_y_continuous(
    breaks = seq(0, max(nar3_TotalRange$Control_Sample, na.rm = TRUE), by = 10)) +
  labs(
    title = "Diameter Range of Nar Samples",
    x = "Diameter Range (um)",
    y = "Nar Sample Count") +
  theme_minimal()

===============================================================================
  Sec 2.0: Graphing - Comparison of 3 treatment to another
===============================================================================

# All 3 graphs help show the lipid droplet diameter of each treatment. Now I 
# would like to recombine them all so they may be compared side by side. 

# Following a similar guideline to how the ranges were assigned, I will create 
# another column to label each row with their treatment.

mcon3_TotalRange  <- con3_TotalRange  %>% mutate(Treatment = "con")
mdmso3_TotalRange <- dmso3_TotalRange %>% mutate(Treatment = "dmso")
mnar3_TotalRange  <- nar3_TotalRange  %>% mutate(Treatment = "nar")

# Then I will combine the 3 dataframes into 1.

all_treatments <- bind_rows(mcon3_TotalRange, mdmso3_TotalRange, mnar3_TotalRange)

# Great! Now that we have all the treatments combined, we can plot a column 
# graph.

ggplot(all_treatments, aes(x = DiameterRange, y = Control_Sample, fill = Treatment)) +
  geom_col(position = "dodge") +
  scale_y_continuous(breaks = seq(0, max(all_treatments$Control_Sample), by = 10)) +
  labs(
    title = "Diameter Range Counts Across Treatments",
    x = "Diameter Range",
    y = "Count") +
  theme_minimal()

# What is good about a column graph for this data is that it helps visualize 
# the number of lipid droplets while also emphasizing the diameter ranges seen 
# in all 3 treatments.


===============================================================================
  Sec 2.1: Graphing - Mosaic Layout to discover distribution.
===============================================================================
# A Mosaic graph can help reorder this data while still emphasizing that the lipid droplet size distribution has changed. 
  
# Looking towards Copilot to find a more approachable package for mosaics. 
# I found ggmosaic. It provides a way to add "weight" to data, allowing for the 
# original data to still be accurate while allowing the size of each block to 
# adjust.
  
  install.packages("ggmosaic")

# Before graphing, I need to make sure that ggmosaic can recognize the right 
# columns that are neccesary to plot the data. We would want diameter range to
# be our x-axis while y-axis is the treatment. Although this may seem odd, many 
# mosaic plots do follow a similar set up to the data display. 

str(all_treatments)
tibble [9 × 3] (S3: tbl_df/tbl/data.frame)
$ DiameterRange : Factor w/ 3 levels "<= 8","8–16",..: 1 2 3 1 2 3 1 2 3
$ Control_Sample: int [1:9] 134 61 71 121 66 83 225 56 20
$ Treatment     : chr [1:9] "con" "con" "con" "dmso" ...

# These are great results! The control_sample are numbers so we can graph the 
# mosaic graph!

mosaicplot(
  xtabs(Control_Sample ~ DiameterRange + Treatment, data = all_treatments),
  color = c("purple", "blue", "red"),
  main = "Mosaic Plot of Diameter Range by Treatment",
  xlab = "Diameter Range",
  ylab = "Treatment")

# xtabs() is the weight function needed to convert the raw data into "weighted" 
# data. Allowing for the proportions of the blocks to follow the trend of the 
# data. 

# Similar to a percentage chart, this further aids in understanding how 
# naringenin is lowering the average largest lipid droplets and potentially
# redistributing it out as smaller droplets!

===============================================================================
  Sec 3.0: Challenges - Total counts comparison among trials
===============================================================================
# Another goal of our data was to observe how the lipid droplets were 
# distributed due to the adipocytes taking up about the same amount of glucose. 
# (Disproving that the naringenin treated cells were just adjusting to lower 
# glucose uptake.) 
  
# The data would emphasis that naringenin caused the lipid 
# distribution to spread out across the cell, decreasing the rise in potential 
# insulin insensitivity. 
  
  ggplot(all_treatments, aes(x = Treatment, y = Control_Sample, fill = Treatment)) +
  geom_boxplot() +
  scale_fill_brewer(palette = "Set2") +
  scale_y_continuous(
    breaks = seq(0, max(all_treatments$Control_Sample), by = 10)) +
  labs(
    title = "Total Lipid Droplet Counts by Treatment",
    x = "Treatment",
    y = "Count") +
  theme_minimal()

===============================================================================
  Sec 3.1: Challenges - Looking into the total areas
===============================================================================
# In this section, we are continuing to challenge the opposing theory that the 
# adipocytes are not receiving the equilvant amount of glucose based on the 
# treatments. 
  
# The first step is to look into each treatments total area. In theory, the 
# adipocytes will be storing about the same amount of energy via lipid droplets
# area. 
  
# In our dataframes, I have area provided for each droplet counted. I can 
# select this column so we can begin graphing it!

con_area  <- con3_range  %>% select(Area)

dmso_area <- dmso3_range %>% select(Area)

nar_area  <- nar3_range  %>% select(Area)

# Then, I will sum up the areas. I made sure to add na.rm as I want to make 
# sure that there are no NA values that can appear.

con_total_area  <- sum(con_area$Area, na.rm = TRUE)

dmso_total_area <- sum(dmso_area$Area, na.rm = TRUE)

nar_total_area  <- sum(nar_area$Area, na.rm = TRUE)

# Lastly, I will combine it all into one table so it is easier to graph!

area_summary <- data.frame(
  Treatment = c("con", "dmso", "nar"),
  TotalArea = c(con_total_area, dmso_total_area, nar_total_area))

# Taking a look at the values from this dataframe, it strongly suggest that 
# the total area accounted for varies greatly among the 3 treatments. This 
# can have many reasons behind it such as human error or biases when taking 
# microscopy photos of the lipid droplet regions on each adipocyte. 

# Regardless, of these concerns, we can still observe which trials have this 
# discrepancy.

===============================================================================
  Sec 3.2: Challenges - A slice of the debunk
===============================================================================
# I will create 2 graphs in this section to address the concern of total 
# area of the lipid droplets counted in each treatment.
  
# The first will be a pie chart. Although, it may not be the most accurate 
# chart, it does highlight where the biggest totals are located. 

ggplot(area_summary, aes(x = "", y = TotalArea, fill = Treatment)) +
  geom_col(width = 1, color = "white") +
  coord_polar(theta = "y") +
  scale_fill_manual(values = c(
    "con"  = "purple", 
    "dmso" = "blue",  
    "nar"  = "red"    )) +
  labs(
    title = "Total Lipid Droplet Area per Treatment",
    fill = "Treatment") +
  theme_void()

# The second chart will be a column chart. Similar to a pie chart, it will be 
# a direct visual to the proportions of the total areas compared to each other. 
# What makes this a better option is that it is easier to display the total 
# area along the y-axis.

ggplot(area_summary, aes(x = "Total Area", y = TotalArea, fill = Treatment)) +
  geom_col() +
  labs(
    title = "Stacked Column Chart of Total Lipid Droplet Area",
    x = "",
    y = "Total Area"
  ) +
  scale_fill_manual(values = c(
    "con"  = "purple", 
    "dmso" = "blue",  
    "nar"  = "red"    )) +
  theme_minimal()


