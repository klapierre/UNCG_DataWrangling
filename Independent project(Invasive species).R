# ---------------------------------------------------------- #
#### Invasive Species Dataset: Cleaning + Figures          ####
# ---------------------------------------------------------- #

library(tidyverse)

# ---------------------------------------------------------- #
#### IMPORT DATA                                           ####
# ---------------------------------------------------------- #
#This dataset was obtained from Dryad (DOI: 10.5061/dryad.866t1g1r4).
richness <- read_csv("richness.csv")

glimpse(richness)

# ---------------------------------------------------------- #
#### CLEAN DATA                                            ####
# ---------------------------------------------------------- #

richness_clean <- richness %>%
  mutate(
    site_id = as.factor(site_id),
    forest = as.factor(forest)
  ) %>%
  drop_na(ir, nr, forest)

# ---------------------------------------------------------- #
#### FIGURE 1: NATIVE VS INVASIVE SPECIES                  ####
# ---------------------------------------------------------- #

figure1 <- ggplot(richness_clean, aes(x = nr, y = ir)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Native vs Invasive Species Richness",
    x = "Native Species Richness",
    y = "Invasive Species Richness"
  )

figure1

ggsave("figure1_native_vs_invasive.png", figure1, width = 7, height = 5)

# ---------------------------------------------------------- #
#### FIGURE 2: INVASIVE SPECIES BY FOREST TYPE             ####
# ---------------------------------------------------------- #

figure2 <- ggplot(richness_clean, aes(x = forest, y = ir)) +
  geom_boxplot() +
  labs(
    title = "Invasive Species Richness by Forest Type",
    x = "Forest Type",
    y = "Invasive Species Richness"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

figure2

ggsave("figure2_invasive_by_forest.png", figure2, width = 7, height = 5)

# ---------------------------------------------------------- #
#### FIGURE 3: CANOPY VS INVASIVE               ####
# ---------------------------------------------------------- #

figure3 <- ggplot(richness_clean, aes(x = c, y = ir)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Canopy Cover vs Invasive Species Richness",
    x = "Canopy Cover",
    y = "Invasive Species Richness"
  )

figure3

ggsave("figure3_canopy_vs_invasive.png", figure3, width = 7, height = 5)

