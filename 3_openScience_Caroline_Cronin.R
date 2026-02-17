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
## (halfway down the page): https://doi.org/10.6073/pasta/10f6c28a2eddfdef6f19691e233c6a7b

## Extract (unzip) the files into a folder named "YourLastName_conSME_data".


## QUESTION: Open up the file "knb-lter-knz.148.3.txt". What does this file contain?
# Answer: This file contains the dataset/description for the Consumer Size Manipulation Experiment (ConSME) at Konza Prairie.
# doi:10.6073/pasta/10f6c28a2eddfdef6f19691e233c6a7bCME01

## QUESTION: From this file or the original website, who are the dataset contributors?
# Answer:  Kimberly Komatsu, Meghan Avolio, Andrew Hope, Sally Koerner, Allison Louthan, Kevin Wilcox, Konza LTER   

## QUESTION: From this file or the original website, what are the start and end 
## dates of the dataset?
# Answer: The start date is 2019-01-01 and the end date is 2023-04-28.


## QUESTION: Is the data collection still ongoing?
## Confession from Professor Komatsu: despite the dates of data included in the 
## file, the answer here is yes.We're just behind in getting the data cleaned 
## and uploaded :(


## QUESTION: Given your answer to the previous question, why might it be good to
## have a reproducible script for data analysis related to this dataset?
# Answer: It would be good to have a reproducible script for data analysis because the dataset is updated over time, a reproducible script lets you rerun the same things on the newest version of the data and clearly track what changed and why.

# ----------------------------------------------------------
#### 2) Preventing GitHub from syncing the data files.####
# ----------------------------------------------------------

## We can use the .gitignore file to tell git what files not to sync to GitHub!

## QUESTION: What are two reasons why we wouldn't want GitHub to sync this data?
# Answer: We wouldn't want GitHub to sync some data because large files can slow the GitHub system and its better to keep raw data separate so the project stays organized and reproducible. 


## TASK: Check the Git tab in RStudio. Do you see your data folder listed?
## Now, open the .gitignore file from the files tab in RStudio.
## Tell git to ignore the entire folder containing the data you just downloaded.
## Save the .gitignore file.


## QUESTION: What happened to the data folder listed in the Git tab of RStudio
## when you hit save?
# Answer: After saving the .gitignore file, the data folder was no longer appeared in the Git tab because Git was told to ignore it.

## TASK: Stage, commit, and pull/push your modified .gitignore file to the branch
## you created for this week with an appropriate commit message.

# ----------------------------------------------------------
#### 3) Getting open data into R.####
# ----------------------------------------------------------

## You can import your data into R!

## TASK: Start by setting your working directory to the GitHub repository folder
## for this class on your computer using the function setwd().
## Hint - set the working directory as the top folder.
getwd()
list.files()

## TASK: Now we can import one of these datasets into R. Let's import the plant
## species abundance datafile (CME011). To do so, use the read.csv() function, 
## putting the relative file path and file name. Assign the dataframe you import
## a name that includes the experiment name (conSME) and the data type (abundance)
## using '<-' and be sure to carefully consider your naming convention when doing so.
consME_abundance <- read.csv("data/CME011.csv")


## After completing the above taask, run the following code.
conSMEcoverAlt <- read.csv("https://pasta.lternet.edu/package/data/eml/knb-lter-knz/148/5/5716ee946efd717292fa3da9241cda7c")


## QUESTION: What did this code do? What can you say about the two dataframes 
## you have created thus far?


## TASK: Check to see if the two dataframes are identical using an R function.
## (Hint: remember the Week 1 assignment?)


## QUESTION: Why might it be better to source data straight from the data portal?
## Why might it be worse?


## TASK: Save your R script. Then stage, commit, and pull/push your
## modified code to the branch you created for this week with an appropriate 
## commit message. Remember, it is most effective to commit small chunks of code 
## often with specific commit messages!



# ----------------------------------------------------------
#### 4) Thinking through your naming conventions.####
# ----------------------------------------------------------

## TASK: Check the names of the columns in the species cover dataset you imported.
## (Hint: remember the Week 1 assignment?)


## QUESTION: What naming convention did the dataset creators use for column names?


## QUESTION: What naming convention do you plan to use for this course for the
## following types of objects in R:
## R scripts
## vectors
## dataframes
## columns within dataframes
## homemade functions


## QUESTION: Do all of your objects follow the same naming convention or do you
## plan to use different naming conventions to reference different object types?


## TASK: Save your R script. Stage, commit, and pull/push your modified code to 
## the branch you created for this week with an appropriate commit message.



# ----------------------------------------------------------
#### 5) Opening Issues.####
# ----------------------------------------------------------

## Sometimes there are issues with code, either your own or someone else's.
## Opening issues in GitHub is a really effective way to keep track of these 
## problems.

## TASK: Create a new dataframe named "duplicates" by binding the rows of the two 
## conSME dataframes you have created into one ultimate dataframe using the 
## rbind() function.
## (Hint: Very similar to the cbind function we used in the Week 1 assignment)
duplicates <- rbind(conSME_abundance, conSMEcoverAlt)
View(duplicates)

## QUESTION: Looking at the information for each dataframe in the environment tab
## of RStudio, what do you notice about the number of observations for the 
## duplicates dataframe compared to the two original dataframes?
nrow(conSME_abundance)
nrow(conSMEcoverAlt)
nrow(duplicates)
# Answer: The duplicates dataframe has the combined rows from both original dataframes, so it has twice as many observations (rows).

## TASK: Save your R script. Stage, commit, and pull/push your modified code to 
## the branch you created for this week with an appropriate commit message.


## TASK: Open the duplicates dataframe by clicking on the file name in the 
## environment tab. Sort by Taxa, Plot, Block, Watershed, and RecDate by clicking
## on the tops of those columns in that order.
## You could also run the following code to get the same outcome:
duplicates[with(duplicates, order(RecDate, Block, Plot, Taxa)),]


## QUESTION: What do you notice about the data? Specifically, compare rows 
## 4934 and 12173 (if they are sorted correctly, those should be on top).


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


## QUESTION: Looking at the information for each dataframe in the environment 
## tab of RStudio, what do you notice about the number of observations for the 
## noDuplicates dataframe compared to the dulpicates dataframe? What about 
## compared to the two original dataframes?


## TASK: Go back to our repository in GitHub through your web browser. Find the
## issue you created and resolve it.

## TASK: Save your R script. Stage, commit, and pull/push your modified code to 
## the branch you created for this week with an appropriate commit message.



# ----------------------------------------------------------
#### 6) The final push :) ####
# ----------------------------------------------------------

## TASK: Type a comment below.


## TASK: Follow these instructions carefully!
## Save your R script. Stage and commit with the commit message "learning to 
## amend", but this time DON'T pull/push your modified code!

## TASK: Type another comment below.


## TASK: Save your R script. Open up the commit window in RStudio.


## QUESTION: How many commits are you ahead of your branch on GitHub?
## (Hint: look for the message "Your branch is ahead of..." near the top of the 
## window.)


## TASK: Stage your modified code and check the "Amend previous commit" box.
## Then commit your code (still don't pull/push).


## QUESTION: What happened when you clicked "Amend previous commit"?
## How many commits is your branch ahead by now?


## TASK: Once you've answered the above questions, save your R script one last time. 
## Stage your modified code, amend it to the previous commit, and finally pull/push
## your commits to your branch in our class repository.