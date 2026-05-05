library(tidyverse)
library(dplyr)
library(stringr)
library(ggplot2)

Ithaca_NY_Garden <- read.csv(file = "raw+data+ithaca+garden+2008.csv")

Ithaca_NY_Garden_Clean <- Ithaca_NY_Garden %>% 
  rename(
  Population = POP,
  Family = FAM,
  Plant_ID = ID,
  Trichomes = TRICHOMES,
  Latex = LATEX,
  Specific_Leaf_Area = SLA,
  Water = WATER,
  Damage = DAM,
  Aphids_Present = APHIDS,
  Browsed = BROWSED) %>% 
  arrange(Population) %>% 
  tidyr::drop_na()

Second_NY_Garden <- read.csv(file = "Data-Traits-roof-all+veg+traits.csv")

names(Second_NY_Garden) <- names(Second_NY_Garden) %>%
  str_replace_all("\\.", "_") %>%
  str_replace_all("No.", "Number") %>%
  str_replace_all("M", "Mass") %>% 
  str_replace_all("_$", "") 
  
Second_NY_Garden <- Second_NY_Garden %>% 
  tidyr::drop_na() %>% 
  select(Population, ID_Number, everything())

Ithaca_NY_Garden_Summary_Statistics_Trichomes <- Ithaca_NY_Garden_Clean %>%
  group_by(Population) %>%
  summarise(mean_trichomes = mean(Trichomes),
  se_trichomes = sd(Trichomes) / sqrt(n())) %>%
  arrange(mean_trichomes)

ggplot(Ithaca_NY_Garden_Summary_Statistics_Trichomes, 
  aes(x = Population, y = mean_trichomes)) +
  geom_col(fill = "lightblue", color = "darkblue") +
  geom_errorbar(aes(ymin = mean_trichomes - se_trichomes,
  ymax = mean_trichomes + se_trichomes),
  width = .4) +
  labs(title = "Mean Number of Trichomes Per Population",x = "Population",
  y = "Mean Number of Trichomes") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 7))

ggsave("Ithaca_NY_Garden_Summary_Statistics_Trichomes.png")
  
Ithaca_NY_Garden_Summary_Statistics_Latex <- Ithaca_NY_Garden_Clean %>%
  group_by(Population) %>%
  summarise(mean_Latex = mean(Latex),
  se_Latex = sd(Latex) / sqrt(n())) %>%
  arrange(mean_Latex)
  
ggplot(Ithaca_NY_Garden_Summary_Statistics_Latex, 
  aes(x = Population, y = mean_Latex)) +
  geom_col(fill = "lightgreen", color = "darkgreen") +
  geom_errorbar(aes(ymin = mean_Latex - se_Latex,
  ymax = mean_Latex + se_Latex),
  width = .4) +
  labs(title = "Mean Latex Per Population",x = "Population",
  y = "Mean Latex") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 7))

ggsave("Ithaca_NY_Garden_Summary_Statistics_Latex.png")

Ithaca_NY_Garden_Summary_Statistics_Specific_Leaf_Area <- 
  Ithaca_NY_Garden_Clean %>%
  group_by(Population) %>%
  summarise(mean_Specific_Leaf_Area = mean(Specific_Leaf_Area),
  se_Specific_Leaf_Area = sd(Specific_Leaf_Area) / sqrt(n())) %>%
  arrange(mean_Specific_Leaf_Area)

ggplot(Ithaca_NY_Garden_Summary_Statistics_Specific_Leaf_Area, 
  aes(x = Population, y = mean_Specific_Leaf_Area)) +
  geom_col(fill = "yellow", color = "orange") +
  geom_errorbar(aes(ymin = mean_Specific_Leaf_Area - se_Specific_Leaf_Area,
  ymax = mean_Specific_Leaf_Area + se_Specific_Leaf_Area),
  width = .4) +
  labs(title = "Mean Specific Leaf Area Per Population",x = "Population",
  y = "Mean Specific Leaf Area") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 7))

ggsave("Ithaca_NY_Garden_Summary_Statistics_Specific_Leaf_Area.png")

Second_NY_Garden_Summary_Statistics_Number_Root_Buds<- 
  Second_NY_Garden %>%
  group_by(Population) %>%
  summarise(mean_Number_Root_Buds = mean(Number_Root_Buds),
  se_Number_Root_Buds = sd(Number_Root_Buds) / sqrt(n())) %>%
  arrange(mean_Number_Root_Buds)

ggplot(Second_NY_Garden_Summary_Statistics_Number_Root_Buds, 
  aes(x = Population, y = mean_Number_Root_Buds)) +
  geom_col(fill = "orange", color = "red") +
  geom_errorbar(aes(ymin = mean_Number_Root_Buds - se_Number_Root_Buds,
  ymax = mean_Number_Root_Buds + se_Number_Root_Buds),
  width = .4) +
  labs(title = "Mean Number of Root Buds Per Population",x = "Population",
  y = "Mean Number of Root Buds") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 7))

ggsave("Second_NY_Garden_Summary_Statistics_Number_Root_Buds.png")

Second_NY_Garden_Summary_Statistics_Mass_Roots_g<- 
  Second_NY_Garden %>%
  group_by(Population) %>%
  summarise(mean_Mass__Roots__g = mean(Mass__Roots__g),
  se_Mass__Roots__g = sd(Mass__Roots__g) / sqrt(n())) %>%
  arrange(mean_Mass__Roots__g)

ggplot(Second_NY_Garden_Summary_Statistics_Mass_Roots_g, 
  aes(x = Population, y = mean_Mass__Roots__g)) +
  geom_col(fill = "pink", color = "purple") +
  geom_errorbar(aes(ymin = mean_Mass__Roots__g - se_Mass__Roots__g,
  ymax = mean_Mass__Roots__g + se_Mass__Roots__g),
  width = .4) +
  labs(title = "Mean Root Mass Per Population",x = "Population",
  y = "Mean Mass of Roots (g)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 7))

ggsave("Second_NY_Garden_Summary_Statistics_Mass_Roots_g.png")

Second_NY_Garden_Summary_Statistics_Mass__Shoot__Biomass_g <- 
  Second_NY_Garden %>%
  group_by(Population) %>%
  summarise(mean_Mass__Shoot_Biomass__g =
  mean(Mass__Shoot_Biomass__g, na.rm = TRUE),
  se_Mass__Shoot_Biomass__g = sd(Mass__Shoot_Biomass__g, 
  na.rm = TRUE) / sqrt(sum(!is.na(Mass__Shoot_Biomass__g)))) %>%
  arrange(mean_Mass__Shoot_Biomass__g)

ggplot(Second_NY_Garden_Summary_Statistics_Mass__Shoot__Biomass_g,
  aes(x = Population, y = mean_Mass__Shoot_Biomass__g)) +
  geom_col(fill = "green", color = "brown") + 
  geom_errorbar(aes(ymin = mean_Mass__Shoot_Biomass__g 
  - se_Mass__Shoot_Biomass__g,
  ymax = mean_Mass__Shoot_Biomass__g + se_Mass__Shoot_Biomass__g),
  width = 0.4) +
  labs(title = "Mean Shoot Biomass Per Population (g)", x = "Population",
  y = "Mean Shoot Biomass (g)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 7))

ggsave("Second_NY_Garden_Summary_Statistics_Mass__Shoot__Biomass_g.png")
