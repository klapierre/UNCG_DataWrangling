# WEEK 7

# select() function allows subsetting by columns
# filter() function allows subsetting by rows
# arrange() function to rearrange rows
# mutate() function to make a new variable in dataframe
    # unite() to combine to text variables together
    # separate() to split columns apart

# pseudocode is the planning stage; there should be a line for each part of the data cleaning phase 


# WEEK 8
# data in wide format useful for recording data in the field, takes less space on paper itself, requires less re-writing the exact same thing
# can link dataframes with acronyms to a dataframe with a key

# summarize() performs mathematical function to columns or rows to simplify the data
# mean
# sd
# min and max

# to ignore NA values: 
  # function(column), na.rm=T
  # function(!is.na(column))

# group_by() allows us to group variables BEFORE applying a function 
  # must ungroup() before moving forward or applying new functions to avoid issues of code breaking

# pivot_longer() lengthens data by collapsing multiple columns into one 
  # have to specify which columns you are trying to change, then apply names_to="newname" and values_to="newname" 

# pivot_wider() widens data by spreading two columns into multiple
  #names_from and values_from because it already knows the column names as they currently exist 

# fill=NA will avoid issues of missing data


# combining dataframes with reference to contents
# Mutating joins!!! 
# inner_join() only keep what is shared between both dataframes
# left_join() left dataframe is whichever is listed first
# right_join()
# full_join() spaces with no data will automatically fill with NA

# note about duplicates: repeated values can skew the data when working with numerical data. not always such a big deal with character data... 

# WHEN IN DOUBT TRY (adding or removing) QUOTES






# notes for group project (questions similar to class assignment)

# QUESTION: How many specimens are in the mammal dataframe?

# QUESTION: Given the number of species present in this dataframe (what code allows us to easily check a unique variable such as this one?), why are we color by order rather than indivudal species 
