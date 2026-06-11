# To start off we will be loading some packages.

library(tidyverse)

#This next package will help us uplaod the excel dataset.
library(readxl)

# Now we are gonna let R read our data

bug_data <- read_excel("raw data LZX (2).xlsx")

# Next we are goin to look the data. 

head(bug_data)
glimpse(bug_data)
colnames(bug_data)
summary(bug_data)
colSums(is.na(bug_data))


# I think the columns are kinda confusing to read so we are going to rename them so that they are easier to use

bug_data <- bug_data %>% 
  rename(
    sample_id = Sample ID, 
    total_eggs = Number of total eggs,
    parasitized_eggs = Number of parasitized eggs,
    parasitism_rate = Parasitism rate,
    location = Location,
    pest_management = Pest management category,
    habitat = Surrounding habitat,
    orchard_size = Orchard size (ha)
    )


# To make sure everything was upladed right we are going to run some code to recheck our data
head(bug_data)
colnames(bug_data)

# Now we will remove the missing data 
bug_clean <- bug_data %>%
  drop_na()


# Next we are going to change the parasitism rate into a percentage because its currently stored as a decimal which makes our graphs harder to read.
bug_clean <- bug_clean %>%
  mutate(
    parasitism_percent = parasitism_rate * 100
  )


# Now that we cleaned the data we are going to check it to make sure we did everything right.
head(bug_clean)
summary(bug_clean)
colSums(is.na(bug_clean))

# Next we will be making a table that summarizes the parasitism data for each pest management category.


#First I am going to group the data by pest management 
management_summary <- bug_clean %>%
  group_by(pest_management)
#Then i am going to find the average parasitism rate
management_summary <- management_summary %>%
  summarize(
    mean_parasitism = mean(parasitism_percent),
    sd_parasitism = sd(parasitism_percent),
    n = n()
  )
#Now we are going to calculate the standard error to see how reliable the mean is.
management_summary <- management_summary %>%
  mutate(
    se_parasitism = sd_parasitism / sqrt(n)
  )
#Then we are going to look at our results.
management_summary


# Next we will be doing some grouping by habitat type to see if parasitism rates differ between 
#nature reserves, urban farmland, and  rural farmland

#First we will run a line of code that groups the data by habitat.
habitat_summary <- bug_clean %>%
  group_by(habitat)
#Then we will find the mean, standard deviation and sample size for each habitat type
habitat_summary <- habitat_summary %>%
  summarize(
    mean_parasitism = mean(parasitism_percent),
    sd_parasitism = sd(parasitism_percent),
    n = n()
  )
Then we will calculate standard error.
habitat_summary <- habitat_summary %>%
  mutate(
    se_parasitism = sd_parasitism / sqrt(n)
  )
#And again we are goingto look at our results
habitat_summary


# Now we are going to go in and  summarize the parasitism data for each collectin location.

#Like the other section we are going to Group the data by location.
location_summary <- bug_clean %>%
  group_by(location)
#Then we will calculate average parasitism rate,standard deviation, and sample size for each location.
location_summary <- location_summary %>%
  summarize(
    mean_parasitism = mean(parasitism_percent),
    sd_parasitism = sd(parasitism_percent),
    n = n()
  )
#Then i am going to calculate standard error
location_summary <- location_summary %>%
  mutate(
    se_parasitism = sd_parasitism / sqrt(n)
  )
#and lastly we will check the data.
location_summary


# Now we will be making a graph to see if the pest management category will affect parasitism rate.

#First i want to start the graph by using the pest management summary table that i made earlier.
management_graph <- ggplot(
  management_summary,
#Then we will tell R what to put on the graph.
  aes(x = pest_management,
      y = mean_parasitism,
      fill = pest_management)
)
# Now i am going to add bars to the graph
management_graph <- management_graph +
  geom_col()
#Next I am going to title the graph and add axis labels making it easier to  read.
management_graph <- management_graph +
  labs(
    title = "Parasitism by Pest Management",
    x = "Pest Management",
    y = "Mean Parasitism Rate (%)"
  )
#Now we can look at  the graph
management_graph


#Now we will make the habitat bar graph
#First we are going to graph everything
habitat_graph <- ggplot(
  habitat_summary,
  aes(x = habitat,
      y = mean_parasitism,
      fill = habitat)
)
#Now we are going to add bars to the graph
habitat_graph <- habitat_graph +
  geom_col()
#Now we are going to title the graph
habitat_graph <- habitat_graph +
  labs(
    title = "Parasitism by Habitat",
    x = "Habitat",
    y = "Mean Parasitism Rate (%)"
  )
#Now we will display the graph
habitat_graph


#Now we are gonna make the Orchard size scatter plot
#First we are going to graph everything.
orchard_graph <- ggplot(
  bug_clean,
  aes(x = orchard_size,
      y = parasitism_percent)
)
#Now we are going to add the dots
orchard_graph <- orchard_graph +
  geom_point()
#Now we will add the labes and title
orchard_graph <- orchard_graph +
  labs(
    title = "Orchard Size and Parasitism",
    x = "Orchard Size (ha)",
    y = "Parasitism Rate (%)"
  )
#Now we will display the graph
orchard_graph


# Now we are going to make the last graph which is the location bar graph
#First we are going to graph everything
location_graph <- ggplot(
  location_summary,
  aes(x = location,
      y = mean_parasitism,
      fill = location)
)
#Now we are going to add bars to the graph.
location_graph <- location_graph +
  geom_col()
#Now we are going to title the graph
location_graph <- location_graph +
  labs(
    title = "Parasitism by Location",
    x = "Location",
    y = "Mean Parasitism Rate (%)"
  )
#Now we are going to display the graphs
location_graph



#Lastly we are going to save each of our files as a PNG file

# This will save our first graph titled Parasitism by Pest Management
ggsave("pest_management_graph.png", management_graph)

#This next line of code will save our Parasitism by habitate PNG file
ggsave("habitat_graph.png", habitat_graph)

#This will save the orchard size and parasitism scatter plot as a PNG file
ggsave("orchard_size_graph.png", orchard_graph)

#This will save our final bar graph titled Parasitism by location
ggsave("location_graph.png", location_graph)

#Now We are done.