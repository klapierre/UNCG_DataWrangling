setwd('C:\Users\kjkomatsu\OneDrive - UNCG\working groups\CoRRE\sDiv\sDiv_sCoRRE_shared\CoRRE data\trait data')

















read.csv('TRY_trait_data_continuous_032020')











colnames(Traits)











dataset415 <- traits %>%  #this dataset has many repeats of all data
  filter(DatasetID==415) 










long415 <- dataset415 %>% 
  pivot_longer(cols = X106-water_content,
               names_to = "CleanTraitName",
               values_to = "StdValue") %>% 
  na.omit()











unique415 <- long415 %>% 
  filter(DatasetID==415) %>% 
  group_by(DatasetID, species_matched, CleanTraitName, family, genus) %>%
  summarise(StdValue=mean(StdValue)) %>% 
  mutate(ObservationID=seq(1:n()))


unique415 <- long415 %>% 
  filter(DatasetID==415) %>% 
  group_by(DatasetID, species_matched, CleanTraitName, family, genus) %>%
  summarise(StdValue=mean(StdValue)) %>% 
  mutate(ObservationID=c(1:456))


unique415 <- long415 %>% 
  filter(DatasetID==415) %>% 
  group_by(DatasetID, species_matched, CleanTraitName, family, genus) %>%
  summarise(StdValue=mean(StdValue)) %>% 
  mutate(ObservationID=seq_len(n()))


unique415 <- long415 %>% 
  filter(DatasetID==415) %>% 
  group_by(DatasetID, species_matched, CleanTraitName, family, genus) %>%
  summarise(StdValue=mean(StdValue)) %>% 
  mutate(ObservationID=row_number())




  