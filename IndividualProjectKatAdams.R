FemaleData <- read.csv("femaledata.txt")
MaleData <- read.csv("maledata.txt")
library(tidyr)
library(tidyverse)
FemaleDataClean <- FemaleData %>%
  separate(col = 1, into = c("Individual", "Performance", "PronotumLength", 
                             "FatContent", "WeightGain", "ElytraLength", 
                             "EclosionWeight", "AdultDiet", "EndBroodBallWeight",
                             "DevelopmentTime"), sep = " ") %>% 
  mutate(Sex="Female") %>% 
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