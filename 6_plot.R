# ---------------------------------------------------------- #
#### MODULE 3: Plot some data!                            ####               
# ---------------------------------------------------------- #

## OBJECTIVE:
# 1. To develop a "grammar of graphics".
# 2. To become comfortable using ggplot2 for exploratory data visualization.


# ---------------------------------------------------------- #
#### SET UP:                                              ####
# ---------------------------------------------------------- #
# REMINDER: In RStudio, open the Rproject for our course (UNCG_DataWrangling), 
# pull any changes from GitHub, and navigate to the branch you created for 
# yourself (just a single branch for the whole semester) in RStudio's Git tab.
# Open this week's assignment in this new branch to complete and submit on GitHub.
# Ideally, you'll commit your answers a bit at a time as you work through
# this assignment, rather than committing all at once at the end.


# ---------------------------------------------------------- #
#### UNDERSTANDING A GRAMMER OF GRAPHICS                  ####
# ---------------------------------------------------------- #

# About a grammar of graphics:
# The author of ggplot2, Hadley Wickham, discusses his graphing philosophy in his 
# paper titled Grammar of Graphics: http://vita.had.co.nz/papers/layered-grammar.pdf

# What is a grammar of graphics?
# A grammar of graphics is a vocabulary that enables us to concisely describe the 
# components of a graph. This allows us to move beyond named graphics (e.g., a "bar 
# graph") and gain insight into the structure that underlies graphics.

# Components that make up a graph include:
## Data and aesthetic mapping
## Geometric objects
## Scales
## Facet specification
## Statistical transformations
## The coordinate system (position)

# Together, the data, mapping, statistical transformation and geometric object 
# form a layer. A plot may have multiple layers; for example, overlaying points
# representing data with a smoothed line representing a best-fit model.

# Thus, a layered grammar of graphics builds a plot this way:
## A default dataset and set of mappings from variables to aesthetics.
# (1) One or more layers, each containing one of the following:
#     (a) geometric object, 
#     (b) statistical transformation,
#     (c) position adjustment, 
#     (d) dataset, 
#     (e) a set of aesthetic mappings.
# (2) One scale for each aesthetic mapping.
# (3) A coordinate system (ie, Cartesian, Polar, etc).
# (4) The facet specification.


# TASK: We will be using the ggplot2 package for graphing. Fortunately, ggplot2 
# is nested within the tidyverse package (along with many others).
# Start by writing code to load the tidyverse library.
# HINT: see the end of assignment #1 if you forgot how to load a package.

library(tidyverse)

# ---------------------------------------------------------- #
### PART 1.0: TIDY THE DATA                               ####                                           
# ---------------------------------------------------------- #

# This week we'll be starting with a dataset of fish that were found at different
# locations in the Spokane river in 2013. We will focus on the Redband Trout, which
# is a subspecies of Rainbow Trout. Redband Trout have been facing population
# declines due to habitat loss and competition with non-native species.

# HINT: Refer back to the 4_wrangle.R and 5_transform.R assignments if you forget
# how to achieve any of the tasks in this section.

# TASK: Write code to perform the following steps within one pipeline:
# (1) Load the csv file "LowerSpokaneFish.csv" and assign it to a 
#     dataframe called redband.
# (2) Filter the dataframe to only include observations that have "RB" in the
#     Species column.
# (3) Further filter the dataframe to include only fish that have been aged
#     by removing any observations where ScaleAge is NA.
redband <- read.csv(file = "C:\\Users\\leoiv\\Downloads\\LowerSpokaneFish.csv") %>% 
  filter(Species=='RB', !is.na(ScaleAge))
view(redband)

# ---------------------------------------------------------- #
### PART 1.1 AESTHETICS AND MAPPING                       ####
# ---------------------------------------------------------- #

# We will work through this file to build up our graphic slowly, one component
# at a time.

# MOTIVATION: There is often a length requirement for what fish you can take
# for recreational fishing. We want to look at the distribution of lengths of 
# Redband Trout in the lower Spokane River.

# GOAL: Build a histogram of lengths of Redband Trout in the lower Spokane River.

