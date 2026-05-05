#Loading packages and loading in file
library(tidyverse)
library(ggplot2)

migraine_data<-read.csv('migraine_data.csv')

head(migraine_data)

str(migraine_data)

anyNA(migraine_data)

#Setting up the dataframe for analysis
migraine_data<-migraine_data %>% 
  select(Age, Frequency, Location, Intensity, Nausea, Vomit, Phonophobia,
         Photophobia, DPF, Type) %>% 
  rename(PainLoc=Location,
         LightSens=Photophobia,
         SoundSens=Phonophobia,
         FamilyHist=DPF) %>% 
  mutate(Nausea=case_when(Nausea == 0 ~ "No",
                           Nausea == 1 ~ "Yes",
                           TRUE ~ "unknown"),
         Vomit=case_when(Vomit == 0 ~ "No",
                         Vomit == 1 ~ "Yes",
                         TRUE ~ "unknown"),
         LightSens=case_when(LightSens == 0 ~ "No",
                             LightSens == 1 ~ "Yes",
                             TRUE ~ "unknown"),
         SoundSens=case_when(SoundSens == 0 ~ "No",
                             SoundSens == 1 ~ "Yes",
                             TRUE ~ "unknown"),
         FamilyHist=case_when(FamilyHist == 0 ~ "No",
                           FamilyHist == 1 ~ "Yes",
                           TRUE ~ "unknown"),
         Intensity = case_when(Intensity == 0 ~ "None",
                               Intensity == 1 ~ "Mild",
                               Intensity == 2 ~ "Medium",
                               Intensity == 3 ~ "Severe",
                               TRUE ~ "unknown"))

#Sorting into age groups
sorted_migraine_data <- migraine_data %>% 
  arrange(Age) %>% 
  mutate(AgeGroup = cut(Age,
                        breaks = c(0, 17, 25, 40, 65, 100),
                        labels = c("Teen","Young Adult", "Adult", "Middle-aged",
                                   "Senior")))

#plotting migraine frequency across age groups
freq_migraine_data <- sorted_migraine_data %>% 
  group_by(AgeGroup) %>% 
  summarise(avg_freq_days=mean(Frequency,na.rm=TRUE),
            sd_freq_days=sd(Frequency, na.rm=TRUE),
            n = n(),
            se_freq_days = sd_freq_days / sqrt(n)) %>% 
  ungroup()

ggplot(freq_migraine_data,aes(x=AgeGroup,
                              y=avg_freq_days,
                              fill=AgeGroup))+
  geom_bar(stat="identity")+
  geom_errorbar(aes(
    ymin = avg_freq_days - se_freq_days,
    ymax = avg_freq_days + se_freq_days),
    width = 0.2)+
  labs(x= "Age Group",
       y= "Average Migraine Days Per Month",
       title = "Average Migraine Days Per Month by Age Group")+
  theme_classic()

#plotting pain location vs migraine type
table(migraine_data$PainLoc)

pain_type_table<-migraine_data %>% 
  mutate(PainLoc=case_when(PainLoc == 0 ~ "None",
                            PainLoc == 1 ~ "Unilateral",
                            PainLoc == 2 ~ "Bilateral",
                            TRUE ~ "unknown")) %>% 
  group_by(Type,PainLoc) %>% 
  summarise(count=n(),
            .groups = 'drop' ) %>% 
  ungroup()

ggplot(pain_type_table, aes(x=count, 
                            y=Type, 
                            fill=PainLoc))+
  geom_bar(stat = "identity")+
  labs(y= 'Migraine Type',
       x= 'Number of Observations',
       title= 'Breakdown of Pain Location by Migraine Type')+
  theme_classic()

#plotting family history vs migraine type
migraine_famhist<-migraine_data %>% 
  group_by(Type,FamilyHist)  %>% 
  summarise(count=n(),.groups = 'drop' ) %>% 
  ungroup()

ggplot(migraine_famhist, aes(x=count, 
                             y=Type, 
                             fill=FamilyHist))+
  geom_bar(stat = "identity")+
  labs(y= 'Migraine Type',
       x= 'Number of Observations',
       title= 'Family History by Migraine Type')+
  scale_fill_manual(values = c("Yes" = "lightgreen",
                               "No" = "indianred"))


  
