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
#Answer: The file contains information anbout the people who contributed to the data, along with some information about how the experiment was performed, and information about what code was used to interpret/use the data.


## QUESTION: From this file or the original website, who are the dataset contributors?
#Answer: The people listed in the document are, Kimberly Komatsu, Meghan Avolio, Andrew Hope, Sally Koerner, Allison Louthan, kevin Wilcox, and Konza LTER.


## QUESTION: From this file or the original website, what are the start and end 
## dates of the dataset?
#Answer: I think that the start date is 2019-01-01, and the end date is 2022-12-30.


## QUESTION: Is the data collection still ongoing?
## Confession from Professor Komatsu: despite the dates of data included in the 
## file, the answer here is yes.We're just behind in getting the data cleaned 
## and uploaded :(
#Answer: Then the answer is yes, the data is still ongoing, sometimes this stuff takes a really long time so it is alright if it gets a bit behind.


## QUESTION: Given your answer to the previous question, why might it be good to
## have a reproducible script for data analysis related to this dataset?
#It would be good to have a reproducible script for data analysis because if a project becomes less important than another at any given time leading to a pause on the project, it is important to have a way to easily get back to the project when it is time again, and to know where you were and how to start back at it.


# ----------------------------------------------------------
#### 2) Preventing GitHub from syncing the data files.####
# ----------------------------------------------------------

## We can use the .gitignore file to tell git what files not to sync to GitHub!

## RETURN TO QUESTION: What are two reasons why we wouldn't want GitHub to sync this data?####
#Answer: The reasons why we might not want GitHub to sync data is because GitHub repositories can be used by multiple people, and so you might not want other people to be able to see the data. Also, data is often in very large file sizes that could use a lot of data space.


## TASK: Check the Git tab in RStudio. Do you see your data folder listed?
#Answer: Yes
## Now, open the .gitignore file from the files tab in RStudio.
## Tell git to ignore the entire folder containing the data you just downloaded.
## Save the .gitignore file.


## QUESTION: What happened to the data folder listed in the Git tab of RStudio
## when you hit save?
#Answer: When I saved the data to the .gitignore file my data file disappeared from the Git tab


## TASK: Stage, commit, and pull/push your modified .gitignore file to the branch
## you created for this week with an appropriate commit message.


# ----------------------------------------------------------
#### 3) Getting open data into R.####
# ----------------------------------------------------------

## You can import your data into R!

## TASK: Start by setting your working directory to the GitHub repository folder
## for this class on your computer using the function setwd().
## Hint - set the working directory as the top folder.
setwd("C:/Users/bigsi/OneDrive/Desktop/UNCG_DataWrangling")

## TASK: Now we can import one of these datasets into R. Let's import the plant
## species abundance datafile (CME011). To do so, use the read.csv() function, 
## putting the relative file path and file name. Assign the dataframe you import
## a name that includes the experiment name (conSME) and the data type (abundance)
## using '<-' and be sure to carefully consider your naming convention when doing so.
?read.csv
conSME_abundance<-read.csv("McLester_conSME_data/CME011.csv")

## After completing the above taask, run the following code.
conSMEcoverAlt <- read.csv("https://pasta.lternet.edu/package/data/eml/knb-lter-knz/148/5/5716ee946efd717292fa3da9241cda7c")


## QUESTION: What did this code do? What can you say about the two dataframes 
## you have created thus far?
#So I can now see that there are two sets of data in my environment tab, I can see that they both are 9245 obs, but they have different names. They are identical in size.


## TASK: Check to see if the two dataframes are identical using an R function.
## (Hint: remember the Week 1 assignment?)
identical(conSME_abundance,conSMEcoverAlt)
#Answer: This came back as true meaning that they are identical dataframes

## QUESTION: Why might it be better to source data straight from the data portal?
## Why might it be worse?
#Answer: Pulling the data straight from the data portal means that you know all of the data is there, and that you can always come back to it. compared to from your computer where you could accidently upload the wrong data set, and it might not be an accessible path for other people to see the data. It is also really easy to accidentally delete a data file on your laptop and then store it in a different place and the code no longer works for you either.


## TASK: Save your R script. Then stage, commit, and pull/push your
## modified code to the branch you created for this week with an appropriate 
## commit message. Remember, it is most effective to commit small chunks of code 
## often with specific commit messages!
#DONE!



# ----------------------------------------------------------
#### 4) Thinking through your naming conventions.####
# ----------------------------------------------------------

## TASK: Check the names of the columns in the species cover dataset you imported.
## (Hint: remember the Week 1 assignment?)
colnames(conSME_abundance)

## QUESTION: What naming convention did the dataset creators use for column names?
#Answer: They used no dashes or underscores, they used a capital letter to differentiate words.


## QUESTION: What naming convention do you plan to use for this course for the
## following types of objects in R:
## R scripts: I will use underscores - Ex. Open_Science
## vectors: I like dashes and all lowercase for vectors - Ex. open-science
## dataframes: I might use periods for dataframes - open.science.data
## columns within dataframes: I also like the capitals to differentiate words: OpenScience
## homemade functions: I can use astrix for homemade functions: open*science()


## QUESTION: Do all of your objects follow the same naming convention or do you
## plan to use different naming conventions to reference different object types?
#Answer: I would like to try to use all different conventions so that I can keep everything seperate/know what everything is


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
duplicates<-rbind(conSME_abundance,conSMEcoverAlt)

## QUESTION: Looking at the information for each dataframe in the environment tab
## of RStudio, what do you notice about the number of observations for the 
## duplicates dataframe compared to the two original dataframes?
#Answer: The duplicates dataframe has 18490 observatios instead of 9245. This makes sense because 9245*2 is 18490


## TASK: Save your R script. Stage, commit, and pull/push your modified code to 
## the branch you created for this week with an appropriate commit message.


## TASK: Open the duplicates dataframe by clicking on the file name in the 
## environment tab. Sort by Taxa, Plot, Block, Watershed, and RecDate by clicking
## on the tops of those columns in that order.
## You could also run the following code to get the same outcome:
duplicates[with(duplicates, order(RecDate, Block, Plot, Taxa)),]


## QUESTION: What do you notice about the data? Specifically, compare rows 
## 4934 and 12173 (if they are sorted correctly, those should be on top).
#Answer: They are on top! Yay!. What I noticed about 4934 and 14179 is that all of the information for the two of them is the same. I also noticed there seems to be a pair for each species which makes sense because we have combined two data sets with identical data.


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
#Answer: So conSME_abundance, conSMEcoverAlt, and duplicates still have the same number of observations, but noDuplicates now has less than all three other dataframes. There are the two original dataframes with 9245, and then duplicates that has the double # over 18490, but then noDuplicates has 9175.


## TASK: Go back to our repository in GitHub through your web browser. Find the
## issue you created and resolve it.

## TASK: Save your R script. Stage, commit, and pull/push your modified code to 
## the branch you created for this week with an appropriate commit message.



# ----------------------------------------------------------
#### 6) The final push :) ####
# ----------------------------------------------------------

## TASK: Type a comment below.
#Answer: This is my comment

## TASK: Follow these instructions carefully!
## Save your R script. Stage and commit with the commit message "learning to 
## amend", but this time DON'T pull/push your modified code!

## TASK: Type another comment below.
#Answer: This is my second comment

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