### ------ Preparation ------ ###



## Obtaining resources:

# The data used is within this link:
# https://datadryad.org/dataset/doi:10.5061/dryad.8c4092n

# Download the .csv file at the top of the page (under "Data files"). 
# After downloading the file, it should look like this:

Vagi+et+al_S3+Supplementary+data.csv

# Read through the complete article through this DOI link:
# (This is optional for the viewer)
# https://royalsocietypublishing.org/rspb/article/286/1900/20182737/85002/Parental-care-and-the-evolution-of-terrestriality


## Set up the resources and packages needed to begin this project:

library(tidyverse)

# Here, we are just loading the "tidyverse" package.

# "tidyverse" is a key package in tidying our data, as it contains many functions that allow us to alter and visualize our data in future steps.

untidy_data <- read.csv2("Vagi+et+al_S3+Supplementary+data.csv")

# Here, we are creating a dataframe that we can use as a baseline for the rest of this project, out of the data we downloaded earlier.

# So, if you opened the .csv file you downloaded straight from your file folder, you would notice that everything seemed smashed into one column.

#We have a problem before we can even start.

# The "read.csv" function does not work, so we need to use the "read.csv2" function. 

# The "read.csv" function reads through comma-separated files while the "read.csv2" function reads through semicolon-separated files.

# Basically, we had to download a .csv file of a .csv2 file, pushing us to re-read it as such within R Studio.



### ------ Splitting One Dataframe Into Three Dataframes ------ ###



# Our "untidy_data" dataset can be broken down into three sections:

# 1.) Names (Species, Family, and Clade)
# 2.) Character/numerical data
# 3.) Authors of references

# We are only going to be focusing on the character/numerical data, so we don't need the extra clutter.

# At the same time, we don't want to delete the rest of the data, so we will just separate them into three distinct datasets.

names_data <- untidy_data[, c("Species", "Family", "Clade")]

# This will create a dataframe specific to the names.

untidy_char_num_data <- untidy_data[, !names(untidy_data) %in% c("Family", "Clade", "Parental.care.references", "Terrestrial...aquatic.reproduction.references", "Direct.development.references", "Female.size.references", "Male.size.references", "Egg.size.references", "Clutch.size.references")]

# This will create a dataframe specific to the character/numerical data.

# When creating a new dataframe for the character/numerical data, it was easier choosing what to remove than what to add.

references_data <- untidy_data[, c("Species", "Parental.care.references", "Terrestrial...aquatic.reproduction.references", "Direct.development.references", "Female.size.references", "Male.size.references", "Egg.size.references", "Clutch.size.references")]

# This will create a dataframe specific to the author references.


## Notes:

# Each dataframe still contains the "Species" column, because we need to make sure the data ties together even when separated.

# The "Species" column is unique in every instance, so so it works well.



### ------ Tidying Our Character/Numerical Data ------ ###



#