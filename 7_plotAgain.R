# ---------------------------------------------------------- #
#### MODULE 3: Plot even more data!                       ####               
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

# Reminder of some helpful resources for graphing in R:
# ggplot Cookbook: http://www.cookbook-r.com/Graphs/
# Official ggplot2 Book: https://ggplot2-book.org/
# Themes in ggplot2: https://ggplot2-book.org/polishing.html#themes

# In ggplot2, aesthetic means “something you can see”. Each aesthetic is a
# mapping between a visual cue and a variable.
# Examples include:
# position (i.e., on the x and y axes)
# color (“outside” color)
# fill (“inside” color)
# shape (of points)
# line type
# size

# Each type of geometric object (geom) accepts only a subset of all aesthetics.
# Refer to the geom help pages to see what mappings each geom accepts. Aesthetic
# mappings are set with the aes() function.

# TASK: We will be using the ggplot2 package for graphing. Fortunately, ggplot2 
# is nested within the tidyverse package (along with many others).
# Start by writing code to load the tidyverse library.
# HINT: see the end of assignment #1 if you forgot how to load a package.
library(tidyverse)

# TASK: Write code below to set your theme to black and white and both your major
# AND minor gridlines to element_blank for all plots you'll be making today.
# HINT: Check back to last week's assignment section 1.9 for setting themes for
# all plots.
theme_set(theme_bw() +
            theme(panel.grid.major = element_blank(), 
                  panel.grid.minor = element_blank()))

# ---------------------------------------------------------- #
#### 1.0 CORRELATION                                      ####
# ---------------------------------------------------------- #

# We learned how to make correlations last week, but it never hurts to get
# more practice! Let's start by using a data set built into ggplot2.
# The mpg dataset looks at the gas efficiency of different cars. Run the following
# code to load the data:
data(mpg, package = "ggplot2")

# TASK: Create a scatterplot (i.e., a dot plot) to relate city and highway mileage.
# Color the points by the class of car (class column) and label the x and y axis 
# to be more informative (City Mileage (MPG) vs Highway Mileage (MPG)).
# HINT: Refer back to last week's assignment or the ggplot help resources if you 
# forget how to make a scatterplot.
mpg <- mpg
ggplot(mpg, aes(x = hwy, y = cty, color = class)) +
  geom_point() +
  labs(x = "Highway Mileage (MPG)", y = "City Mileage (MPG)")

# Looks alright, but the graph may be hiding some information...
# QUESTION: How many data points are in the mpg dataframe?
#Looking in the environment folder, there are 234 observations.
mpg

# QUESTION: Approximately how many dots are in the graph you just made? How does
# that compare to the number of observations in the dataframe?
#I counted about 78 dots on the graph compared to the 234 observations.

# Try another correlation-focused geom that addresses this problem by running
# the following code:
ggplot(data=mpg, aes(x=cty, y=hwy)) + 
  geom_jitter()


# QUESTION: What happened when you created the plot with geom_jitter?
#All the dots became black and there are more dots on the graph as well.

# QUESTION: Run the code to create a plot using geom_jitter a second time. Then run it
# again and again. What happens each time? Why is this happening?
#Each time the dots are moving and it seems that there are more and more dots on the graph.

# TASK: The default in geom_jitter is to jitter (or slightly move) the points away
# from each other in both the x and y directions. Check the help file for geom_jitter
# and write code below to make a graph where you jitter points in only the x-dimension
# by 0.5.
ggplot(mpg, aes(x = hwy, y = cty, color = class)) +
  geom_jitter(width = 0.5, height = 0) +
  labs(x = "Highway Mileage (MPG)", y = "City Mileage (MPG)")

# ---------------------------------------------------------- #
#### 1.1 DETOUR! COLORS, COLORS, COLORS                   ####
# ---------------------------------------------------------- #

# Our world is so colorful, and our graphs can be too! But we want to be mindful
# of our color choices to not only be beautiful, but also informative and accessible.

# TASK: Create a new dataframe that filters our mpg data down to only information
# for car classes compact, midsize, and suv using an %in% statement. Name your 
# new dataframe mpgSubset.
# HINT: Refer back to the Transform assignment if you want help with %in% (or 
# try googling!)
mpgSubset <- mpg %>% 
  filter(class %in% c("compact", "midsize", "suv"))

# ggplot has lots of nice (and some not so nice) built-in color palettes that we 
# can use to fill our bars with color. Try running the following code:
ggplot(data=mpgSubset, aes(x=cty, y=hwy, color=class)) +
  geom_jitter()

