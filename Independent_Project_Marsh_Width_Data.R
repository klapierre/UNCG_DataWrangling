--------------------------------------------------------------------------------
### Independent Project: Marsh Width Data ###
#  By: Caroline Cronin
--------------------------------------------------------------------------------

### Ecological Questions: 
  # How does sea level rise affect marsh width? 
  # Does the amount of sediment affect marsh width in coastal marsh ecosystems? 
  # Does the presence of seagrass increase marsh width compared to marshes without seagrass? 
  
--------------------------------------------------------------------------------
 ### Pseudo-Code ###
--------------------------------------------------------------------------------
###Project Workflow:
# First, I will load the packages I need using library(tidyverse). Then I will import the marsh dataset into R using read_csv() and use the skip = argument so the text descriptions above the data are ignored. After that I will look at the data using glimpse(), summary(), head(), and colnames() to see what variables are included and make sure the data loaded in correctly. I will also check for missing values using colSums(is.na()). Next, I will clean the data by remvoing missing values and making sure the important variables, including relative sea level rise (RSLR), bay sediment flux (BSF), and marsh width, are in the correct format. Then I will use pivot_longer() to reshape the marsh width columns into a longer format so that marsh width with seagrass and without seagrass can be compared more easily in the same figures. I will also summarize the dataset by grouping it based on the relative sea level rise (RSLR) using group_by() and I will calculate summary statistics like the mean marsh width, standard deviation, and standard error of marsh width with seagrass and without seagrass. Finally, I will create three figures using ggplot(). Figure 1 will use geom_jitter() and geom_smooth() to show the relationship between sea level rise and marsh width. Figure 2 will use geom_jitter() and facet_wrap() to show how bay sediment flux relates to marsh width across different RSLR levels. Figure 3 will use geom_boxplot(), geom_jitter(), and facet_wrap() to compare marsh width with and without seagrass across different sea levle rise levels. 

library(tidyverse) 

# load data
marsh <- read_csv("data/GEOMBESTSeagrass_Widthdata.csv", skip = 22) 

# look at data
glimpse(marsh)

summary(marsh)

head(marsh) 

colSums(is.na(marsh))

colnames(marsh) 

# Check the structure of important variables.
unique(marsh$RSLR)
unique(marsh$BSF)

# Check dimensions before cleaning.
dim(marsh)

# Count missing values by column.
missing_values <- marsh %>%
  summarize(across(everything(), ~sum(is.na(.))))

missing_values

# Clean data by removing missing values. 
marsh_clean <- marsh %>%
  drop_na()

# Check dimensions after cleaning.
dim(marsh_clean)

# Make sure important variables are numeric. 
marsh_clean <- marsh_clean %>%
  mutate(RSLR = as.numeric(RSLR), BSF = as.numeric(BSF), Width_Seagrass = as.numeric(Width_Seagrass), Width_NoSeagrass = as.numeric(Width_NoSeagrass), Width_Difference = as.numeric(Width_Difference))

# Create a variable describing whether seagrass marshes are wider. 
marsh_clean <- marsh_clean %>%
  mutate( Seagrass_Effect = case_when(Width_Difference > 0 ~ "Seagrass wider", Width_Difference < 0 ~ "No seagrass wider", Width_Difference == 0 ~ "No difference" ))


# Reshape data
marsh_long <- marsh_clean %>%
  pivot_longer(cols = c(Width_Seagrass, Width_NoSeagrass), names_to = "Condition", values_to = "Marsh_Width") %>%
  mutate(Condition = recode(Condition, Width_Seagrass = "With seagrass", Width_NoSeagrass = "Without seagrass"))

# Calculating means, standard deviations, and standard errors 
Summary_rslr <- marsh_long %>% 
  group_by(RSLR, Condition) %>%
  summarize(mean_width = mean(Marsh_Width), sd_width = sd(Marsh_Width), n = n(), se_width = sd_width / sqrt(n), .groups = "drop")

Summary_rslr

# Summary of width difference between seagrass and no seagrass.
Summary_difference <- marsh_clean %>%
  group_by(RSLR) %>%
  summarize(mean_difference = mean(Width_Difference), sd_difference = sd(Width_Difference), n = n(), se_difference = sd_difference / sqrt(n), .groups = "drop")

Summary_difference


### Figure 1. 
# Answers: How does sea level rise affect marsh width? 

ggplot(marsh_long, aes(x = RSLR, y = Marsh_Width, color = Condition)) +
  geom_jitter(width = 0.08, alpha = 0.6, size = 2) +
  geom_smooth(method = "lm", se = FALSE) +
  scale_color_manual(values = c("With seagrass" =  "#009E73", "Without seagrass"= "#E69F00")) +
  labs(title = "Effect of Sea Level Rise on Marsh Width", x = "Sea Level Rise (mm/yr)", y = "Marsh Width (m)", color = "Condition") +
  theme_bw()
  

### Figure 2. 
# Answers: Does the amount of sediment affect marsh width in coastal marsh ecosystems?

ggplot(marsh_long, aes(x = BSF, y = Marsh_Width, color = Condition)) +
  geom_jitter(width = 0.8, alpha = 0.6, size = 1.8) +
  facet_wrap(~ RSLR, labeller = label_both) +
  scale_color_manual(values = c("With seagrass" =  "#009E73", "Without seagrass"= "#E69F00")) +
  labs(title = "Effect of Sediment Flux on Marsh Width Across Sea Level Rise Levels", x = "Bay Sediment Flux (BSF)", y = "Marsh Width (m)", color = "Condition") +
  theme_bw()


### Figure 3.
# Answers does the presence of seagrass increase marsh width compared to marsh’s without seagrass?

ggplot(marsh_long, aes(x = Condition, y = Marsh_Width, fill = Condition)) + geom_boxplot(alpha = 0.7, outlier.alpha = 0.5) +
  geom_jitter(width = 0.1, alpha = 0.3, size = 1) +
  facet_wrap(~ RSLR, labeller = label_both) +
  scale_fill_manual(values = c("With seagrass" =  "#009E73", "Without seagrass"= "#E69F00")) +
  labs(title = "Marsh Width With vs Without Seagrass", subtitle = "Each panel shows one RSLR level, making it easier to compare seagrass conditions", x = "Seagrass Condition", y = "Marsh Width (m)", fill = "Condition") +
  theme_bw() +
  theme(legend.position = "none", axis.text.x = element_text(angle = 25, hjust = 1))







Citations: Reeves, I. and L. Moore. 2020. Marsh widths from GEOMBEST++Seagrass simulations of barrier-marsh-bay evolution ver 1. Environmental Data Initiative.
### https://doi.org/10.6073/pasta/108acb387e6d3c44631858621d12d20b 