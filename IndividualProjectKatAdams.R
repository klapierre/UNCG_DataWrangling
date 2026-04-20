FemaleData <- read.csv("femaledata.txt")
MaleData <- read.csv("maledata.txt")

library(tidyr)
library(tidyverse)

FemaleDataClean <- FemaleData %>%
  separate(col = 1, into = c("Individual", "Performance", "PronotumLength", 
                             "FatContent", "WeightGain", "ElytraLength", 
                             "EclosionWeight", "AdultDiet", "EndBroodBallWeight",
                             "DevelopmentTime"), sep = " ") %>% 
  mutate(Sex = "Female") %>% 
  select(-Individual) %>% 
  mutate(
    Performance = as.numeric(Performance),
    PronotumLength = as.numeric(PronotumLength),
    FatContent = as.numeric(FatContent),
    WeightGain = as.numeric(WeightGain),
    ElytraLength = as.numeric(ElytraLength),
    EclosionWeight = as.numeric(EclosionWeight),
    EndBroodBallWeight = as.numeric(EndBroodBallWeight),
    DevelopmentTime = as.numeric(DevelopmentTime)) %>% 
  mutate(EclosionWeight = EclosionWeight*100,
         FatContent = FatContent*100) %>%
#The original paper's analysis details clarify that eclosion weight and fat content
#were divided by 100 to create a better scale for graphing. I have undone that here
#for better accuracy.
  drop_na()

MaleDataClean <- MaleData %>% 
  separate(col = 1, into = c("Individual", "Performance", "TestesMass",
                             "PronotumLength", "FatContent", "WeightGain", 
                             "ElytraLength", "HornLength", "EclosionWeight", 
                             "AdultDiet", "EndBroodBallWeight","DevelopmentTime"),
                             sep = " ") %>% 
  mutate(Sex="Male") %>% 
  select(-Individual) %>% 
  mutate(
    Performance = as.numeric(Performance),
    TestesMass = as.numeric(TestesMass),
    PronotumLength = as.numeric(PronotumLength),
    FatContent = as.numeric(FatContent),
    WeightGain = as.numeric(WeightGain),
    ElytraLength = as.numeric(ElytraLength),
    HornLength = as.numeric(HornLength),
    EclosionWeight = as.numeric(EclosionWeight),
    EndBroodBallWeight = as.numeric(EndBroodBallWeight),
    DevelopmentTime = as.numeric(DevelopmentTime)) %>% 
  mutate(EclosionWeight = EclosionWeight*100,
         FatContent = FatContent*100) %>%
  drop_na()

CombinedDataClean <- bind_rows(FemaleDataClean, MaleDataClean)

SexSummary <- CombinedDataClean %>% 
  group_by(Sex) %>%
  summarise(
    MeanPerformance = mean(Performance, na.rm = TRUE),
    SDPerformance = sd(Performance, na.rm = TRUE),
    MeanPronotum = mean(PronotumLength, na.rm = TRUE),
    SDPronotum = sd(PronotumLength, na.rm = TRUE),
    MeanFat = mean(FatContent, na.rm = TRUE),
    SDFat = sd(FatContent, na.rm = TRUE),
    MeanWeightGain = mean(WeightGain, na.rm = TRUE),
    SDWeightGain = sd(WeightGain, na.rm = TRUE),
    MeanElytra = mean(ElytraLength, na.rm = TRUE),
    SDElytra = sd(ElytraLength, na.rm = TRUE),
    MeanEclosionWeight = mean(EclosionWeight, na.rm= TRUE),
    SDEclosionWeight = sd(EclosionWeight, na.rm = TRUE),
    MeanBroodBall = mean(EndBroodBallWeight, na.rm = TRUE),
    SDBroodBall = sd(EndBroodBallWeight, na.rm = TRUE),
    MeanDevelopment = mean(DevelopmentTime, na.rm = TRUE),
    SDDevelopment = sd(DevelopmentTime, na.rm = TRUE),
    MeanTestes = mean(TestesMass, na.rm = TRUE),
    SDTestes = sd(TestesMass, na.rm = TRUE),
    MeanHorn = mean(HornLength, na.rm = TRUE),
    SDHorn = sd(HornLength, na.rm = TRUE),
    .groups = "drop")

