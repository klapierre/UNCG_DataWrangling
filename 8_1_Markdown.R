# Work for R markdown assignment

library(tidyverse)

#load data
pbg_n <- read.csv("PBG_N_compiled_raw_2021.csv")
pbg_p <- read.csv("PBG_P_compiled_raw_2021.csv")
pbg_t <- read.csv("PBG_trts.csv")

# Bind those bad boys together

bind <- rbind(pbg_n,pbg_p)

# filer for only U in sample column

bound_onlyU <- bind %>% filter(grepl("U", sample))

# Keep only highest dilution entry for each dataset

bound_maxdil <- bound_onlyU %>% group_by(Sample) %>% filter(dilution == max(dilution)) %>% ungroup()

# start separating Sample col

Sampleseparated <- bound_maxdil %>% separate(col = Sample, into = c("watershed","transect","plot","NorP"), sep = "-")

#remove that NorP col

cleanNandP <- Sampleseparated %>% select(-NorP)

# Add in the pbg_t dataset

combinedNPnadT <- merge(cleanNandP,pbg_t)

#rename test column entries 

unique(combinedNPnadT$test) 

renamed <- combinedNPnadT %>% mutate(test = ifelse(test %in% "HCl PO4_1", "Phosphorous ", test))

renamedagain <- renamed %>% mutate(test = ifelse(test %in% "KCl Ammonia 10", "Ammonia", test))

finalrename <- renamedagain %>% mutate(test = ifelse(test %in% "KCL NO3_NO2 2", "Nitrate", test))

#get rid of all the shit we dont need

CLEAN <- finalrename %>% select(-Process, -Number, -run, -abs, -h, -number, -j, -k, -Notes, -run_time, -Site, -dilution)

# Lord have mercy

ggplot(CLEAN, aes(x = test, y= as.numeric(concentration), fill = as.factor(test))) +
  geom_boxplot() +
  facet_wrap(~treatment, scales = "free") +
  scale_fill_manual(values = c("green","blue", "yellow")) +
  xlab("Nutrient") + ylab("Concentration") +
  labs(fill = "Legend")
  
#calc cv
#make a lazy function to calc cv

cv <- function(x) 100*( sd(x, na.rm = TRUE)/mean(x, na.rm = TRUE))

#make a df with the CVs

cvframe <- CLEAN %>% group_by(treatment, test) %>% summarize(cv = cv(as.numeric(concentration))) %>% ungroup()

#make a bargraph of that bad boy

ggplot(cvframe, aes(x=test, y= as.numeric(cv), fill = as.factor(test))) +
  geom_bar(stat = "identity") +
  facet_wrap(~treatment, scales = "free") +
  scale_fill_manual(values = c("green","blue", "yellow")) +
  xlab("Nutrient") + ylab("CV of Concentration") +
  labs(fill = "Legend")

#All that is left to do is r markdown the whole thing   _(´ཀ`」 ∠)_
