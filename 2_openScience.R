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

# Metadata!

## QUESTION: From this file, who are the dataset contributors?

# Komatsu, Avolio, Hope, Koerner, Louthan, Wilcox

## QUESTION: From this file, what are the start and end dates of the dataset?

# Start Date:  2019-01-01
# End Date:  2021-12-31

## QUESTION: Is the data collection still ongoing?

# The end date listed above suggests data collection is over? Or is that just the data contained in this fileset? 
# Does "Maintenance" = Ongoing suggest further data will be collected at another temporal scale?


## QUESTION: Given your answer to the previous question, why might it be good to
## have a reproducible script for data analysis related to this dataset?

# One new data is pushed new code can run analyses without too much fuss. (Hopefully)

# ----------------------------------------------------------
#### 2) Preventing GitHub from syncing the data files.####
# ----------------------------------------------------------

## We can use the .gitignore file to tell git what files not to sync to GitHub!

## QUESTION: What are two reasons why we wouldn't want GitHub to sync this data?
# GitHub is not good at storing data.


## TASK: Check the Git tab in RStudio. Do you see your data folder listed added?
## Now, open the .gitignore file from the files tab in RStudio.
## Tell git to ignore the entire folder containing the data you just downloaded.
## Save the .gitignore file.


## QUESTION: What happened to the data folder listed in the Git tab of RStudio
## when you hit save?

# It disappeared from the Git Tab :O

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

conSME_abund <- read.csv("CME011.csv")

## Run the following code.
conSMEcoverAlt <- read.csv("https://portal.edirepository.org/nis/dataviewer?packageid=knb-lter-knz.148.3&entityid=5716ee946efd717292fa3da9241cda7c")


## QUESTION: What did this code do? What can you say about these two dataframes?

# Loaded a new data frame that has the same number of observation and variables as the previously imported df.

## TASK: Check to see if the two dataframes are identical using an R function.
## (Hint: remember the Week 1 assignment?)

identical(conSME_abund, conSMEcoverAlt)
#They are identical

## QUESTION: Why might it be better to source data straight from the data portal?
## Why might it be worse?

# You may be able to get more up to date data sets. I can't think of any real downside expect you may mistype that long link. 
# You also wouldn't be able to pull data if you were without internet access.

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

# First letter is Uppercase. Abbreviate Record to Rec.

## QUESTION: What naming convention do you plan to use for this course for the
## following types of objects in R:

# for all: lowercase when all possible

## R scripts
## vectors

## dataframes: I love the subset() function. So I often subset dataframes like "dataframe_greenleaves"

## columns within dataframes
## homemade functions


## QUESTION: Do all of your objects follow the same naming convention or do you
## plan to use different naming conventions to reference different object types?

# I try and keep it consistent, but sometimes certain conventions make more sense in practice depending on the project.


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

duplicates <- rbind(conSME_abund,conSMEcoverAlt)


## QUESTION: Looking at the information for each dataframe in the environment tab
## of RStudio, what do you notice about the number of observations for the 
## duplicates dataframe compared to the two original dataframes?

# "duplicates" number of observations is the sum of the two combined dataframes.

## TASK: Save your R script. Stage, commit, and pull/push your modified code to the branch
## you created for this week with an appropriate commit message.


## TASK: Open the duplicates dataframe by clicking on the file name in the 
## environment tab. Sort by Taxa, Plot, Block, Watershed, and RecDate by clicking
## on the tops of those columns in that order.
## You could also run the following code to get the same outcome:

duplicates[with(duplicates, order(RecDate, Block, Plot, Taxa)),]


## QUESTION: What do you notice about the data? Specifically, compare rows 
## 4934 and 12173 (if they are sorted correctly, those should be on top).

# There are duplicates in our dataframe! :O

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

# This removes all rows that are duplicates of another row. This results in a dataframe that has
# less entries than either of the orginal dataframes meaning some "legit" duplicates were removed.


## TASK: Go back to our repository in GitHub through your web browser. Find the
## issue you created and resolve it.

## TASK: Save your R script. Stage, commit, and pull/push your modified code to 
## the branch you created for this week with an appropriate commit message.



# ----------------------------------------------------------
#### 6) The final push :) ####
# ----------------------------------------------------------

## TASK: Type a comment below.

# "a comment below."

## TASK: Follow these instructions carefully!
## Save your R script. Stage and commit with the commit message "learning to amend",
## but this time DON'T pull/push your modified code!

## TASK: Type another comment below.

# "another comment below."

## TASK: Save your R script. Open up the commit window in RStudio.


## QUESTION: How many commits are you ahead of your branch on GitHub?
## (Hint: look for the message "Your branch is ahead of..." near the top of the 
## window.)

# Ahead by 1 commit

## TASK: Stage your modified code and check the "Amend previous commit" box.
## Then commit your code (still don't pull/push).


## QUESTION: What happened when you clicked "Amend previous commit"?
## How many commits is your branch ahead by now?

# it opened up my last commit message. ("learning to amend")

# still ahead by 1 commit.

## TASK: Once you've answered the above questions, save your R script one last time. 
## Stage your modified code, amend it to the previous commit, and finally pull/push
## your commits to the branch you created for this week.
