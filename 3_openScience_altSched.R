#### MODULE 2: Open Data, Project Management, and GitHub #### 

library(gitcreds)
gitcreds_set()

library(usethis)
create_github_token()
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
# a description of a research project being conducted at the Konza Prairie

## QUESTION: From this file or the original website, who are the dataset contributors?
# Kim Komatsu, Meghan Avolio, Andrew Hope, Sally Koerner, Allison Louthan, Kevin Wilcox, Konza LTER

## QUESTION: From this file or the original website, what are the start and end 
## dates of the dataset?
# start: 2019-01-01
# end: 2022-12-30

## QUESTION: Is the data collection still ongoing?
## Confession from Professor Komatsu: despite the dates of data included in the 
## file, the answer here is yes. We're just behind in getting the data cleaned 
## and uploaded :(

## QUESTION: Given your answer to the previous question, why might it be good to
## have a reproducible script for data analysis related to this dataset?
# Having reproducible script is useful when a project is being worked on by multiple people because it allows for several different edits to be made to a file, and then potentially combined later, when each person has ocmpleted their specific data cleaning (etc) tasks

# ----------------------------------------------------------
#### 2) Preventing GitHub from syncing the data files.####
# ----------------------------------------------------------
## We can use the .gitignore file to tell git what files not to sync to GitHub!

## QUESTION: What are two reasons why we wouldn't want GitHub to sync this data?
# The data has not been completely cleaned yet, and we do not want an unfinished script to be made publicly available to other github users. Additionally, it allows you to be specific about what files to ignore. You can upload all of the contents of a folder to git, but 'ignore' anything within that folder that is not ready to be shared. 

## TASK: Check the Git tab in RStudio. Do you see your data folder listed?
## Now, open the .gitignore file from the files tab in RStudio.
## Tell git to ignore the entire folder containing the data you just downloaded.
## Save the .gitignore file.

## QUESTION: What happened to the data folder listed in the Git tab of RStudio
## when you hit save?
# the size of the file changed, and it popped up in my Git tab as a new path


## TASK: Stage, commit, and pull/push your modified .gitignore file to the branch
## you created for this week with an appropriate commit message.
# I think I did this??? 

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
conSME_spec_abundance <- read.csv("~/Desktop/UNCG_DataWrangling/Dixon_conSME_data/knb-lter-knz.148.5/CME011.csv")

## After completing the above task, run the following code.
conSMEcoverAlt <- read.csv("https://pasta.lternet.edu/package/data/eml/knb-lter-knz/148/5/5716ee946efd717292fa3da9241cda7c")

## QUESTION: What did this code do? What can you say about the two dataframes 
## you have created thus far?
# both codes appear to have made the same dataframe, as there are multiple ways to load and open the same datasets. 

## TASK: Check to see if the two dataframes are identical using an R function.
## (Hint: remember the Week 1 assignment?)
identical(conSME_species_abundance, conSMEcoverAlt) #TRUE

## QUESTION: Why might it be better to source data straight from the data portal?
## Why might it be worse?
# It can be problematic because in order to source from the data portal, you have to specify the working directory within the line of code. This means that it only works on your specific device, and does not translate as well to other devices. For the same reason, it can be useful to share the csv publicly, allowing for others to download it into whatever location they choose. 

## TASK: Save your R script. Then stage, commit, and pull/push your
## modified code to the branch you created for this week with an appropriate 
## commit message. Remember, it is most effective to commit small chunks of code 
## often with specific commit messages!

#having issues with the git connection. when I hit the push button, it asks me for my keychain login, but I do not recall ever setting that up. 


# ----------------------------------------------------------
#### 4) Thinking through your naming conventions.####
# ----------------------------------------------------------

## TASK: Check the names of the columns in the species cover dataset you imported.
## (Hint: remember the Week 1 assignment?)
colnames(conSMEcoverAlt)

## QUESTION: What naming convention did the dataset creators use for column names?
# capitalization 

## QUESTION: What naming convention do you plan to use for this course for the
## following types of objects in R:
## R scripts
## vectors
## dataframes
## columns within dataframes
## homemade functions
# I like to use a combination of capitalization and underscores


## QUESTION: Do all of your objects follow the same naming convention or do you
## plan to use different naming conventions to reference different object types?
# so far, I have not gotten specific with using different conventions for different objects, but I can see why this is useful

## TASK: Save your R script. Stage, commit, and pull/push your modified code to 
## the branch you created for this week with an appropriate commit message.
# I need to come to your office hours on monday to get this issue worked out.

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
duplicates <- rbind(conSME_species_abundance, conSMEcoverAlt)

## QUESTION: Looking at the information for each dataframe in the environment tab
## of RStudio, what do you notice about the number of observations for the 
## duplicates dataframe compared to the two original dataframes?
# the number has doubled

## TASK: Save your R script. Stage, commit, and pull/push your modified code to 
## the branch you created for this week with an appropriate commit message.


## TASK: Open the duplicates dataframe by clicking on the file name in the 
## environment tab. Sort by Taxa, Plot, Block, Watershed, and RecDate by clicking
## on the tops of those columns in that order.
## You could also run the following code to get the same outcome:
duplicates[with(duplicates, order(RecDate, Block, Plot, Taxa)),]


## QUESTION: What do you notice about the data? Specifically, compare rows 
## 4934 and 12173 (if they are sorted correctly, those should be on top).
# those are not the first two rows I see ...

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