OverallSummary <- CombinedDataClean %>% 
  summarise(
    Sex = "Combined",
    MeanPerformance = mean(Performance, na.rm = TRUE),
    SDPerformance = sd(Performance, na.rm = TRUE),
    MeanPronotum = mean(PronotumLength, na.rm = TRUE),
    SDPronotum = sd(PronotumLength, na.rm = TRUE),
    MeanFat = mean(FatContent, na.rm = TRUE),
    SDFat = sd(FatContent, na.rm = TRUE),
    MeanWeightGain = mean(WeightGain, na.rm = TRUE),
    SDWeightGain = sd(WeightGain, na.rm = TRUE),
    MeanElytra = mean(ElytraLength, na.rm = TRUE),
    SDElytra = sd(ElytraLength, na.rm = TRUE),
    MeanEclosionWeight = mean(EclosionWeight, na.rm= TRUE),
    SDEclosionWeight = sd(EclosionWeight, na.rm = TRUE),
    MeanBroodBall = mean(EndBroodBallWeight, na.rm = TRUE),
    SDBroodBall = sd(EndBroodBallWeight, na.rm = TRUE),
    MeanDevelopment = mean(DevelopmentTime, na.rm = TRUE),
    SDDevelopment = sd(DevelopmentTime, na.rm = TRUE))

FinalSummary <- bind_rows(SexSummary, OverallSummary)

#The ultimate goal of the "SexSummary" and "OverallSummary" dataframes being 
#created was to bind them into this final summary to be used for statistical
#analysis and figure crafting.

BeetlesLong <- CombinedDataClean %>%
  pivot_longer(
    cols = c(Performance, PronotumLength, FatContent, EclosionWeight),
    names_to = "Trait",
    values_to = "Value") %>% 
  mutate(Trait = recode(Trait,
                        Performance = "ln(Performance [N])",
                        PronotumLength = "ln(Pronotum length [mm])",
                        FatContent = "Fat Content (mg)",
                        EclosionWeight = "Eclosion weight (mg)"))

#I created this dataframe for use in my boxplot later on.

theme_set(theme_bw())

ggplot(CombinedDataClean, aes(x = EclosionWeight, y = Performance))+
  geom_point(size = 2, alpha = 0.7)+
  geom_smooth(method = "lm", se = TRUE) +
  facet_wrap(~ Sex)+
  xlab("Eclosion Weight (mg)")+
  ylab("ln(Maximum Performance in Strength Test [N])")+
#In the original dataset, some columns had already been log transformed.
#I chose to keep these statistical transformations intact for the sake of simplicity
#and better scale in my graphs, thus the "ln" in this axis label and others.
  labs(title = "Beetle Eclosion Weight and Performance by Sex",
       subtitle = "Data from: Building a beetle: how larval environment leads to adult
       performance in a horned beetle")
ggsave("Beetle_Weight_Performance_Sex.png", width=6, height=4, units="in", dpi=300)
#This figure serves to display that there is an (albeit weak) correlation between
#performance and eclosion weight. It also shows that these values are greatly 
#affected by sex.
  
ggplot(CombinedDataClean, aes(x = Performance, fill = AdultDiet))+
  geom_histogram(bins = 20, position = "dodge") +
  facet_wrap(~ Sex)+
  xlab("ln(Maximum Performance in Strength Test [N])") +
  ylab("Frequency") +
  labs(title = "Beetle Performance Distribution and Diet",
    subtitle = "Data from: Building a beetle: how larval environment leads to adult
    performance in a horned beetle")+
  scale_color_manual(values = 'red', 'green', 'blue')
ggsave("Beetle_Performance_Diet.png", width=6, height=4, units="in", dpi=300)
#This figure serves to display the difference in beetle performance based on diet.
#Visually, it appears that adult diet did not have a significant effect on performance.

ggplot(BeetlesLong, aes(x = Sex, y = Value, fill = Sex))+
  geom_boxplot()+
  facet_wrap(~ Trait, scales = "free_y") +
  xlab("Sex")+
  labs(title = "Various Measurements of Beetle Size and Strength by Sex",
       subtitle = "Data from: Building a beetle: how larval environment leads to 
       adult performance in a horned beetle")
ggsave("Beetle_Size_Strength_Sex.png", width=8, height=6, units="in", dpi=300)

#This graph serves to provide a general visual of the sexual dimorphism of this
#particular beetle species using several measurements of strength and size.