# The code above supplies us with ggplot's default color palette, which I find not
# so pleasing. Let's try to change this!

# We can add a statement specifying the scale of colors we would prefer. One way
# to do this is to use other pre-set palettes from ggplot. Run the code below to 
# ask ggplot to use the color brewer's palette called Set 1.
ggplot(data=mpgSubset, aes(x=cty, y=hwy, color=class)) +
  geom_jitter() +
  scale_color_brewer(palette="Set1")

# Alternatively, we could use the "RdBu" palette:
ggplot(data=mpgSubset, aes(x=cty, y=hwy, color=class)) +
  geom_jitter() +
  scale_color_brewer(palette="RdBu")

# QUESTION: Investigate the color brewer's range of palettes at this website: 
# https://r-graph-gallery.com/38-rcolorbrewers-palettes.html
# What do you notice about the colors chosen from each of the palettes that we
# used above? (i.e., does it use the first three colors in the palette? The last
# three? Some other combination?)
#The colors that were used by Set1 were the first three colors and RdBu used the rest. 

# We could also pick out EXACTLY which colors we want for our figure. 
# There are 4 main ways to specify colors in R:
### by name
### by number
### by Hex code
### with the rgb() function

# By Name: R allows you to call more than 600 colors by name! Run the following
# code to see a list:
colors()

# We can put in the colors we chose for each variable by adding the 
# scale_color_manual() function to our plot. Try it out by running the following
# code:
ggplot(data=mpgSubset, aes(x=cty, y=hwy, color=class)) +
  geom_jitter() +
  scale_color_manual(values=c('midnightblue', 'cornflowerblue', 'tomato3'))


# You can also chose colors by number, which are assigned in R.

# TASK: Copy and paste the code to make our scatterplot and replace the color names
# with three numbers of your choice (between 1 and 657). How does your new figure look?
# HINT: remember to remove the quotation marks when calling numbers.
ggplot(data=mpgSubset, aes(x=cty, y=hwy, color=class)) +
  geom_jitter() +
  scale_color_manual(values=c(5, 568, 42))

# QUESTION: How do you think you could figure out which color name belongs to
# each color number?
# HINT: Try creating a dataframe from color() by passing it into the
# as.data.frame() function.
color_df <- as.data.frame(colors())
color_df[552,]
#You can see what color name belongs to each color number by creating the dataframe with the colors function like the example above. And then printing the dataframe should give the color with the color number.
# You can also chose colors by Hex code. A Hex color code is a 6-symbol code made
# of up to three 2-symbol elements (6 symbols in length all together). Each of 
# the 2-symbol elements represents a color value in the Red-Green-Blue (RGB) color
# scale from 0 to 255. Hex codes are written with a # in front of them. Let's try
# out calling our colors using hex code.
ggplot(data=mpgSubset, aes(x=cty, y=hwy, color=class)) +
  geom_jitter() +
  scale_color_manual(values=c('#191970', '#6495ED', '#FF6347'))

# There are two great things about hex codes. First, you can call ANY color you 
# want with a hex code. That is, you're not limited to the 657 colors that are
# in ggplot. By specifying the color by hex code, you can pick literally anything!

# TASK: Google the search term "color picker". This should bring up google's color
# picker (in addition to a billion other color picking websites). Use this color
# picker to generate the hex codes for three new colors of your choice. Then copy
# and paste the above code, replacing the hex codes with your color choices.
ggplot(data=mpgSubset, aes(x=cty, y=hwy, color=class)) +
  geom_jitter() +
  scale_color_manual(values=c('#34b7eb', '#eb34e5', '#344ceb'))

# The second great thing about hex codes is that you can control the transparency
# of your colors. Transparency is set in a hex code by adding two extra symbols
# to the end, which together make up the "alpha" element. Adding 00 to the end 
# of your hex code will make your color completely transparent, while adding FF 
# to the end will make it completely opaque. Any number/letters in-between will 
# result in partial transparency. You can find a complete list of transparencies
# between 0-100% here: https://gist.github.com/lopspower/03fb1cc0ac9f32ef38f4

# TASK: Try out transparency by copying and pasting your graph code below and
# adding the alpha element to the end of each of your hex codes to make your
# first color 0% transparent, your second color 50% transparent, and your third
# color 100% transparent.
ggplot(data=mpgSubset, aes(x=cty, y=hwy, color=class)) +
  geom_jitter() +
  scale_color_manual(values=c('#34b7eb00', '#eb34e580', '#344cebFF'))

