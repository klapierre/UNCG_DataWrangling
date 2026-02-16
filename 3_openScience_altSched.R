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

#ANSWER: The zip file contained knb-lter-knz.148.5.txt which contains the authors contact information, an abstract of the study, and other metadata.

## QUESTION: From this file or the original website, who are the dataset contributors?

#ANSWER: Komatsu, Kimberly; Avolio,; Meghan; Hope, Andrew; Koerner, Sally; Louthan, Allison; and Wilcox, Kevin

## QUESTION: From this file or the original website, what are the start and end 
## dates of the dataset?

#ANSWER: Start=01/01/2019; End=12/31/2022

## QUESTION: Is the data collection still ongoing?

#ANSWER: According to the metadata, no. According to Kim, yes.

## Confession from Professor Komatsu: despite the dates of data included in the 
## file, the answer here is yes.We're just behind in getting the data cleaned 
## and uploaded :(


## QUESTION: Given your answer to the previous question, why might it be good to
## have a reproducible script for data analysis related to this dataset?

#ANSWER: Just in case things take longer than expected, it is nice to be able to have good, organized scripts so you don't have to spend forever trying to figure out what you were doing. 

# ----------------------------------------------------------
#### 2) Preventing GitHub from syncing the data files.####
# ----------------------------------------------------------

## We can use the .gitignore file to tell git what files not to sync to GitHub!

## QUESTION: What are two reasons why we wouldn't want GitHub to sync this data?

#ANSWER: 1) you might not want to publish your data right away. 2) you are just playing (or practicing)around with the data and don't want to commit anything right away


## TASK: Check the Git tab in RStudio. Do you see your data folder listed?
## Now, open the .gitignore file from the files tab in RStudio.
## Tell git to ignore the entire folder containing the data you just downloaded.
## Save the .gitignore file.


## QUESTION: What happened to the data folder listed in the Git tab of RStudio
## when you hit save?

#ANSWER: It is now ignored.


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

setwd("C:/Users/kelly/Documents/data wrangling/Clark_conSME_data")

conSME_abundance <- read.csv("CME011.csv")


## After completing the above task, run the following code.
conSMEcoverAlt <- read.csv("https://pasta.lternet.edu/package/data/eml/knb-lter-knz/148/5/5716ee946efd717292fa3da9241cda7c")


## QUESTION: What did this code do? What can you say about the two dataframes 
## you have created thus far?

dim(conSME_abundance)
head(conSME_abundance)
str(conSME_abundance)


dim(conSMEcoverAlt)
head(conSMEcoverAlt)
str(conSMEcoverAlt)


#ANSWER: It imported the conSME data into R. The data frames look to be the exact same.

## TASK: Check to see if the two dataframes are identical using an R function.
## (Hint: remember the Week 1 assignment?)
identical(conSME_abundance, conSMEcoverAlt)

## QUESTION: Why might it be better to source data straight from the data portal?
## Why might it be worse?

#ANSWER: It might be better because you are getting the published data and dont have to worry about entry errors. It might be worse because the authors that published the data may not have cleaned it in a way that is preferable to you (it could be very unorganized).


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
colnames(conSMEcoverAlt)

## QUESTION: What naming convention did the dataset creators use for column names?
#ANSWER: They abbreviated words and used capital letters to denote different words. 

## QUESTION: What naming convention do you plan to use for this course for the
## following types of objects in R:
## R scripts - I will separate words with  underscores and hyphens. 
## vectors - abbreviations and when needed using underscores
## dataframes - I will separate words with  underscores and hyphens. 
## columns within dataframes - I will separate words with  underscores and abbreviate 
## homemade functions - will use underscores


## QUESTION: Do all of your objects follow the same naming convention or do you
## plan to use different naming conventions to reference different object types?

#ANSWER: They will follow the same naming convention.


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

## QUESTION: Looking at the information for each dataframe in the environment tab
## of RStudio, what do you notice about the number of observations for the 
## duplicates dataframe compared to the two original dataframes?

#ANSWER: The number of the observations of the duplicates df is equal to sum of the abundance and Alt data frames. 

## TASK: Save your R script. Stage, commit, and pull/push your modified code to 
## the branch you created for this week with an appropriate commit message.


## TASK: Open the duplicates dataframe by clicking on the file name in the 
## environment tab. Sort by Taxa, Plot, Block, Watershed, and RecDate by clicking
## on the tops of those columns in that order.
## You could also run the following code to get the same outcome:
duplicates[with(duplicates, order(RecDate, Block, Plot, Taxa)),]


## QUESTION: What do you notice about the data? Specifically, compare rows 
## 4934 and 12173 (if they are sorted correctly, those should be on top).
duplicates[4934, ]
duplicates[12173, ]

#ANSWER: They are from different years, watersheds, blocks, plots, and are different spp. They are not duplicated rows. 

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

#ANSWER: There is less than half the number of obswervations than the duplicates df. There are less observations than the original two df


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