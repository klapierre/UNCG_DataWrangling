# --------------------------------------------------------------------------- #
####                         Welcome to GGanimate!                         ####
# --------------------------------------------------------------------------- #

## Let's get familiar with what GGanimate can actually do - but first, let's go
## ahead and set up our workspace.

install.packages('gganimate')
install.packages("gifski")
library(tidyverse)
library(gganimate)
library(gifski)

## Now that that's done, let's make a graph! We're going to use an embedded set 
## of data called 'iris' - you may remember this dataset from previous classes!

## Go ahead and load 'iris' in!

data("iris")

## Graph time! Let's plot species by petal length - this dataset describes 3
## different species of iris by their petal and sepal lengths/widths, so we're 
## going to try to visualize it and see the lengths of each of their petals!

## Let's use a box and whisker plot for this, and color by species.

ggplot(iris, aes(x = Species, y = Petal.Length)) +
  geom_boxplot(aes(color = Species))

## If at anytime you want more info on GGanim, try this function to pull up the
## help page embedded in R: ?`gganimate-package`

## So now we have a stagnant graph - let's add some flare to it! Annotate the 
## different aspects of this graph and try to explain what each argument is for.

## Hint: Check the GGanimate help page, or the GGanimate website!
## (https://gganimate.com/articles/gganimate.html)

ggplot(iris, aes(x = Species, y = Petal.Length)) +   ## Graphs by species & petal length.
  geom_boxplot(aes(colour = Species)) +              ## Colors by Seed.
  transition_states(Petal.Width,                     ## Animates by age.
                    transition_length = 1,           ## Distance between frames.
                    state_length = 1)                ## Time to 'pause' on frames.

## TASK: Play with the values for transition_length and state_length - what's 
## changing? Was this different from what you thought when you were annotating?

ggplot(iris, aes(x = Species, y = Petal.Length)) + 
  geom_boxplot(aes(colour = Species)) +
  transition_states(Petal.Width,
                    transition_length = 4,           ## So long as these are
                    state_length = 2)                ## changed, it's correct.

## ANSWER: As above.

## Hmm... This graph is interesting, but it doesn't really give us a ton of info
## at first glance. Why don't we try and add some labels for our x and y axis,
## and a title for our chart?

ggplot(iris, aes(x = Species, y = Petal.Length)) +
  geom_boxplot(aes(color = Species)) + 
  transition_states(Petal.Width,
                    transition_length = 1,
                    state_length = 1) +
  labs(x = "Species", y = "Petal Length (cm)", subtitle = "Currently Showing Petal Width {closest_state} (cm)", title = "Iris Petal Length by Width per Species")

## HINT: If you can't get your graph to  look right at first, try just changing
## the graph without the transition states, so the process goes a little faster.

## Let's also add in a fun transition using the enter and exit arguments (just 
## like in PowerPoint!) to get more familiar wth the other functions of gganimate.

ggplot(iris, aes(x = Species, y = Petal.Length)) +
  geom_boxplot(aes(color = Species)) + 
  transition_states(Petal.Width,
                    transition_length = 1,
                    state_length = 1) +
  labs(x = "Species", 
       y = "Petal Length (cm)", 
       subtitle = "Currently Showing Petal Width {closest_state} (cm)", 
       title = "Iris Petal Length by Width per Species") +
  enter_fade() + 
  exit_fade()

## So now we have a cute little graph, showing the relationship between petal
## length and width by species. But how would we share this graph with other
## researchers, or put it into a presentation? We have to save it as a file!

## To do this we need to use some more new grammar - ggsave!

## First, assign your graph a name and save it into R.

babygraph <- ggplot(iris, aes(x = Species, y = Petal.Length)) +
  geom_boxplot(aes(color = Species)) + 
  transition_states(Petal.Width,
                    transition_length = 1,
                    state_length = 1) +
  labs(x = "Species", 
       y = "Petal Length (cm)", 
       subtitle = "Currently Showing Petal Width {closest_state} (cm)", 
       title = "Iris Petal Length by Width per Species") +
  enter_fade() + 
  exit_fade()

## Now that it's saved, we can use the animate() function - using gifski as our
## renderer. Use the ?animate to learn some of the other functions, but for our
## purposes you just need to use the graph name and the renderer.

## HINT: Check out babytestfile.R in the original branch for an example, and 
## ?animate for more help with the package.

babyanim <- animate(babygraph, renderer = gifski_renderer())

## Finally, we need to save the animation to our computer. Gganimate defaults to
## using the last animation, so we don't need to select it. Use anim_save() for
## this, and check out ?anim_save for more help. (Or, babytestfile.R!)

anim_save('filename.gif', animation = last_animation(), path = NULL)

## Enjoy your little .gif! Now let's move onto something a little spicier...