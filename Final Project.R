# Dhanush Devanand
# Independent Project - SLA Analysis
# Dataset: Specific leaf area is lower on ultramafic than on neighbouring non-ultramafic soils
# Hulshof et al. 2022 | https://doi.org/10.5061/dryad.573n5tbbr

# ============================================================
# 1. Load Libraries
# ============================================================

library(tidyverse)  # dplyr, ggplot2, readr, stringr, tidyr

# ============================================================
# 2. Load Data
# ============================================================

# Main SLA dataset: species-level mean SLA with soil type, region, and climate info
sla_data <- read_csv("data_sla_means.csv")

# ============================================================
# 3. Inspect the Data
# ============================================================

# Check structure and column names
str(sla_data)
colnames(sla_data)
# Columns in sla_data: Region, Soil, Taxon, SLA, Clim, AnnTemp, AnnPrecip, PercentWoody

# Preview first few rows
head(sla_data)

# Check how many rows and unique species
nrow(sla_data)
n_distinct(sla_data$Taxon)

# Check unique values in key categorical columns
unique(sla_data$Soil)
unique(sla_data$Region)
unique(sla_data$Clim)

# Check for missing values in each column
colSums(is.na(sla_data))

# ============================================================
# 4. Tidy the Data
# ============================================================

# Recode Soil abbreviations to full descriptive labels
# TRUE ~ Soil keeps any unexpected values as-is rather than turning them into NA
sla_data <- sla_data %>%
  mutate(Soil = case_when(
    Soil == "U"  ~ "Ultramafic",
    Soil == "NU" ~ "Non-ultramafic",
    TRUE ~ Soil
  ))

# Replace underscores in Region names with spaces for cleaner plot labels
sla_data <- sla_data %>%
  mutate(Region = str_replace_all(Region, "_", " "))

# Add a Genus column by pulling the first word out of Taxon
# This helps standardize species IDs since some entries use only genus names
# while others have full binomials (addresses feedback about taxon inconsistency)
sla_data <- sla_data %>%
  mutate(Genus = word(Taxon, 1))

# Remove rows with missing SLA values
sla_data <- sla_data %>%
  filter(!is.na(SLA))

# Confirm everything looks right after tidying
glimpse(sla_data)
table(sla_data$Soil)
table(sla_data$Region)
table(sla_data$Clim)

# ============================================================
# 5. Summarize Data
# ============================================================

# Summary stats by soil type (across all regions)
summary_soil <- sla_data %>%
  group_by(Soil) %>%
  summarize(
    n        = n(),
    mean_SLA = mean(SLA, na.rm = TRUE),
    median_SLA = median(SLA, na.rm = TRUE),
    sd_SLA   = sd(SLA, na.rm = TRUE),
    se_SLA   = sd_SLA / sqrt(n),
    min_SLA  = min(SLA, na.rm = TRUE),
    max_SLA  = max(SLA, na.rm = TRUE),
    .groups  = "drop"
  )

print(summary_soil)

# Summary stats by Region and Soil type
summary_region <- sla_data %>%
  group_by(Region, Soil) %>%
  summarize(
    n        = n(),
    mean_SLA = mean(SLA, na.rm = TRUE),
    sd_SLA   = sd(SLA, na.rm = TRUE),
    se_SLA   = sd_SLA / sqrt(n),
    .groups  = "drop"
  )

print(summary_region)

# Summary stats by climate zone and soil type
summary_clim <- sla_data %>%
  group_by(Clim, Soil) %>%
  summarize(
    n        = n(),
    mean_SLA = mean(SLA, na.rm = TRUE),
    sd_SLA   = sd(SLA, na.rm = TRUE),
    se_SLA   = sd_SLA / sqrt(n),
    .groups  = "drop"
  )

print(summary_clim)

