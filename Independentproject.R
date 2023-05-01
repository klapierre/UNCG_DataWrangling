
Ethan Isaac
library()


inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-sev/9/277528/d62953d938516997b4479b25e650b6b6" 
infile1 <- tempfile()
try(download.file(inUrl1,infile1,method="curl"))
if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")

dt1 <-read.csv(infile1,header=F 
               ,skip=1
               ,sep=","  
               , col.names=c(
                 "year",     
                 "season",     
                 "location",     
                 "web",     
                 "spoke",     
                 "dis",     
                 "species",     
                 "id#",     
                 "recap",     
                 "sex",     
                 "svl",     
                 "ttl",     
                 "rtl",     
                 "t?",     
                 "hll",     
                 "fll",     
                 "mass",     
                 "nk.number",     
                 "comments"    ), check.names=TRUE)

unlink(infile1)
if (class(dt1$season)!="factor") dt1$season<- as.factor(dt1$season)
if (class(dt1$location)!="factor") dt1$location<- as.factor(dt1$location)
if (class(dt1$dis)=="character") dt1$dis <-as.numeric(dt1$dis)
if (class(dt1$species)!="factor") dt1$species<- as.factor(dt1$species)
if (class(dt1$id#)!="factor") dt1r") dt1$recap<- as.factor(dt1$recap)
          if (class(dt1$dis)=="character") dt1$dis <-as.numeric(dt1$dis)
          if (class(dt1$species)!="factor") dt1$species<- as.factor(dt1$species)
          if (class(dt1$id#)!="factor") dt1$id#<- as.factor(dt1$id#)

                    
                    # Convert Missing Values to NA.
                    
                    dt1$season <- as.factor(ifelse((trimws(as.character(dt1$season))==trimws("-888")),NA,as.character(dt1$season)))
                    dt1$season <- as.factor(ifelse((trimws(as.character(dt1$season))==trimws("-999")),NA,as.character(dt1$season)))
                    dt1$mass <- ifelse((trimws(as.character(dt1$mass))==trimws("na")),NA,dt1$mass)               
                    suppressWarnings(dt1$mass <- ifelse(!is.na(as.numeric("na")) & (trimws(as.character(dt1$mass))==as.character(as.numeric("na"))),NA,dt1$mass))
                    
                    
                    
                    
                    # The input data frame:
                    str(dt1)                            
                    attach(dt1)                            
                    # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
                    
                    summary(year)
                    summary(season)
                    summary(location)
                    summary(species)
                    summary(id#)
                    
                            summary(as.factor(dt1$season)) 
                            summary(as.factor(dt1$location))         
                    