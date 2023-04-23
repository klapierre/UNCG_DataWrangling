# --------------------------------------------------------------------------- #
####                      Section 4: *THE* Titanic                         ####
# --------------------------------------------------------------------------- #


# Now that you've had some practice with gganimate, it's time to really test your knowledge!

# In this section, we're going to use the power of gganimate to better display 
# how different factors affected who would survive the sinking of the Titanic

# But first, lets get some new data to mess around with.
# Make sure you have the "titanic.csv" file downloaded from the github branch or Canvas.
# Then load it into R as an object and name it "rawTitanic"

rawTitanic <- read.csv("titanic.csv")

# This data is a passenger list for the RMS Titanic, including information on the
# different passengers' names, if they survived, sex, age, number of siblings/spouses aboard, number of parents/children aboard, ticket number, ticket fare,
# cabin number, passenger class, and where they boarded the ship.

# Take a moment to look it over and see how the different variables are named
# Note that siblings/spouses (SibSp) and parents/children (Parch) are only 2 columns rather than 4

# Question: What problems could the SibSp and Parch columns make for us due to 
# how they are recorded?

####+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++####
# Answer: something along the lines of how you can't separate number of siblings 
# from spouses or parents from children. Or, any other problems that make sense
####+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++####

# Question: What columns seem to be missing information?

####+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++####
# Answer: The age column has some N/As and the cabin column is missing a lot of entries.
###++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++####


# Now, as we can see, this data is pretty untidy with lots of empty cells and
# columns that are tricky to work with. So lets trim it down to just what we want

# Task: Make a new dataframe called "titanicTidyAge" and have it only include the
# PassengerId, Survived, Pclass, Name, Sex, and Age columns.
# Filter out any N/A values in any of the cells. Try using the na.omit() function.
# Then make a new column with the age as a 10 year range or age in decades
# (Make sure the highest age is "60+")

####+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++####
# Answer: 
titanicTidyAge <- rawTitanic %>% 
  select(c(PassengerId, Survived, Pclass, Name, Sex, Age)) %>% 
  na.omit() %>% 
  mutate(AgeDecade = floor(Age/10)*10) %>% 
  mutate(AgeDecade = ifelse(AgeDecade>=60,
                "60+",
                AgeDecade))

####+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++####


# Once you have that we'll make a second data frame named "titanicTidyCabin" 
# 1) Include the PassengerId, Survived, Pclass, Sex, Age, and Cabin columns
# 2) Make a new column that includes just the starting letter from the cabin number, and an N/A if the cell is empty. (try out grepl() functions for this)
# This letter is the deck the cabin was located, A was the topmost deck and B the
# next, and so on

####+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++####
# Answer: or anything that makes the same table like some complicate ifelse setup
titanicTidyCabin <- rawTitanic %>% 
  select(c(PassengerId, Survived, Pclass, Sex, Age, Cabin)) %>% 
  mutate(Deck = str_extract(Cabin, "[aA-zZ]+")) %>% 
  na.omit()

####+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++####


# Next you'll be using each of those to make a graph.

# Task: Make a bar plot using the titanicTidyAge data frame that:
# 1) Plots Sex against number of survivors 
# 2) Animate the length of the bars by decade age groups
# 3) Include a label for what age range is currently shown
# 4) Be sure to add appropriate x- and y-axes labels and title
# 5) Color the columns something other than the default
# Reminder: You may need to further filter the data frame

####+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++####
# Answer: 
graphAge <- titanicTidyAge %>% 
  filter(Survived==1)

ggplot(graphAge, aes(x=Sex, fill = Sex)) +
  geom_bar() +
  transition_states(AgeDecade, state_length = 1, transition_length = 3) +
  ease_aes("sine-in-out") +
  labs(subtitle = "Passengers in their {closest_state}'s")

####+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++####


# Task: Make a scatter plot using the titanicTidyCabin data frame:
# 1) Plotting age of passengers on the y-axes and deck level on the x-axes
# 2) Coloring points by Survived, with point shape by Sex
# 3) Animating the point position by Pclass
# 4) Jitter the points so they don't all overlap
# 5) Add code to display what Pclass you're currently showing
# 6) Add appropriate x- and y-axes labels
# 
# Hint: Try aes(group = seq_along(...)) to get all your points to disappear 
# between frames rather than some disappearing and some moving
# see https://cran.r-project.org/web/packages/gganimate/vignettes/gganimate.html
# for examples

####+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++####
# Answer: 

ggplot(titanicTidyCabin, aes(x=Deck, y=Age, fill=as.factor(Survived), shape=Sex)) +
  geom_point(aes(group = seq_along(Pclass)), position = "jitter") +
  scale_shape_manual(values = c(21, 24)) +
  scale_fill_manual(
    values = c("white", "black"),
    guide = guide_legend(override.aes = list(shape = 21))
  ) +
  transition_states(Pclass, transition_length = 2, state_length = 1) +
  enter_fade() +
  exit_fade() +
  labs(subtitle = "Currently showing Class {closest_state} passengers")

####+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++####


