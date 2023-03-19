#Clean 8.1

#Load Library and datasets

library(tidyverse)

pbg_n <- read.csv("PBG_N_compiled_raw_2021.csv")
pbg_p <- read.csv("PBG_P_compiled_raw_2021.csv")
pbg_t <- read.csv("PBG_trts.csv")

#Tidy up the data set

oneliner <- rbind(pbg_n,pbg_p) %>% filter(grepl("U", sample)) %>% group_by(Sample) %>% filter(dilution == max(dilution)) %>% ungroup() %>% 
  separate(col = Sample, into = c("watershed","transect","plot","NorP"), sep = "-") %>% 
  select(-NorP) %>% 
  merge(pbg_t)  %>% 
  select(-Process, -Number, -run, -abs, -h, -number, -j, -k, -Notes, -run_time, -Site, -dilution)%>% mutate(test = ifelse(test %in% c("HCl PO4_1","KCl Ammonia 10","KCL NO3_NO2 2"), c("Phosphorous","Ammonia","Nitrate"), test)) 

#Create first graph

ggplot(oneliner, aes(x = test, y= as.numeric(concentration), fill = as.factor(test))) +
  geom_boxplot() +
  facet_wrap(~treatment, scales = "free") +
  scale_fill_manual(values = c("green","blue", "yellow")) +
  xlab("Nutrient") + ylab("Concentration") +
  labs(fill = "Legend")

#Make a function to calculate CV

cv <- function(x) 100*( sd(x, na.rm = TRUE)/mean(x, na.rm = TRUE))

#Make a df with the needed CVs

cvframe <- oneliner %>% group_by(treatment, test) %>% summarize(cv = cv(as.numeric(concentration))) %>% ungroup()

#Make a bar graph of the CV df

ggplot(cvframe, aes(x=test, y= as.numeric(cv), fill = as.factor(test))) +
  geom_bar(stat = "identity") +
  facet_wrap(~treatment, scales = "free") +
  scale_fill_manual(values = c("green","blue", "yellow")) +
  xlab("Nutrient") + ylab("CV of Concentration") +
  labs(fill = "Legend")
