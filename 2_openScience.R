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


## QUESTION: Open up the file "knb-lter-knz.148.3.txt". What does this file contain?

## The dataset "CME01 The Consumer Size Manipulation Experiment (ConSME) at Konza Prairie"

## QUESTION: From this file, who are the dataset contributors?

## Kimberly Komatsu, Meghan Avolio, Andrew Hope, Sally Koerner, Allison Louthan, Kevin Wilcox, Konza LTER

## QUESTION: From this file, what are the start and end dates of the dataset?

## Start Date:2019-01-01, End Date:  2021-12-31

## QUESTION: Is the data collection still ongoing?

## yes


## QUESTION: Given your answer to the previous question, why might it be good to
## have a reproducible script for data analysis related to this dataset?

## Data collection is ongoing so data analysis will need to repeated as new data is added

# ----------------------------------------------------------
#### 2) Preventing GitHub from syncing the data files.####
# ----------------------------------------------------------

## We can use the .gitignore file to tell git what files not to sync to GitHub!

## QUESTION: What are two reasons why we wouldn't want GitHub to sync this data?
# GitHub is not good at storing data.

## File may be too large to store in GitHub. Additionally, we might want to have a protected copy of data to prevent corruption.


## TASK: Check the Git tab in RStudio. Do you see your data folder listed added?
## Now, open the .gitignore file from the files tab in RStudio.
## Tell git to ignore the entire folder containing the data you just downloaded.
## Save the .gitignore file.


## QUESTION: What happened to the data folder listed in the Git tab of RStudio
## when you hit save?

##The file moved away from the Git tab. It will now be ignored by Git.

## TASK: Stage, commit, and pull/push your modified .gitignore file to the branch
## you created for this week with an appropriate commit message.


# ----------------------------------------------------------
#### 3) Getting open data into R.####
# ----------------------------------------------------------

## You can import your data into R!

## TASK: Start by setting your working directory to the GitHub repository folder
## for this class on your computer using the function setwd().
## Hint - set the working directory as the top folder.

setwd("C:/Users/Zachary/OneDrive/Desktop/R Class Stuff/UNCG_DataWrangling")

## TASK: Now we can import one of these datasets into R. Let's import the plant
## species abundance datafile (CME011). To do so, use the read.csv() function, 
## putting the relative file path and file name. Assign the dataframe you import
## a name that includes the experiment name (conSME) and the data type (abundance)
## using '<-' and be sure to carefully consider your naming convention when doing so.

conSME_abundance <- read.csv("C:/Users/Zachary/OneDrive/Desktop/R Class Stuff/UNCG_DataWrangling/Bunch_conSME_data/CME011.csv")


## Run the following code.
conSMEcoverAlt <- read.csv("https://portal.edirepository.org/nis/dataviewer?packageid=knb-lter-knz.148.3&entityid=5716ee946efd717292fa3da9241cda7c")


## QUESTION: What did this code do? What can you say about these two dataframes?

## The code saved a link associted with CME011.csv file into "conSMEcoverAlt."
## Both data frames are storing the same file but in different ways.

## TASK: Check to see if the two dataframes are identical using an R function.
## (Hint: remember the Week 1 assignment?)

identical(conSME_abundance, conSMEcoverAlt)

##True

## QUESTION: Why might it be better to source data straight from the data portal?
## Why might it be worse?

## If I understand correctly, pulling from the data portal would giving you a 
## copy that is constantly changing which might be frustrating to work with.
## However, the copy stored locally on your computer wouldn't change until 
## you pulled new data

## TASK: Save your R script. Then stage, commit, and pull/push your
## modified code to the branch you created for this week with an appropriate 
## commit message. Remember, it is most effective to commit small chunks of code 
## often with specific commit messages!



# ----------------------------------------------------------
#### 4) Thinking through your naming conventions.####
# ----------------------------------------------------------

