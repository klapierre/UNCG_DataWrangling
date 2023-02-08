#### MODULE 2: Open Data, Project Management, and GitHub #### 

## OBJECTIVE:
## Know where to find data and how to bring it into the R environment.
## Set up a good file management system for yourself, which you can build on in the future.
## Branch from a GitHub repository and practice staging, committing, and pull/pushing code. 
## Create a resource to refer back to.

# ----------------------------------------------------------
#### 1) Finding and interpreting open data.####
# ----------------------------------------------------------

## Go to the following website and download the full data package
## (halfway down the page): https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-knz.148.3

## Extract (unzip) the files into a folder named "YourLastName_conSME_data".
#Saved in folder: BravoC_conSME_data

## QUESTION: Open up the file "knb-lter-knz.148.3.txt". What does this file contain?
#After the header with the demographic information of the researchers who generated 
#the code,an intelectual property disclaimer. And data characterization and description
#such as naming conventions, geographic coordinates, type of object, elements, etc.

## QUESTION: From this file, who are the dataset contributors?
#Kevin Wilcox, Allison Louthan, Sally Koerner, Andrew Hope, Meghan Avolio, Kimberly
#Komatsu.

## QUESTION: From this file, what are the start and end dates of the dataset?
#Start: 2019-01-01
#End: 2021-12-31

## QUESTION: Is the data collection still ongoing?
#No, this project stopped collecting data at the end of 2021.

## QUESTION: Given your answer to the previous question, why might it be good to
## have a reproducible script for data analysis related to this dataset?
#Data collected in the future can be analyzed using the same scripts so you can
#have a comparison of how the variables being measured changed overtime. It can
#also serve to complement data from different geographic locations giving more
#context to the observed trends.

# ----------------------------------------------------------
#### 2) Preventing GitHub from syncing the data files.####
# ----------------------------------------------------------

## We can use the .gitignore file to tell git what files not to sync to GitHub!

## QUESTION: What are two reasons why we wouldn't want GitHub to sync this data?
# GitHub is not good at storing data, it can create huge log files with all the 
#changes.


## TASK: Check the Git tab in RStudio. Do you see your data folder listed added?
#Yes.
## Now, open the .gitignore file from the files tab in RStudio.
## Tell git to ignore the entire folder containing the data you just downloaded.
#BravoC_conSME_data
## Save the .gitignore file.
#Saved

## QUESTION: What happened to the data folder listed in the Git tab of RStudio
## when you hit save?
#The folder was replaced by .gitignore and its status changed to M 
#What does that mean? It means modified, staged not committed

## TASK: Stage, commit, and pull/push your modified .gitignore file to the branch
## you created for this week with an appropriate commit message.


# ----------------------------------------------------------
#### 3) Getting open data into R.####
# ----------------------------------------------------------

## You can import your data into R!

## TASK: Start by setting your working directory to the GitHub repository folder
## for this class on your computer using the function setwd().
## Hint - set the working directory as the top folder.


## TASK: Now we can import one of these datasets into R. Let's import the plant
## species abundance datafile (CME011). To do so, use the read.csv() function, 
## putting the relative file path and file name. Assign the dataframe you import
## a name that includes the experiment name (conSME) and the data type (abundance)
## using '<-' and be sure to carefully consider your naming convention when doing so.
#conSMEabundance <- read.csv("BravoC_conSME_data/knb-lter-knz.148.3/CME011.csv")

## Run the following code.
conSMEcoverAlt <- read.csv("https://portal.edirepository.org/nis/dataviewer?packageid=knb-lter-knz.148.3&entityid=5716ee946efd717292fa3da9241cda7c")

## QUESTION: What did this code do? What can you say about these two dataframes?
#This command line loaded the file conSMEcoverAlt in the environment window.

## TASK: Check to see if the two dataframes are identical using an R function.
## (Hint: remember the Week 1 assignment?)
#identical(conSMEabundance,conSMEcoverAlt)


## QUESTION: Why might it be better to source data straight from the data portal?
## Why might it be worse?
#Because there is a higher likelihood that the data is up-to-date, and clean
#It might be worse because it might change things in an irreversible way, 
#skewing your data.

## TASK: Save your R script. Then stage, commit, and pull/push your
## modified code to the branch you created for this week with an appropriate 
## commit message. Remember, it is most effective to commit small chunks of code 
## often with specific commit messages!
#Done


