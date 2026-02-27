
# why doesn't this work?!
setwd(C:\\Users\\kjkomatsu\\OneDrive - UNCG\\teaching\\BIO 457 - Data Wrangling)













# why doesn't this work?!
setwd('C:\Users\kjkomatsu\OneDrive - UNCG\teaching\BIO 457 - Data Wrangling')













# why doesn't this work?!
read.csv('CalispellCreekandTributaryTemperatures')














data("diamonds")

diamonds <- as.data.frame(diamonds)


# why doesn't this work?! (i.e., make a dataframe)
diamonds %>%
  filter(price<1000)










# why doesn't this work?!
cheapishDiamonds <- diamonds
  filter(price<1000)





  
  
  
  

  
# why doesn't this work?!
cheapishDiamonds <- diamonds %>% 
  filter(price<'1000')
  
  










# why doesn't this work?!
cheapishDiamonds <- diamonds %>% 
  filter(price=1000)













# why doesn't this work?!
diamondsSummary <- diamonds %>% 
  group_by('cut', 'color', 'clarity') %>% 
  summarize(price_mean=mean(price), .groups='drop')

















# why doesn't this work?!
diamondsSummary <- diamonds %>% 
  group_by(cut, color, clarity) %>% 
  summarize(price_mean=mean(price), .groups=drop)