# QUESTION: What happened to the point that you set to 100% transparent?
#All the points for that one color disappeared from the graph.

# Finally, we can set our colors using the rgb() function. This operates very
# similarly to the hex code, where you can pick exactly the color and transparency
# you want. Try it out by running the following code:
ggplot(data=mpgSubset, aes(x=cty, y=hwy, color=class)) +
  geom_jitter() +
  scale_color_manual(values=c(rgb(.10, .10, .44, 1), rgb(.39, .58, .93, 1), rgb(1.0, .39, .28, 1)))

# TASK: Modify the above code to make all of your points 50% transparent.
ggplot(data=mpgSubset, aes(x=cty, y=hwy, color=class)) +
  geom_jitter() +
  scale_color_manual(values=c(rgb(.10, .10, .44, 0.5), rgb(.39, .58, .93, 0.5), rgb(1.0, .39, .28, 0.5)))
# There are so many inventive and artistic people in the world who have expanded
# the offerings for colors in ggplot. Check out some notable ones listed below
# when choosing colors for this assignment.
### Color-blind friendly palettes: https://github.com/JLSteenwyk/ggpubfigs
### Color palettes from vintage National Parks posters: https://github.com/katiejolly/nationalparkcolors
### Color palettes based on Wes Anderson movies: https://github.com/karthik/wesanderson
### Color palettes from famous Dutch paintings: https://github.com/EdwinTh/dutchmasters


# ---------------------------------------------------------- #
#### 1.2 DETOUR! LEGENDS                                  ####
# ---------------------------------------------------------- #

# When you specify colors in your ggplot code, R throws in a bonus legend for free!
# However, this legend is often not as clear or visually appealing as we might 
# prefer. But as with all geometric objects in ggplot, legends can be easily altered.

# Run the following code to create a scatter plot. Feel free to modify the colors
# as you prefer!
ggplot(data=mpgSubset, aes(x=cty, y=hwy, color=class)) +
  geom_jitter()

# QUESTION: Where did ggplot get the legend title and values from?
#The axis titles came from the labeled values in code 'x' and 'y' and the legend came from the 'class' in the code.

# We could change the title and values in our legend by altering the dataframe
# we are passing into ggplot. But that seems a bit drastic. Instead, we can 
# lean on the same code that specifies our color picks to alter the legend text.
# Try it out by running the following code:
ggplot(data=mpgSubset, aes(x=cty, y=hwy, color=class)) + #This line is making a scatterplot based on the ones above and labeling the axis and legend.
  geom_jitter() + 
  scale_color_manual(values=c('#FCBA03', '#380754', '#496916'),#This is assigning the color values to the different values in the legend.
                     name='Class of Car', #Labels the name of the legend.
                     breaks=c('suv', 'midsize', 'compact'), #Identifies the breaks in the graph
                     labels=c('SUV', 'Midsize', 'Compact'))#Labels the names of the values in the legend.


# TASK: Label each line of the code above with what it is doing.
# HINT: Check the scale_color_manual help file or ggplot Cookbook for more info.


# IMPORTANT: It is important to pay attention to the order you provide ggplot with 
# your color choices and legend labels! Try running the following code:
ggplot(data=mpgSubset, aes(x=cty, y=hwy, color=class)) + 
  geom_jitter() + 
  scale_color_manual(values=c('#FCBA03', '#380754', '#496916'), 
                     name='Class of Car', 
                     breaks=c('suv', 'midsize', 'compact'), 
                     labels=c('Compact', 'SUV', 'Midsize'))


# QUESTION: What is wrong with the code above? Why is it so important to be
# careful with the order you pass information into ggplot?
#The labels in the last line of code are out of order. It is important to be careful because when we are analyzing the data it may not be interpreted correctly because they are not labeled correctly.

# While changing the legend text and factor order takes place in the scale_color_manual
# step, moving the legend around on the graph page is part of the graph theme. We
# can try this out using the code below:
ggplot(data=mpgSubset, aes(x=cty, y=hwy, color=class)) + 
  geom_jitter() + 
  theme(legend.position='top')


# TASK: Modify the code above to have the legend display along the bottom of
# the figure.
ggplot(data=mpgSubset, aes(x=cty, y=hwy, color=class)) + 
  geom_jitter() + 
  theme(legend.position='bottom')

# We can also have the legend located within the area of the graph itself! We can 
# do this by specifying the coordinates for where the legend should go within the
# graph axes. First we set the legend position and then we set the anchoring 
# position by justifying the legend.
### bottom left: 0,0
### bottom right: 1,0
### top left: 0,1
### top right: 1,1