# The first thing we need is a coordinate system. Run the following code to make
# a blank graph with a coordinate system.
ggplot()

# Now we want to add in an aesthetic (aes). In ggplot2, an "aesthetic" refers to 
# something you can see, such as an axis, a point, a bar, or a line.
# Because we are going to build a histogram, we only need an x-axis aesthetic.
# Run the following code to generate our x-axis based on the Length column
# in our redband dataframe.
ggplot(redband, aes(x = Length))

# QUESTION: What was generated by running the code above? Why is there no data 
# included in the output?

## There is one axis on the bottom - Length, with intervals of 100s. There is no
## value on the graph because we did not select what the y-axis is going to be
## which is necessary to place the point somewhere on the graph.


# ---------------------------------------------------------- #
#### PART 1.2 GEOMETRIC OBJECT - HISTOGRAM                ####
# ---------------------------------------------------------- #

# Now let's add in the data! Run the following code to include a geometric
# object (geom). In this case, the geometric object is a histogram.
ggplot(redband, aes(x = Length)) + 
  geom_histogram()
# NOTE: When using the ggplot function, we use the + to indicate passing from
# one aesthetic or geometric object to the next. No pipes here!

# QUESTION: What was generated by running the code above? What do you notice 
# about the labels for the x- and y-axes?

## Boxes of fish counts were generated, automatically placing 'count' as the y-axis.

# When you run the above line of code, you get a message that tells you
# bins=30 and that you can pick better values with `binwidth`. Let's try this!
# Run the code below to make a new graph below where we change binwidth to be 50.
# HINT: Check out ?geom_histogram to pull up the help page.
ggplot(redband, aes(x = Length)) + 
  geom_histogram(binwidth=50)

?geom_histogram
# QUESTION: What changed about our output when we asked for binwidth=50?

## There are now fewer count bins, and the differences between them are greater.

# TASK: Some other factors might affect this distribution of redband length?
# Make another histogram that plots the distribution of ScaleAge for the redband
# dataframe.

ggplot(redband, aes(x=ScaleAge)) +
  geom_histogram()

# QUESTION: If ScaleAge represents how old the fish are in years, what do you notice
# about the Redband Trout population based on the figure you generated?

## The majority of fish caught are about 1 year old.

# TASK: Fish weight is also an interesting variable. Make a histogram that plots
# the distribution of Weight for the redband dataframe.

ggplot(redband, aes(x=Weight)) +
  geom_histogram()

# QUESTION: What warning message is generated in the console when you create the 
# weight histogram? What does this warning message mean? Do you think it is ok 
# to proceed or should you alter your code to get rid of this warning?

## There's a warning that '88 rows containing non-finite values' were deleted.
## I think this is fine to leave since these are most likely NA's or other 
## character-based values.

# ---------------------------------------------------------- #
#### PART 1.3 GEOMETRIC OBJECT: POINTS                    ####
# ---------------------------------------------------------- #

# QUESTION: In the code below, what is the dataframe being examined?
# What are the aesthetics? What will the resulting graph be plotting?
ggplot(redband, aes(x=ScaleAge, y=Length))

## The dataframe is 'redband,' the aesthetics are a x-axis representing scale age
## and a y-axis representing length. This will show the relationship between
## age of the fish and total length if we were to add some data to it.


# When we start, we tell ggplot that we want certain aesthetics (x- and y-axis).
# But without specifying a geometric object (what shape to add to the plot), we won't
# see any data! Let's add a new type of geometric object (points!) by running the 
# following code:
ggplot(redband, aes(x=ScaleAge, y=Length)) + 
  geom_point()


# QUESTION: Based on the figure that was generated from the code above, 
# what would you conclude about the relationship between fish age and length?

## Fish age and length are positively correlated, but cap out at around 400mm
## after the second year.

# TASK: Write your own code to visualize the relationship between Redband 
# length and weight.

ggplot(redband, aes(x=Weight, y=Length)) + 
  geom_point()

# ---------------------------------------------------------- #
#### PART 1.4 ADDING AESTHETICS TO GEOMETRIC OBJECTS      ####
# ---------------------------------------------------------- #

