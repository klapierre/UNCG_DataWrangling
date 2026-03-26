################################################################################
##  example of chatGPT gone wrong
################################################################################

library(tidyverse)

setwd('C:\\Users\\kjkomatsu\\Smithsonian Dropbox\\Kimberly Komatsu\\konza projects\\Ghost Fire')


# data -------------------------------------------------------------------------

trt <- read.csv('SiteLocation & Exp Design\\GF_PlotList.csv') %>% 
  select(-Plot, -Burn.Trt2, -plot_id) %>% 
  rename(watershed=Watershed, 
         burn_trt=Burn.Trt, 
         block=Block, 
         plot=plot_num, 
         litter=Litter, 
         nutrient=Nutrient)

invertComp2014 <- read.csv('DATA\\GhostFire2014_Data\\Invertebrates\\La Pierre_ghost fire_invert_community_2014.csv') %>% 
  select(-burn_trt)

invertComp2019 <- read.csv('DATA\\GhostFire2019_Data\\Invertebrates\\ghost_fire_invert_community_2019.csv') %>% 
  select(-plot_trt, -litter_trt, -burn_trt) %>% 
  mutate(stage=str_to_lower(stage), collected=str_to_lower(collected))

invertComp2024 <- read.csv('DATA\\GhostFire2024_Data\\Invertebrates\\ghost_fire_invert_community_2024.csv') %>% 
  select(-plot_trt, -litter_trt, -burn_trt) %>% 
  mutate(stage=str_to_lower(stage), collected=str_to_lower(collected))

invertComp <- rbind(invertComp2014, invertComp2019, invertComp2024) 

invertTrt <- invertComp%>% 
  left_join(trt)

invertTrtWrong <- invertComp%>% 
  left_join(trt, by=c('block', 'plot'))