# Try it out by running the following code:
ggplot(data=mpgSubset, aes(x=cty, y=hwy, color=class)) + 
  geom_jitter() + 
  theme(legend.position=c(1,0), legend.justification = c(1,0))

# QUESTION: What happens if you don't include the code for legend justification
# above?
#If you do not include the code for the legend justfication, it doesn't work

# TASK: Copy and paste the code from above. Modify it to place the legend in the
# upper left part of the graph.
ggplot(data=mpgSubset, aes(x=cty, y=hwy, color=class)) + 
  geom_jitter() + 
  theme(legend.position=c(0,1), legend.justification=c(0,1))

# Finally, we might want to remove the legend altogether! We would do so by
# modifying the theme as well. 

# TASK: Check the ggplot cookbook to find the legends section. Read what it says 
# about removing the legend. Then copy and paste the graph code from above. Modify
# the code to remove the legend.
mpgSub <- ggplot(data=mpgSubset, aes(x=cty, y=hwy, color=class)) + 
  geom_jitter() + 
  theme(legend.position=c(0,1), legend.justification=c(0,1))
mpgSub+theme(legend.position="none")

# ---------------------------------------------------------- #
#### 2.0 DEVIATION                                        ####
# ---------------------------------------------------------- #

# Used to compare variation in values between small number of items (or categories) 
# with respect to a fixed reference.

# Whether the graphical type is a deviation graph or a composition graph (or a 
# ranking graph) may depend on the underlying data structure.

# We used geom_bar() last week with factor data to create a bar graph. But
# geom_bar() is a bit tricky because it can make EITHER a bar graph or a histogram
# depending on the data you give it. The default of geom_bar() is to set stat to 
# count so if you give it just a continuous x value, it will make a histogram. Try
# it with the following code:
ggplot(data=mpg, aes(x=hwy)) + 
  geom_bar()

# In order to have the geom create bars and not a histogram, you must:
# 1) Set stat = identity
# 2) Provide both an x and a y inside the aes(), where x is either a character 
# or factor and y is numeric.

# TASK: Create a dataframe of summary statistics for the mpg data, calculating the
# mean, standard deviation, and standard error for highway mpg grouping by class.
# Name the resulting dataframe highwayMPG and your new variables hwy_mean, hwy_sd,
# and hwy_se.
# HINT: Look back at the Transform assignment if you forget how to summarize the
# data. Also recall, standard error = 1.96*standard deviation.
highwayMPG <- mpg %>%
  group_by(class) %>%
  summarise(hwy_mean = mean(hwy),
            hwy_sd = sd(hwy),
            hwy_se = 1.96 * (hwy_sd / sqrt(n())))

# TASK: Create a bar graph showing the average highway MPG on the y-axis and 
# car class on the x-axis. Fill the bars by class. Add in error bar caps that are 20%
# the width pf the bars.
# HINT: Don't forget to change stat from the default in your geom_bar() statement!
ggplot(data = highwayMPG, aes(x = class, y = hwy_mean, fill = class)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.7) +
  geom_errorbar(aes(ymin = hwy_mean - hwy_se, ymax = hwy_mean + hwy_se),
                position = position_dodge(width = 0.7), width = 0.2) +
  scale_fill_manual(values = c("#34b7eb", "#eb34e5", "#496916","#eb7023","#eb23b9","#23eb3a","#1be9f7")) +
  labs(x = "Car class", y = "Average highway MPG") +
  theme_classic()

# ---------------------------------------------------------- #
#### 2.1 DETOUR! COLORS AND LEGENDS, AGAIN                ####
# ---------------------------------------------------------- #

# Recall that some geometric elements require fills instead of (or sometimes in
# addition to) colors.

# TASK: Create a bar graph with the mpg summary stats with the following parameters:
# (1) Black bar outline
# (2) Bars filled with the color brewer palette "Dark2" using the scale_fill_manual
#     statement
# (3) No legend
# (4) Informative x- and y-axis labels. 

# HINT: Carefully consider whether your color and/or fill should go within an aes() 
# statement, the scale_fill_manual or scale_color_manual statements, or neither.
# If in doubt, try a bunch of ways until it looks how we want it. And consult 
# your helpful ggplot resources on the web.
library(RColorBrewer)
colors <- brewer.pal(7, "Dark2")