# We can also add aesthetics to any geometric object!
# For example, we can integrate the relationships we plotted above among Redband
# age, length, and weight by coloring points on our figure plotting length vs weight
# based on ScaleAge. To do this, we have to nest an aes() statement within the 
# geom_point() statement. Try it out by running the following code:
ggplot(redband, aes(x=Length, y=Weight)) + 
  geom_point(aes(color=as.factor(ScaleAge)))

# TASK: Copy and paste the code above to make the same graph, but this time remove
# as.factor() from the part where we color by ScaleAge.

ggplot(redband, aes(x=Length, y=Weight)) + 
  geom_point(aes(color=ScaleAge))

# QUESTION: What differs between the graph where ScaleAge was wrapped in the
# as.factor() statement and the graph where you removed as.factor()? Why?

## The as.factor statement created a set of seven colored bins for ScaleAge,
## while the unwrapped version converted it to a gradient which is a little
## less obviously representing age year.


# TASK: Visit the ggplot Cookbook webpage at http://www.cookbook-r.com/Graphs/
# This website is a great go-to place to find how to change all kinds of things
# about the graphs you make. You might want to bookmark this one!

# TASK: Copy and paste the code for our previous graph below. Then modify the
# aesthetics of the geometric object so that the size of the points varies with 
# as.factor(ScaleAge).

ggplot(redband, aes(x=Length, y=Weight)) + 
  geom_point(aes(size=as.factor(ScaleAge)))

?geom_point
?aes

# TASK: Modify the aesthetics of the geometric object from the previous graph
# so that the size AND color of the points varies with ScaleAge.

ggplot(redband, aes(x=Length, y=Weight)) + 
  geom_point(aes(color=as.factor(ScaleAge), size=as.factor(ScaleAge)))

# It is important to note that different kinds of geometric objects have different
# types of associated aesthetics. Points and lines have colors, while bars and
# boxplots have fills and colors. Try running the following lines of code:
ggplot(redband, aes(x = as.factor(ScaleAge), y = Weight)) + 
  geom_boxplot(color = 'purple', fill = 'green')

# QUESTION: What does color mean for boxplots? What does fill mean for boxplots?
## Color relates to line color, while fill relates to the fill color (or, box color).

# QUESTION: Why did we have to specify as.factor() for ScaleAge in the initial
# aes() statement? 
# HINT: Try running the code without that statement, what happens?

## Without telling it that ScaleAge is a factor, it uses the variables within
## ScaleAge to create the mean/min/max/etc. of the whisker plot - instead of 
## plotting the weight against scale age.

ggplot(redband, aes(x = ScaleAge, y = Weight)) + 
  geom_boxplot(color = 'purple', fill = 'green')

# ---------------------------------------------------------- #
#### PART 1.5 ADDING A LAYER: STATISTICAL TRANSFORMATIONS #### 
# ---------------------------------------------------------- #

# A statistical transformation takes a dataset as input and visualizes a new, 
# processed dataset with new variables as output. For example, we could relate 
# length and weight by calculating and graphing a smoothing function by running
# the following code:
ggplot(redband, aes(x = Length, y = Weight)) + 
  geom_point() + 
  geom_smooth()

# QUESTION: Using the geom_smooth help page, what type of function is being used 
# in the above graph for our statistical transformation fit?
# HINT: What is the default model type for a dataframe of our size?

## It's a trend line.

?geom_smooth

# We also can specify a specific model to fit. Try running the following code to
# specify a linear model:
ggplot(redband, aes(x = Length, y = Weight)) + 
  geom_point() + 
  geom_smooth(formula = y ~ x)

# TASK: As with most things in R, there are multiple ways to accomplish the same
# task. Using the geom_smooth help page, write code below to specify a linear
# model using a method= statement instead of the formula= statement.

ggplot(redband, aes(x = Length, y = Weight)) + 
  geom_point() + 
  geom_smooth(method=lm, se=TRUE)