# ----------------------------------------------------------
#### 4) Thinking through your naming conventions.####
# ----------------------------------------------------------

## TASK: Check the names of the columns in the species cover dataset you imported.
## (Hint: remember the Week 1 assignment?)
#colnames(conSMEabundance)
#colnames(conSMEcoverAlt)

## QUESTION: What naming convention did the dataset creators use for column names?
#Descriptive titles, combined with upper case distinction

## QUESTION: What naming convention do you plan to use for this course for the
## following types of objects in R:
## R scripts - LastName_Project
## vectors - type_id
## dataframes - df_type
## columns within dataframes - colType_df
## homemade functions - No idea


## QUESTION: Do all of your objects follow the same naming convention or do you
## plan to use different naming conventions to reference different object types?
#I plan on using different naming conventions depending on the amount of data


## TASK: Save your R script. Stage, commit, and pull/push your modified code to the branch
## you created for this week with an appropriate commit message.



# ----------------------------------------------------------
#### 5) Opening Issues.####
# ----------------------------------------------------------

## Sometimes there are issues with code, either your own or someone else's.
## Opening issues in GitHub is a really effective way to keep track of these 
## problems.

## TASK: Create a new dataframe named "duplicates" by binding the rows of two 
## conSME dataframes you made into one using the rbind() function.
## (Hint: Very similar to the cbind function we used in the Week 1 assignment)
#duplicates <- rbind(conSMEabundance,conSMEcoverAlt)

## QUESTION: Looking at the information for each dataframe in the environment tab
## of RStudio, what do you notice about the number of observations for the 
## duplicates dataframe compared to the two original dataframes?
#The number of observations is double the number of observations in each 
#individual file.

## TASK: Save your R script. Stage, commit, and pull/push your modified code to the branch
## you created for this week with an appropriate commit message.


## TASK: Open the duplicates dataframe by clicking on the file name in the 
## environment tab. Sort by Taxa, Plot, Block, Watershed, and RecDate by clicking
## on the tops of those columns in that order.
## You could also run the following code to get the same outcome:
duplicates[with(duplicates, order(RecDate, Block, Plot, Taxa)),]


## QUESTION: What do you notice about the data? Specifically, compare rows 
## 4934 and 12173 (if they are sorted correctly, those should be on top).
#The data is duplicated, as expected.

## TASK: Save your R script. Stage, commit, and pull/push your modified code to the branch
## you created for this week with an appropriate commit message.
#Done

## It looks like we have a problem (that we created for ourselves)! Let's open an
## issue to make note of this.


## TASK: Go to our repository in GitHub through your web browser. Click on issues
## and start a new issue. Give it a descriptive title that references the script
## name and line number of the issue. The write a comment describing the issue.
#Done.

## Now let's fix our issue!
## A great function to get rid of exact duplicate columns in R is unique().
## Run the following code.
noDuplicates <- unique(duplicates)


## QUESTION: Looking at the information for each dataframe in the environment tab
## of RStudio, what do you notice about the number of observations for the 
## noDuplicates dataframe compared to the dulpicates dataframe? What about compared
## to the two original dataframes?
#After the noDuplicates command removed all repeated entries, however it also
#removed 65 entries that were present in the previous file.

## TASK: Go back to our repository in GitHub through your web browser. Find the
## issue you created and resolve it.
#Done

## TASK: Save your R script. Stage, commit, and pull/push your modified code to 
## the branch you created for this week with an appropriate commit message.



# ----------------------------------------------------------
#### 6) The final push :) ####
# ----------------------------------------------------------

## TASK: Type a comment below.


## TASK: Follow these instructions carefully!
## Save your R script. Stage and commit with the commit message "learning to amend",
## but this time DON'T pull/push your modified code!

## TASK: Type another comment below.
#Learning to amend

## TASK: Save your R script. Open up the commit window in RStudio.
#Done

## QUESTION: How many commits are you ahead of your branch on GitHub?
## (Hint: look for the message "Your branch is ahead of..." near the top of the 
## window.)
#One commit ahead


## TASK: Stage your modified code and check the "Amend previous commit" box.
## Then commit your code (still don't pull/push).


## QUESTION: What happened when you clicked "Amend previous commit"?
## How many commits is your branch ahead by now?


## TASK: Once you've answered the above questions, save your R script one last time. 
## Stage your modified code, amend it to the previous commit, and finally pull/push
## your commits to the branch you created for this week.
