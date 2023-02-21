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


# TASK: Write code below to set your theme to black and white and both your major
# AND minor gridlines to element_blank for all plots you'll be making today.
# HINT: Check back to last week's assignment section 1.9 for setting themes for
# all plots.


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


# Looks alright, but the graph may be hiding some information...
# QUESTION: How many data points are in the mpg dataframe?


# QUESTION: Approximately how many dots are in the graph you just made? How does
# that compare to the number of observations in the dataframe?


# Try another correlation-focused geom that addresses this problem by running
# the following code:
ggplot(data=mpg, aes(x=cty, y=hwy)) + 
  geom_jitter()


# QUESTION: What happened when you created the plot with geom_jitter?


# QUESTION: Run the code to create a plot using geom_jitter a second time. Then run it
# again and again. What happens each time? Why is this happening?


# TASK: The default in geom_jitter is to jitter (or slightly move) the points away
# from each other in both the x and y directions. Check the help file for geom_jitter
# and write code below to make a graph where you jitter points in only the x-dimension
# by 0.5.


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


# QUESTION: How do you think you could figure out which color name belongs to
# each color number?
# HINT: Try creating a dataframe from color() by passing it into the
# as.data.frame() function.


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


# QUESTION: What happened to the point that you set to 100% transparent?


# Finally, we can set our colors using the rgb() function. This operates very
# similarly to the hex code, where you can pick exactly the color and transparency
# you want. Try it out by running the following code:
ggplot(data=mpgSubset, aes(x=cty, y=hwy, color=class)) +
  geom_jitter() +
  scale_color_manual(values=c(rgb(.10, .10, .44, 1), rgb(.39, .58, .93, 1), rgb(1.0, .39, .28, 1)))

# TASK: Modify the above code to make all of your points 50% transparent.

# There are so many inventive and artistic people in the world who have expanded
# the offerings for colors in ggplot. Check out some notable ones listed below
# when choosing colors for this assignment.
### Color-blind friendly palettes: https://github.com/JLSteenwyk/ggpubfigs
### Color palettes from vintage National Parks posters: https://github.com/katiejolly/nationalparkcolors
### Color palettes based on Wes Anderson movies: https://github.com/karthik/wesanderson
### Color palettes from famous Dutch paintings: https://github.com/EdwinTh/dutchmasters




# REMEMBER: Save and push your script when you're done with this assignment!