# A linear model does not seem like a good fit to our data. Try running the
# following code to generate a quadratic model.
ggplot(redband, aes(x = Length, y = Weight)) + 
  geom_point() + 
  geom_smooth(formula = y ~ poly(x,2))


# Another example of a statistical transformation is geom_boxplot(), which
# calculates a new dataset by statistically transforming the dataframe and
# aesthetics. In the code below, ggplot creates a dataframe of  the mean and
# upper and lower quantiles of Weight within ScaleAge. Then it adds this
# transformed data as a geometric object to our axis aesthetics.
ggplot(redband, aes(x = as.factor(ScaleAge), y=Weight)) + 
  geom_boxplot()

# QUESTION: Name another statistical transformation we have already used in this
# assignment.
# HINT: It was in the very first part of the assignment.

## geom_histogram()


# TASK: Let's put this all together! Create a graph with the following:
# (1) redband dataframe,
# (2) x-axis = Length, y-axis = Weight
# (3) points colored by ScaleAge as a factor
# (4) quadratic line that is black in color and size=2 (HINT: check ggplot
#     cookbook to help figure out how to change line color and size).

ggplot(redband, aes(x=Length, y=Weight)) +
  geom_point(aes(color= as.factor(ScaleAge))) +
  geom_smooth(formula = y ~ poly(x,2), color="#000000", linewidth=2)



# ---------------------------------------------------------- #
#### PART 1.6 DATA IN VS DATA OUT                         #### 
# ---------------------------------------------------------- #

# Some figures take your raw data and plot it (like our dot plots above). Others
# take your raw data and summarize it (like our boxplots above). But some require
# you to summarize your own data before passing it into ggplot.

# Let's investigate. Try running the following code to make a boxplot. This code
# passes our raw data on Redband Trout weight into ggplot and asks to make a bar
# graph separated by fish age.
ggplot(redband, aes(x = as.factor(ScaleAge), y = Weight)) + 
  geom_bar(stat='identity')

# QUESTION: What is the graph output? Note the scale of the y-axis. Does this seem
# right to you? What do you think happened to result in this graph?

## The y-axis is way off scale - it's in the 10,000s when it should be in the 
## 100s. I have no idea what happened to the results to make them this way.

# Typically, when plotting a bar graph we want to have the output show the mean
# and standard error for each category. But unlike when we use the geom_boxplot 
# object, ggplot doesn't calculate these values for us when we when call the 
# geom_bar() object. So we'll have to do this ourselves.

# TASK: Write code to make a new dataframe called redbandSummary that does each
# of the following in a single pipeline:
# (1) Takes the redband data,
# (2) Groups by ScaleAge,
# (3) Summarizes to calculate a new column called Weight_mean that includes the 
#     mean weight for each group AND a new column called Weight_sd that includes
#     the standard deviation of weight for each group,
# (4) Mutates to create a new column called Weight_se that includes the standard
#     error of weight for each group (se=1.96*sd).
# HINT:Don't forget to remove NAs and ungroup at the appropriate place.

redbandSummary <- redband %>%
                    group_by(ScaleAge) %>%
                    summarize(Weight_mean=mean(Weight, na.rm=TRUE), 
                              Weight_sd=sd(Weight, na.rm=TRUE)) %>%
                    ungroup() %>%
                    mutate(Weight_se=1.96*Weight_sd)
                    
?summarize

# Let's try again to make our bargraph by running the following code:
ggplot(redbandSummary, aes(x = as.factor(ScaleAge), y = Weight_mean)) + 
  geom_bar(stat='identity')

# QUESTION: What does the stat='identity' part do in the code above? Check the 
# geom_bar() help or google to find the answer.

## It uses the exact value instead of using counts, like the other graphs have
## been doing.

# The above code gave us nice bars.  Now we need to add error bars! We will do this
# by adding in a second geometric object that specifies errorbars. Try it by
# running the following code:
ggplot(redbandSummary, aes(x = as.factor(ScaleAge), y = Weight_mean)) +   # Selects dataframe and sets the x-axis to be binned by age, and y to be mean weight.
  geom_bar(stat='identity') +   # Tells it to use the exact values in the dataframe, not counts.
  geom_errorbar(aes(ymin=Weight_mean-Weight_se,     # Sets the y-min to be the mean weight subtracted by the weight standard error.
                    ymax=Weight_mean+Weight_se,     # Sets the y-max to be the mean weight plus the weight standard error.
                    width=0.2))         # Sets the line width of the error bar as 0.2pt.