ggplot(highwayMPG, aes(x=class, y=hwy_mean, fill=class)) +
  geom_bar(stat="identity", color="black") +
  scale_fill_manual(values=colors) +
  labs(x="Car class", y="Average highway MPG") +
  theme_classic() +
  theme(axis.text.x = element_text(angle=45, vjust=0.5, hjust=1),
        legend.position = "none")

# ---------------------------------------------------------- #
#### 2.2 DETOUR! AXIS MODIFICATIONS                       ####
# ---------------------------------------------------------- #

# Run the following code, feeling free to modify colors as you prefer:
ggplot(data=highwayMPG, aes(x=class, y=hwy_mean, fill=class)) +
  geom_bar(stat='identity')

# QUESTION: Where is ggplot getting the x-axis tick labels from?
#The ggplot is getting the x-axis labels from the legend where it lists out the labels.

# Often our tick labels are not the best. We can modify them to be more informative
# or visually appealing by directly modifying the dataframe, but again this feels
# a bit extreme. Instead, we can directly modify the scale of the axis. For axes
# that deal with categories, we are setting the discrete scale. Try it out by
# running the following code:
ggplot(data=highwayMPG, aes(x=class, y=hwy_mean, fill=class)) +
  geom_bar(stat='identity') +
  scale_x_discrete(labels=c('sport', 'compact', 'midsize', 'minivan', 'pickup', 'subcompact', 'SUV'))

# We can also change the scale of the continuous axes, including how large they are
# and where the tick marks fall as follows:
ggplot(data=highwayMPG, aes(x=class, y=hwy_mean, fill=class)) +
  geom_bar(stat='identity') +
  scale_y_continuous(breaks=seq(0, 50, 10)) +
  coord_cartesian(ylim=c(0,50))

# QUESTION: Try running the code above without the coord_cartesian() statement. 
# What is surprising about the resulting graph? Based on this result, what do you
# think the coord_cartesian() statement does?
#Without the coord_cartesian function the bars on the bar graph became taller. I believe the coord_cartesian function sets limits for the y-axis because it changed the height of the bars.

# We can also add a statement into the scale discrete or continuous statements
# to name our axes, rather than putting in a whole separate step of xlab() or ylab().
# Try it out with the following code:
ggplot(data=highwayMPG, aes(x=class, y=hwy_mean, fill=class)) +
  geom_bar(stat='identity') +
  scale_x_discrete(name='Class of Car') +
  scale_y_continuous(name='Mean Highway MPG')


# Finally, we can flip our axes easily in ggplot as follows:
ggplot(data=highwayMPG, aes(x=class, y=hwy_mean, fill=class)) +
  geom_bar(stat='identity') +
  coord_flip()


# TASK: Let's put it all together. Make a graph of the mpg summary stats with the
# following specifications:
# (1) color by class of car using a color scheme of your choice (not the default)
# (2) plot the class of car on the x-axis and the highway MPG on the y axis
# (3) include better names for the x- and y-axis titles
# (4) include better names for the car classes
# (5) set the scale of the highway mpg to run from 0 to 30 with breaks every 5 
# (6) flip your axes
# (7) remove the legend
mpg_summary <- mpg %>% 
  group_by(class) %>% 
  summarise(hwy_mean = mean(hwy),
            hwy_sd = sd(hwy),
            hwy_se = hwy_sd / sqrt(n()))

ggplot(data = mpg_summary, aes(x=fct_reorder(class, hwy_mean), y=hwy_mean, fill=class)) +
  geom_bar(stat = "identity", color = "black") +
  scale_fill_brewer(palette = "Paired") +
  labs(x = "Car Class", y = "Highway MPG") +
  scale_y_continuous(limits = c(0, 30), breaks = seq(0, 30, 5)) +
  coord_flip() +
  theme(legend.position = "none") +
  scale_x_discrete(labels = c("Subcompact", "Compact", "Midsize", "Large", "SUV", "Truck"))

# ---------------------------------------------------------- #
#### 3.0 RANKING                                          ####
# ---------------------------------------------------------- #
# Used to compare the position or performance of multiple items with respect to 
# each other. Actual values matters somewhat less than the ranking.

# TASK: Create a dataframe of summary statistics for the mpg data, calculating the
# mean, standard deviation, and standard error for CITY mpg grouping by class.
# Name the resulting dataframe cityMPG and your new variables city_mean, city_sd,
# and city_se.
# HINT: Look back at the Transform assignment if you forget how to summarize the
# data. Also, standard error = 1.96*standard deviation.


