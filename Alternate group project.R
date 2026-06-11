
#We can start with Loading our packages

library(tidyverse)

#Then we are going to open each of the datasets.
biomass <- read_csv("CME012(1).csv)

treatments <- read_csv("conSME_treatments.csv")

#Now we will look at the data

glimpse(biomass)

glimpse(treatments)

colnames(biomass)

colnames(treatments)

unique(biomass$Recyear)

#Next we will run the code that removes the missing values 
# I am goign to be removing the plant biomass values that are missing.

biomass_clean <- biomass %>%
  filter(
    Lvgrass != -999,
    Forb != -999,
    Woody != -999
  )

# Next up we will calulate the plant biomass by adding the grass, forb anf woody biomass measurements together.

#First i am going to group the data .

biomass_plot <- biomass_clean %>%
  group_by(Watershed, Block, Plot, Recyear)
  
#Then we are going to calvulate the averages of the biomass

biomass_plot <- summarize(
  biomass_plot,
  mean_total_biomass = mean(total_biomass)
)

#Now we are going to look at the results 
head(biomass_plot)


#Now we are going to run som code that cleans the dataset up a bit.


treatments_clean <- treatments %>%
  rename(
    Watershed = watershed,
    Block = block,
    Plot = plot
  )

# Merge biomass data with treatment data

biomass_merged <- left_join(
  biomass_plot,
  treatments_clean,
  by = c("Watershed", "Block", "Plot")
)

#Next we will make sure that it worked
head(biomass_merged)

# Now we going to calculate the mean biomass

# First we are going to group the data by watershed, treatment, and year

biomass_summary <- biomass_merged %>%
  group_by(Watershed, bison, Recyear)
#Then we aer going to calculate the average biomass, standard deviation,
# and sample size for each group

biomass_summary <- biomass_summary %>%
  summarize(
    mean_biomass = mean(mean_total_biomass),
    sd_biomass = sd(mean_total_biomass),
    n = n()
  )

# Now we are going to look at the results

head(biomass_summary)


# Now wer are going to calculate the standard error to show how much uncertainty is around the mean

biomass_summary <- biomass_summary %>%
  mutate(se_biomass = sd_biomass / sqrt(n))



# lets rename the watersheds for the graph

# This makes the watershed labels look more like the example graph.

biomass_summary <- biomass_summary %>%
  mutate(
    Watershed = recode(
      Watershed,
      "N4B" = "4 Year",
      "N1A" = "Annual"
    )
  )

# Now we are going to make sure the year and treatment are categories
Make sure treatment and year are treated like categories


biomass_summary <- biomass_summary %>%
  mutate(
    bison = factor(bison, levels = c("B", "X")),
    Recyear = factor(Recyear),
    Watershed = factor(Watershed)
  )


# Now for the fun part we are goingto start making the graph

# WE will start by using the summarized biomass data.

biomass_graph <- ggplot(
  biomass_summary,
  aes(x = bison, y = mean_biomass, fill = bison)
)


# Then we are going to add some bars to show the mean biomass

biomass_graph <- biomass_graph +
  geom_col(
    color = "black"
  )


# Now we are going to add standard error bars

biomass_graph <- biomass_graph +
  geom_errorbar(
    aes(
      ymin = mean_biomass - se_biomass,
      ymax = mean_biomass + se_biomass
    )
  )

#Now we are going to separate panels for each watershed and year.

biomass_graph <- biomass_graph +
  facet_grid(
    Watershed ~ Recyear
  )


# then we are going to add some color to the graph

biomass_graph <- biomass_graph +
  scale_fill_manual(
    values = c("B" = "pink",
               "X" = "lightgreen")
  )



# Now we will label the axes

biomass_graph <- biomass_graph +
  labs(
    x = "",
    y = expression("Total Biomass (g m"^-2*")")
  )


# Remove the legend and gridlines.

biomass_graph <- biomass_graph +
  theme_bw()

biomass_graph <- biomass_graph +
  theme(
    legend.position = "none",
    panel.grid = element_blank()
  )


# Now we are going to look at the graph.

biomass_graph
#And now we are done