# QUESTION: Annotate the code above with what each line does.


# QUESTION: What does the statement width=0.2 do? If you're unsure, try removing
# it and seeing what happens.

## Provides a line width argument and sets it to 0.2pt.


# TASK: Modify the code below to make the bar fill light green, the bar outline 
# dark green, and the error bars dark orange with end caps 40% the bar width.
ggplot(redbandSummary, aes(x = as.factor(ScaleAge), y = Weight_mean)) + 
  geom_bar(colour="dark green",
               fill="light green",
           stat='identity') +
  geom_errorbar(aes(ymin=Weight_mean-Weight_se,
                    ymax=Weight_mean+Weight_se,
                    width=0.4),
                    colour="dark orange")

# ---------------------------------------------------------- #
#### PART 1.7 AESTHETICS PLACEMENT MATTERS!               #### 
# ---------------------------------------------------------- #

# In our previous figures, we have been placing the aesthetics statements for our
# lines in the geometric object functions. What happens if we move the aesthetics
# for color up into the initial ggplot aesthetics statement? Try it out by running
# the following code:
ggplot(redband, aes(x = Length, y = Weight, color = as.factor(ScaleAge))) + 
  geom_point() + 
  geom_smooth(method='lm', se=F)

# QUESTION: What is different about this graph from before?

## It looks insane. It also has linear models for each scale age bin, and is rainbow.

# ---------------------------------------------------------- #
#### PART 1.8: ALTERING SCALES                            ####
# ---------------------------------------------------------- #

# A scale controls the mapping from data to aesthetic attribute. For example, 
# the following are all aspects of scale: the size and color of points and lines,
# as well as axis limits and labels.

# Let's start by revisiting our basic length by weight scatter plot by running the
# following code:
ggplot(redband, aes(x = Length, y = Weight)) + 
  geom_point()

# We could alter the size and color and shape of the points, as we have done before:
ggplot(redband, aes(x = Length, y = Weight)) + 
  geom_point(size=1, color="darkblue", shape=1)

# We could add on to alter the x and y axes scales; for example, let's make put 
# them on a log10 scale by running the following code:
ggplot(redband, aes(x = Length, y = Weight)) + 
  geom_point(size=1, color="darkblue", shape=1) +
  scale_x_log10() + 
  scale_y_log10()

# We could customize the x and y axis labels to include species name and units:
ggplot(redband, aes(x = Length, y = Weight)) + 
  geom_point(size=1, color="darkblue", shape=1) +
  scale_x_log10() + 
  scale_y_log10() +
  xlab("Redband trout length (mm)") + 
  ylab("Redband trout weight (g)")

# TASK: Write code below to make a boxplot of scale age vs length on a linear-log
# scale (i.e., with scale age on a linear x axis and length on a log y axis).
# Fill in your boxplots with your favorite color and make the outline your least
# favorite color. Label the x-axis Scale Age (years) and the y-axis Length (mm).

ggplot(redband, aes(x = as.factor(ScaleAge), y = Length)) + 
  scale_y_log10() +
  geom_boxplot(fill="darkorange1",
           colour="darkkhaki") +
  xlab("Scale Age (years)") + 
  ylab("Length (mm)")

## Not working, I'm going to come back to this later because it's making me real mad.


# ---------------------------------------------------------- #
#### PART 1.9: SETTING THEMES                             ####
# ---------------------------------------------------------- #

# In lots of ways, the default graphics in ggplot may be less than ideal. We
# can change a lot of these defaults through altering the aesthetics of the 
# geometric objects we are creating (e.g., changing the point or bar colors).

# But to change the aesthetics of the overall plot (i.e., the non-data parts of
# our graphic), we have to alter the "theme".