# Now we want to plot our data in order from smallest to largest city MPG to get
# a ranking. To do so, we need to use the reorder() function to rearrange the data
# going into our x-axis.
ggplot(cityMPG, aes(x=reorder(class, city_mean), y=city_mean)) + 
  geom_bar(stat="identity")

# TASK: Recreate the above ranking figure to include the following:
# (1) class of car on the x-axis with informative axis and tick labels
# (2) MPG ordered from highest to lowest (hint: try google if you're unsure)
# (3) bars with dary grey outlines and filled by class with your favorite color scheme
# (4) error bars with end caps 30% the width of the bars
# (5) y-axis from 0 to 30 with tick marks every 5
# (6) no legend.


# ---------------------------------------------------------- #
#### 4.0 DISTRIBUTION                                     ####
# ---------------------------------------------------------- #
# When you have lots and lots of data points and want to study where and how the
# data points are distributed.

# Histograms can be accomplished with either geom_bar() or geom_histogram()
ggplot(mpg, aes(hwy)) + 
  geom_histogram()

# TASK: Recreate the graph above, but using geom_bar() instead


# TASK: Try making a histogram with the categorical variable 'manufacturer'.
# What error message do you get?


# QUESTION: What happens when you follow the advice of the error message and 
# make stat='count'?
ggplot(mpg, aes(manufacturer)) + 
  geom_histogram(stat="count")


# TASK: Make a boxplot comparing the distribution of cty (city mileage) for
# each class of car.
# HINT: Look back to last week if you forget how to make a boxplot.


# We can also make a different type of distribution, a violin plot using the 
# geom_violin statement as follows:
ggplot(mpg, aes(x=class, y=cty)) + 
  geom_violin()

# QUESTION: What does a violin plot show? Check google if you're unsure.


# ---------------------------------------------------------- #
#### 5.0 COMPOSITION                                      ####
# ---------------------------------------------------------- #
# Bar charts and pie charts are classic ways of showing composition of a dataset.

# TASK: Let's get some data for this task by determining the number of cars from 
# each car manufacturer in our mpg dataframe. We can do this as follows:
manufacturerFreq <- mpg %>% 
  group_by(manufacturer) %>% 
  summarize(frequency=length(manufacturer)) %>% 
  ungroup()

# TASK: Make a bar graph of the number of cars (frequency) by manufacturer using
# the dataframe we created above.


# We can switch the bar chart you created above into a pie chart simply by changing
# the coordinate system through a series of steps as follows:

ggplot(manufacturerFreq, aes(x=manufacturer, y=frequency)) +
  geom_bar(stat="identity") +
  coord_polar()

ggplot(manufacturerFreq, aes(x=manufacturer, y=frequency, fill=manufacturer)) +
  geom_bar(stat="identity") +
  coord_polar()

ggplot(manufacturerFreq, aes(x="", y=frequency, fill=manufacturer)) +
  geom_bar(stat="identity", width=1) +
  coord_polar()

ggplot(manufacturerFreq, aes(x="", y=frequency, fill=manufacturer)) +
  geom_bar(stat="identity", width=1) +
  coord_polar(theta="y")

ggplot(manufacturerFreq, aes(x="", y=frequency, fill=manufacturer)) +
  geom_bar(stat="identity", width=1) +
  coord_polar(theta="y", start=0) +
  theme_void() +
  theme(legend.title = element_text(size = 12.5), 
        legend.text  = element_text(size = 8.5),
        legend.key.size = unit(.75, "lines"))

# TASK: Annotate the code below to describe what each line does:
ggplot(manufacturerFreq, aes(x="", y=frequency, fill=manufacturer)) +
  geom_bar(stat="identity", width=1) +
  coord_polar(theta="y", start=0) +
  theme_void() +
  theme(legend.title = element_text(size = 12.5), 
        legend.text  = element_text(size = 8.5),
        legend.key.size = unit(.75, "lines"))


# ---------------------------------------------------------- #
#### 6.0 CHANGE                                           ####
# ---------------------------------------------------------- #

# Time series are often best visualized with line graphs. Let's try this out
# with some new data:
data("economics")

# TASK: Use the economics dataset to plot the number of people who are unemployed
# over time (unemploy vs date). Make a scatterplot, then connect the points with 
# lines using geom_line().
# HINT: use ?economics to get more information about this dataset.




# ---------------------------------------------------------- #
#### GROUPS AND MAPS                                      ####
# ---------------------------------------------------------- #

# Let's save these for group project options, this assignment is really long!









# REMEMBER: Save and push your script when you're done with this assignment!