## TASK: Check the names of the columns in the species cover dataset you imported.
## (Hint: remember the Week 1 assignment?)

colnames(conSME_abundance)

## QUESTION: What naming convention did the dataset creators use for column names?

##One word for most. When two words were used, a capital letter indicated the start of a new word.
##No spaces. 

## QUESTION: What naming convention do you plan to use for this course for the
## following types of objects in R:
## R scripts
## vectors
## dataframes
## columns within dataframes
## homemade functions

##I'm generally a fan of using a _ to seperate things.
## I wasn't planning on using a different convention for different
##types of objects but willing to modify my plan if this is considered
##best practice. I have limited coding experiance so I'm not familar
##with the standard naming and organistational practices of R, if they exist



## QUESTION: Do all of your objects follow the same naming convention or do you
## plan to use different naming conventions to reference different object types?


##Planning to use the same naming convention for everything.
##However, I may reconsider if there is value in using different
##naming conventions for different object types.

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

duplicates <- rbind(conSME_abundance,conSMEcoverAlt)


## QUESTION: Looking at the information for each dataframe in the environment tab
## of RStudio, what do you notice about the number of observations for the 
## duplicates dataframe compared to the two original dataframes?

##the duplicates dataframe has double the observations. 

## TASK: Save your R script. Stage, commit, and pull/push your modified code to the branch
## you created for this week with an appropriate commit message.


## TASK: Open the duplicates dataframe by clicking on the file name in the 
## environment tab. Sort by Taxa, Plot, Block, Watershed, and RecDate by clicking
## on the tops of those columns in that order.
## You could also run the following code to get the same outcome:
duplicates[with(duplicates, order(RecDate, Block, Plot, Taxa)),]


## QUESTION: What do you notice about the data? Specifically, compare rows 
## 4934 and 12173 (if they are sorted correctly, those should be on top).

##Rows 4934 and 12173 appear to be exactly the same.

## TASK: Save your R script. Stage, commit, and pull/push your modified code to the branch
## you created for this week with an appropriate commit message.


## It looks like we have a problem (that we created for ourselves)! Let's open an
## issue to make note of this.


## TASK: Go to our repository in GitHub through your web browser. Click on issues
## and start a new issue. Give it a descriptive title that references the script
## name and line number of the issue. The write a comment describing the issue.


## Now let's fix our issue!
## A great function to get rid of exact duplicate columns in R is unique().
## Run the following code.
noDuplicates <- unique(duplicates)


## QUESTION: Looking at the information for each dataframe in the environment tab
## of RStudio, what do you notice about the number of observations for the 
## noDuplicates dataframe compared to the dulpicates dataframe? What about compared
## to the two original dataframes?

##It has half the number of observations

## TASK: Go back to our repository in GitHub through your web browser. Find the
## issue you created and resolve it.

## TASK: Save your R script. Stage, commit, and pull/push your modified code to 
## the branch you created for this week with an appropriate commit message.



# ----------------------------------------------------------
#### 6) The final push :) ####
# ----------------------------------------------------------

## TASK: Type a comment below.

##Almost there!

## TASK: Follow these instructions carefully!
## Save your R script. Stage and commit with the commit message "learning to amend",
## but this time DON'T pull/push your modified code!

## TASK: Type another comment below.

##Getting closer :)

## TASK: Save your R script. Open up the commit window in RStudio.


## QUESTION: How many commits are you ahead of your branch on GitHub?
## (Hint: look for the message "Your branch is ahead of..." near the top of the 
## window.)

##1 commit

## TASK: Stage your modified code and check the "Amend previous commit" box.
## Then commit your code (still don't pull/push).


## QUESTION: What happened when you clicked "Amend previous commit"?
## How many commits is your branch ahead by now?

##Still just one.

## TASK: Once you've answered the above questions, save your R script one last time. 
## Stage your modified code, amend it to the previous commit, and finally pull/push
## your commits to the branch you created for this week.