# There are some "complete themes" that are set up in ggplot that we can work from.
# For example, try the following code to create our Redband dot plot with the
# black and white theme.
ggplot(redband, aes(x = Length, y = Weight)) + 
  geom_point() +
  theme_bw()

# What about the following code for the minimalistic theme?
ggplot(redband, aes(x = Length, y = Weight)) + 
  geom_point() +
  theme_minimal()

# Or the void theme?
ggplot(redband, aes(x = Length, y = Weight)) + 
  geom_point() +
  theme_void()

# TASK: Check out the section on complete themes in the ggplot2 book here:
# https://ggplot2-book.org/polishing.html#themes.  Try out two more themes below.

ggplot(redband, aes(x = Length, y = Weight)) + 
  geom_point() +
  theme_dark()

ggplot(redband, aes(x = Length, y = Weight)) + 
  geom_point() +
  theme_light()

# Rather than using the pre-set themes, we can also create our own! 
# The theme can be set to modify the text of plot titles, axis titles, axis labels,
# and legend elements (more about legends next week) to modify things such as
# font size, color, justification, and angle.
# We can also modify grid lines, background color, outline color, tick length,
# and more!
# Themes are super powerful!

# QUESTION: Compare the output for each of the following figures.
# Based on the output, what do you think panel.grid.minor vs panel.background 
# refer to? What does the aesthetic element_blank() do?
ggplot(redband, aes(x = Length, y = Weight)) + 
  geom_point() +
  theme(panel.grid.minor = element_blank())

## Creates a grey background with white ("blank") gridlines.

ggplot(redband, aes(x = Length, y = Weight)) + 
  geom_point() +
  theme(panel.background = element_blank())

## Creates a white/"blank" background.

# Try running the following code to alter text size:
ggplot(redband, aes(x = Length, y = Weight)) + 
  geom_point() +
  theme(axis.title.y=element_text(size=100))

# QUESTION: What does element_text() refer to in the code above?
## The size of the text in pixels, specifically for the y axis title.)

# TASK: Write your own code below to change the size of the x-axis labels
# (i.e., the numbers along the x-axis) to 50. 
# HINT: Check out the ggplot cookbook or ggplot2 themes websites for help.

ggplot(redband, aes(x = Length, y = Weight)) + 
  geom_point() +
  theme(axis.text.x=element_text(size=50))

# We can set the theme to include all kinds of variations by adding them all to
# the theme statement for an individual ggplot.
ggplot(redband, aes(x = Length, y = Weight)) + 
  geom_point() +
  xlab("Redband trout length (mm)") + 
  ylab("Redband trout weight (g)") +
  theme_bw() +
  theme(axis.title.x=element_text(size=20,
                                  vjust=-0.35,
                                  margin=margin(t=15)),
        axis.text.x=element_text(size=16),
        axis.title.y=element_text(size=20,
                                  angle=90,
                                  vjust=0.5,
                                  margin=margin(r=15)),
        axis.text.y=element_text(size=16),
        plot.title = element_text(size=24,
                                  vjust=2),
        panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        legend.title=element_blank(),
        legend.text=element_text(size=20))

# Another great thing is that we can set the theme without specifying a graph.
# That way the theme is set for all graphics we make throughout the code (unless
# we later specify a theme update for any given figure). This is handy to unify
# the overall look of our graphics without having to type it all out every time.
# Run the following code to set our theme for the rest of the assignment.
theme_set(theme_bw())
theme_update(axis.title.x = element_text(size = 20, vjust = -0.35, margin = margin(t = 15)),
             axis.text.x = element_text(size = 16),
             axis.title.y = element_text(size = 20, angle = 90,
                                         vjust = 0.5, margin = margin(r = 15)),
             axis.text.y = element_text(size = 16),
             plot.title = element_text(size = 24, vjust = 2),
             panel.grid.major = element_blank(),
             panel.grid.minor = element_blank(),
             legend.title = element_blank(),
             legend.text = element_text(size = 20))


# ---------------------------------------------------------- #
#### PART 1.10: SPECIFYING FACETS                          ####
# ---------------------------------------------------------- #