# Overall mean and range of SLA across the entire dataset
overall_mean <- mean(sla_data$SLA, na.rm = TRUE)
overall_min  <- min(sla_data$SLA, na.rm = TRUE)
overall_max  <- max(sla_data$SLA, na.rm = TRUE)

cat("Overall mean SLA:", overall_mean, "\n")
cat("Overall SLA range:", overall_min, "to", overall_max, "\n")

# How many species per region?
species_per_region <- sla_data %>%
  group_by(Region) %>%
  summarize(n_species = n_distinct(Taxon), .groups = "drop")

print(species_per_region)

# ============================================================
# 6. Figure 1: Boxplot - SLA by Soil Type
# ============================================================

fig1 <- ggplot(sla_data, aes(x = Soil, y = SLA, fill = Soil)) +
  geom_boxplot(outlier.shape = 21, outlier.size = 1.8, alpha = 0.75) +
  labs(
    title   = "Specific Leaf Area by Soil Type",
    x       = "Soil Type",
    y       = "SLA (cm2 per g)",
    caption = "Figure 1. Distribution of SLA values for plants on ultramafic and non-ultramafic soils. Plants growing on ultramafic soils generally have lower SLA values, which suggests they may have thicker, tougher leaves due to harsher soil conditions."
  ) +
  theme_bw(base_size = 13) +
  theme(
    legend.position = "none",
    plot.caption    = element_text(hjust = 0, size = 9)
  )

fig1
ggsave("fig1_boxplot_SLA_by_soil.png", plot = fig1, width = 6, height = 5, dpi = 300)

# ============================================================
# 7. Figure 2: Bar Chart - Mean SLA by Region and Soil Type
# (two bars per region for direct within-region comparison,
#  as suggested in feedback from Bailey Dixon and Kim Komatsu)
# ============================================================

fig2 <- ggplot(summary_region, aes(x = Region, y = mean_SLA, fill = Soil)) +
  geom_col(position = position_dodge(width = 0.8), width = 0.7, alpha = 0.85) +
  geom_errorbar(
    aes(ymin = mean_SLA - se_SLA, ymax = mean_SLA + se_SLA),
    position = position_dodge(width = 0.8),
    width = 0.25
  ) +
  labs(
    title   = "Mean SLA Across Regions and Soil Types",
    x       = "Region",
    y       = "Mean SLA (cm2 per g)",
    fill    = "Soil Type",
    caption = "Figure 2. Mean SLA (± SE) for each region, separated by soil type. In most regions, plants on ultramafic soils have lower SLA compared to nearby non-ultramafic soils, showing a consistent pattern across locations."
  ) +
  theme_bw(base_size = 13) +
  theme(
    axis.text.x  = element_text(angle = 30, hjust = 1),
    plot.caption = element_text(hjust = 0, size = 9)
  )

fig2
ggsave("fig2_bar_SLA_by_region.png", plot = fig2, width = 8, height = 5, dpi = 300)

# ============================================================
# 8. Figure 3: Scatterplot - SLA vs. Annual Temperature by Soil Type
# Uses AnnTemp already in sla_data to ask whether the SLA difference
# between soil types holds across different climate conditions
# ============================================================

fig3 <- ggplot(sla_data, aes(x = AnnTemp, y = SLA, color = Soil)) +
  geom_point(alpha = 0.45, size = 1.8) +
  labs(
    title   = "SLA vs. Annual Temperature by Soil Type",
    x       = "Annual Mean Temperature (C)",
    y       = "SLA (cm2 per g)",
    color   = "Soil Type",
    caption = "Figure 3. Relationship between annual temperature and SLA for both soil types. Ultramafic plants tend to have lower SLA across the temperature range, suggesting the soil effect is consistent even as climate changes."
  ) +
  theme_bw(base_size = 13) +
  theme(
    plot.caption = element_text(hjust = 0, size = 9)
  )

fig3
ggsave("fig3_scatter_SLA_vs_temp.png", plot = fig3, width = 7, height = 5, dpi = 300)
