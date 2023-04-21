# --------------------------------------------------------------------------- #
####                         Welcome to GGanimate!                         ####
# --------------------------------------------------------------------------- #

## Let's get familiar with what GGanimate can actually do - but first, let's go
## ahead and set up our workspace.

install.packages('gganimate')
library(tidyverse)
library(gganimate)

## Now that that's done, let's make a graph! We're going to use an embedded set 
## of data called 'Loblolly' - you may remember this dataset from previous classes!

## Go ahead and load 'Loblolly' in!

data("Loblolly")

## Graph time! Let's plot seed # by height - this dataset describes different 
## Loblolly pine seedlings by their age (years) and heights (feet), so we're 
## going to try to visualize it and see these little seeds grow over time!

ggplot(Loblolly, aes(x = Seed, y = height)) + 
  geom_point(aes(colour = Seed))

## If at anytime you want more info on GGanim, try this function to pull up the
## help page embedded in R: ?`gganimate-package`

## So now we have a stagnant graph - let's add some flare to it! Annotate the 
## different aspects of this graph and try to explain what each argument is for.

## Hint: Check the GGanimate help page, or the GGanimate website!
## (https://gganimate.com/articles/gganimate.html)

ggplot(Loblolly, aes(x = Seed, y = height)) +        ## Graphs by Seed & height.
  geom_point(aes(colour = Seed)) +                   ## Colors by Seed.
  transition_states(age,                             ## Animates by age.
                    transition_length = 2,           ## Distance between frames.
                    state_length = 1)                ## Time to 'pause' on frames.

## TASK: Play with the values for transition_length and state_length - what's 
## changing? Was this different from what you thought when you were annotating?

ggplot(Loblolly, aes(x = Seed, y = height)) + 
  geom_point(aes(colour = Seed)) +
  transition_states(age,
                    transition_length = 4,           ## So long as these are
                    state_length = 2)                ## changed, it's correct.

## ANSWER: As above.

## Hmm... This graph is interesting, but it doesn't really give us a ton of info
## at first glance. Why don't we try and add some labels for our x and y axis,
## and a title for our chart?

## Hint: What are each of the variables in the dataset telling us?

ggplot(Loblolly, aes(x = Seed, y = height),
       xlab = "Loblolly Seed ID",
       ylab = "Seedling Height (Feet)",  
       main = "Loblolly Seed Height Over 22 Years") +
  geom_point(aes(colour = Seed)) + 
  transition_states(age,
                    transition_length = 2,
                    state_length = 1) ## Lmaooo not working, need to fix.

## Let's also add in a fun transition (just like in PowerPoint!) just for sillies.

ggplot(Loblolly, aes(x = Seed, y = height),
       xlab = "Loblolly Seed ID",
       ylab = "Seedling Height (Feet)",  
       main = "Loblolly Seed Height Over 22 Years") +
  geom_point(aes(colour = Seed)) + 
  transition_states(age,
                    transition_length = 2,
                    state_length = 0) +
  enter_fade() + 
  exit_shrink()                       ## Not working either. Fix.

## So now we have a cute little graph, showing that each of our seeds is growing
## at about the same rate with some informative labeling. But how would we share
## this with someone? We need to save it as a file!

## To do this we need to use some more new grammar - ggsave!

## Ggsave example.

## Enjoy your little .gif! Now let's move onto something a little spicier...