# Faceting makes it easy to graph different subsets of an entire dataset.
# For example, we could relate length and weight within each age class.
# We do that by adding a facet specification to our initial graph:
ggplot(redband, aes(x = Length, y = Weight)) + 
  geom_point() + 
  facet_wrap(~ScaleAge)

# We can allow the scales to vary and be unique for each graph by adding a
# statement to the facet_wrap statement:
ggplot(redband, aes(x = Length, y = Weight)) + 
  geom_point() + 
  facet_wrap(~ScaleAge, scales="free")

# We could also make a grid by faceting one variable by another.
ggplot(redband, aes(x = Length, y = Weight)) + 
  geom_point() + 
  facet_grid(Year~ScaleAge) 

# TASK: Make a histogram of length faceted by scale age.
# Keep the x-axis consistent across all subpanels, but allow the y-axis to be 
# specified uniquely for each subpanel.
# HINT: Check the help file for facet_wrap if you're unsure. Look under the 
# Arguments section for scales.

?facet_wrap

ggplot(redband, aes(x = Length, y = Weight)) + 
  geom_point() + 
  facet_grid(~ScaleAge, scales="free_y")

# ---------------------------------------------------------- #
#### PART 1.11: SAVING YOUR GRAPHICS                      ####
# ---------------------------------------------------------- #

# You've made some beautiful figures and now you probably want to save them!
# ggplot provides a handy way to do this with the ggsave() function.

# The ggsave() function has some nice defaults. These include saving the last plot
# you created at 300 dpi (dots per inch). But you can alter a lot of setting to
# customize this output.

# Try running the following code:
ggsave("Redband_histogram_facet.png")

# QUESTION: Where did this file show up? And what was the graph?

## It showed up in the folder I work in for this class, and it is the faceted graph
## I just made.

# TASK: Investigate the ggsave() function through the help files. Then write
# code to save the file at 600 dpi, 10 inch width and 8 inch height.

?ggsave

ggsave("Redband_histogram_facet2.png",
       width=10, 
       height=8, 
       units="in", 
       dpi=600)

# NOTE: You can also save the graphics you make by exporting them from the plots
# tab in RStudio. However, this can be less precise than specifying the graphic
# attributes using the ggsave function.


# ---------------------------------------------------------- #
#### PART 2.0: PUTTING IT ALL TOGETHER                    ####
# ---------------------------------------------------------- #

# QUESTION: So far in this assignment we have made a histogram, a boxplot, a bar
# graph, and a dot plot with a trend line. Which of these figures was an example
# of a correlation? Which showed deviations from a benchmark or baseline? And which
# was an example of a distribution?

## The dot plots are examples of correlation, the boxplots showed a deviation from
## baseline, and the histogram/bar graphs showed examples of distributions.


# TASK: Import the full SpokaneFish dataset, keeping all observations (i.e., 
# don't filter down to a single species or remove observations without scale age).
# Then make a set of plots faceted by species, with each plot displaying weight vs length, 
# putting length on a log10 scale, points as filled 
# triangles colored by species, informative x and y axes labels that include units.
# Then save your file as a .png with an informative figure name at a width of 9
# inches and a height of 7 inches and 450 dpi.

SpokaneFish <- read.csv(file="C:\\Users\\leoiv\\Downloads\\LowerSpokaneFish.csv")
ggplot(SpokaneFish, aes(x = Length, y = Weight, color = as.factor(Species))) + 
  xlab("Whole body length (mm)") + 
  ylab("Weight (g)") +
  geom_point(shape=2) + 
  scale_x_log10() +
  facet_grid(~Species)

ggsave("SpokaneFishWeightByLength.png",
       width=9,
       height=7,
       units="in",
       dpi=450)


?geom_point
# QUESTION: Why do you think we focused on Redband Trout for most of this assignment?

## The majority of the Spokane fish dataset consists of redband trout - if this is
## relatively unbiased sampling then they should be the dominate species in the
## area and the most statistically relevant.

# REMEMBER: Save and push your script when you're done with this assignment!
