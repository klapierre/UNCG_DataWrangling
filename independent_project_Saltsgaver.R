install.packages("tidyverse")
install.packages("dplyr")
install.packages("janitor")
install.packages("lubridate")
install.packages("ggplot")
library(tidyverse)
library(dplyr)
library(janitor)
library(lubridate)
library(ggplot2)

Egg_Count_Control <- read.csv("C:/Users/nsalt/Documents/DataWrangling/UNCG_DataWrangling/Gonotrophic_Results_Data(Egg_Approximate_Count_Control).csv") 

Egg_Count_Control_Transform <- as.data.frame(t(Egg_Count_Control))

Egg_Count_Control_Clean <- Egg_Count_Control_Transform %>%
  subset(select = -c(V26:V46)) %>%
  subset(select = -c(V4,V18)) %>%
  slice(-(2:5)) %>%
  slice(-(22:61)) %>%
  mutate(across(everything(), ~ if_else(row_number() == 1, str_c(., "CG"), as.character(.)))) %>%
  janitor::row_to_names(row_number=1)

Egg_Count_Treatment <- read.csv("C:/Users/nsalt/Documents/DataWrangling/UNCG_DataWrangling/Gonotrophic_Results_Data(Egg_Approximate_Count_Treatment).csv")

Egg_Count_Treatment_Transform <- as.data.frame(t(Egg_Count_Treatment))

Egg_Count_Treatment_Clean <- Egg_Count_Treatment_Transform %>%
  subset(select = -c(V26:V41)) %>%
  subset(select = -c(V8,V11,V16,V21,V25)) %>%
  slice(-(2:5)) %>%
  slice(-(34:61)) %>%
  mutate(across(everything(), ~ if_else(row_number() == 1, str_c(., "TG"), as.character(.)))) %>%
  janitor::row_to_names(row_number=1)

Egg_Count_Merged <- merge(Egg_Count_Control_Clean, Egg_Count_Treatment_Clean, by=0, all=TRUE)

Egg_Count_Merged_Clean <- Egg_Count_Merged %>%
  mutate(
    across(
      .cols = Row.names,
      .fns = ~ str_remove(.x, "^X\\.?") %>%
        str_replace_all("[._]", "-") %>%
        mdy(quiet = TRUE)
    )
  ) %>%
  arrange(Row.names) %>%
  fill(2:24,.direction="down") %>%
  rename(Date=Row.names) %>%
  mutate(across(2:44, as.numeric))

Egg_Timing_Control_Clean <- Egg_Count_Control_Transform %>%
  subset(select = -c(V26:V46)) %>%
  subset(select = -c(V2,V4,V18,V20)) %>%
  slice(-(6:66)) %>%
  mutate(across(everything(), ~ if_else(row_number() == 1, str_c(., "CG"), as.character(.)))) %>%
  janitor::row_to_names(row_number=1)

Egg_Timing_Treatment_Clean <- Egg_Count_Treatment_Transform %>%
  subset(select = -c(V26:V41)) %>%
  subset(select = -c(V4,V8,V11,V16,V18,V21,V25)) %>%
  slice(-(6:66)) %>%
  mutate(across(everything(), ~ if_else(row_number() == 1, str_c(., "TG"), as.character(.)))) %>%
  janitor::row_to_names(row_number=1)

Egg_Timing_Merged <- merge(Egg_Timing_Control_Clean, Egg_Timing_Treatment_Clean, by=0, all=TRUE)

Egg_Timing_Merged$Row.names <- gsub("\\.", "_", Egg_Timing_Merged$Row.names)

Egg_Timing_Merged_Clean <- Egg_Timing_Merged %>%
  rename(Statistic = Row.names) %>%
  mutate(across(2:40, as.numeric))

remove(Egg_Count_Control,Egg_Count_Control_Clean,Egg_Count_Control_Transform,Egg_Count_Merged,Egg_Count_Treatment,Egg_Count_Treatment_Clean,Egg_Count_Treatment_Transform,Egg_Timing_Control_Clean,Egg_Timing_Treatment_Clean,Egg_Timing_Merged)

Egg_Statistics <- Egg_Count_Merged_Clean %>%
  slice(32) %>%
  subset(select=-c(Date)) %>%
  mutate(
    Control_Avg = rowMeans(across(c(1:23)), na.rm = TRUE),
    Treatment_Avg = rowMeans(across(c(24:43)), na.rm = TRUE),
    Control_SE = sd(across(c(1:23))),
    Treatment_SE = sd(across(c(24:43))),
    Control_SE = Control_SE/sqrt(23),
    Treatment_SE = Treatment_SE/sqrt(20)
  ) %>%
  subset(select=c(Control_Avg,Treatment_Avg,Control_SE,Treatment_SE)) %>%
  pivot_longer(
    everything(),
    names_to = c("stat", "group"),
    names_sep = "_",
    values_to = "value"
  ) %>%
  pivot_wider(
    names_from = group,
    values_from = value
  ) %>%
  mutate(stat = ifelse(stat == "avg", "Average", "Std.Error")) %>%
  as.data.frame(t) %>%
  rename(
    Treatment_Group = stat,
    Average = Avg,
    Std_Error = SE)

Egg_Statistics[1,1] <- gsub("Std.Error","26°C",Egg_Statistics[1,1])
Egg_Statistics[2,1] <- gsub("Std.Error","30°C",Egg_Statistics[2,1])

ggplot(Egg_Statistics, aes(x=Treatment_Group,y=Average)) +
  geom_bar(stat = "identity",
           fill = "royalblue2",
           width = 0.5,
           color = "black") +
  geom_errorbar(aes(ymin=Average-Std_Error,
                    ymax=Average+Std_Error),
                width=0.2,
                linewidth=0.8) +
  labs(title = "Average Number of Eggs Laid per Female by Treatment Group",
       x = "Treatment Group",
       y = "Average Number of Eggs Laid") +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(hjust = 0.9, face = "bold"),
    axis.title.x = element_text(face = "bold"),
    axis.title.y = element_text(face = "bold"),
    panel.grid.major.x = element_blank()
  )

ggsave("Number_of_Eggs.png")

Egg_Time_Statistics <- Egg_Timing_Merged_Clean %>%
  mutate(
    Control_Avg = rowMeans(across(c(2:22)), na.rm = TRUE),
    Treatment_Avg = rowMeans(across(c(23:40)), na.rm = TRUE),
    Control_SE = sd(c_across(2:22), na.rm = TRUE),
    Treatment_SE = sd(c_across(23:40), na.rm = TRUE),
    Control_SE = Control_SE/sqrt(21),
    Treatment_SE = Treatment_SE/sqrt(18)
  ) %>%
  subset(select=c(Statistic,Control_Avg,Treatment_Avg,Control_SE,Treatment_SE)) 

Time_to_Death_Stat <- Egg_Time_Statistics %>%
  slice(1) %>%
  subset(select=-c(Statistic)) %>%
  pivot_longer(
    everything(),
    names_to = c("stat", "group"),
    names_sep = "_",
    values_to = "value"
  ) %>%
  pivot_wider(
    names_from = group,
    values_from = value
  ) %>%
  rename(
    Treatment_Group = stat,
    Average = Avg,
    Std_Error = SE
  )

Time_to_Death_Stat[1,1] <- gsub("Control","26°C",Egg_Statistics[1,1])
Time_to_Death_Stat[2,1] <- gsub("Treatment","30°C",Egg_Statistics[2,1])

Time_to_Start_Stat <- Egg_Time_Statistics %>%
  slice(4) %>%
  subset(select=-c(Statistic)) %>%
  pivot_longer(
    everything(),
    names_to = c("stat", "group"),
    names_sep = "_",
    values_to = "value"
  ) %>%
  pivot_wider(
    names_from = group,
    values_from = value
  ) %>%
  rename(
    Treatment_Group = stat,
    Average = Avg,
    Std_Error = SE
  )

Time_to_Start_Stat[1,1] <- gsub("Control","26°C",Egg_Statistics[1,1])
Time_to_Start_Stat[2,1] <- gsub("Treatment","30°C",Egg_Statistics[2,1])

Time_to_Median_Stat <- Egg_Time_Statistics %>%
  slice(2) %>%
  subset(select=-c(Statistic)) %>%
  pivot_longer(
    everything(),
    names_to = c("stat", "group"),
    names_sep = "_",
    values_to = "value"
  ) %>%
  pivot_wider(
    names_from = group,
    values_from = value
  ) %>%
  rename(
    Treatment_Group = stat,
    Average = Avg,
    Std_Error = SE
  )

Time_to_Median_Stat[1,1] <- gsub("Control","26°C",Egg_Statistics[1,1])
Time_to_Median_Stat[2,1] <- gsub("Treatment","30°C",Egg_Statistics[2,1])

Time_to_End_Stat <- Egg_Time_Statistics %>%
  slice(3) %>%
  subset(select=-c(Statistic)) %>%
  pivot_longer(
    everything(),
    names_to = c("stat", "group"),
    names_sep = "_",
    values_to = "value"
  ) %>%
  pivot_wider(
    names_from = group,
    values_from = value
  ) %>%
  rename(
    Treatment_Group = stat,
    Average = Avg,
    Std_Error = SE
  )

Time_to_End_Stat[1,1] <- gsub("Control","26°C",Egg_Statistics[1,1])
Time_to_End_Stat[2,1] <- gsub("Treatment","30°C",Egg_Statistics[2,1])

ggplot(Time_to_Death_Stat, aes(x=Treatment_Group,y=Average)) +
  geom_bar(stat = "identity",
           fill = "royalblue2",
           width = 0.5,
           color = "black") +
  geom_errorbar(aes(ymin=Average-Std_Error,
                    ymax=Average+Std_Error),
                width=0.2,
                linewidth=0.8) +
  labs(title = "Average Time to Death by Treatment Group",
       x = "Treatment Group",
       y = "Days from Collection") +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(hjust = 0.9, face = "bold"),
    axis.title.x = element_text(face = "bold"),
    axis.title.y = element_text(face = "bold"),
    panel.grid.major.x = element_blank()
  )

ggsave("Time_to_Death.png")
  
ggplot(Time_to_Start_Stat, aes(x=Treatment_Group,y=Average)) +
  geom_bar(stat = "identity",
           fill = "royalblue2",
           width = 0.5,
           color = "black") +
  geom_errorbar(aes(ymin=Average-Std_Error,
                    ymax=Average+Std_Error),
                width=0.2,
                linewidth=0.8) +
  labs(title = "Average Time to First Egg Laid by Treatment Group",
       x = "Treatment Group",
       y = "Days from Collection") +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(hjust = 0.9, face = "bold"),
    axis.title.x = element_text(face = "bold"),
    axis.title.y = element_text(face = "bold"),
    panel.grid.major.x = element_blank()
  )

ggsave("First_Egg_Laid.png")

ggplot(Time_to_Median_Stat, aes(x=Treatment_Group,y=Average)) +
  geom_bar(stat = "identity",
           fill = "royalblue2",
           width = 0.5,
           color = "black") +
  geom_errorbar(aes(ymin=Average-Std_Error,
                    ymax=Average+Std_Error),
                width=0.2,
                linewidth=0.8) +
  labs(title = "Average Time to Median Egg Laid by Treatment Group",
       x = "Treatment Group",
       y = "Days from Collection") +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(hjust = 0.9, face = "bold"),
    axis.title.x = element_text(face = "bold"),
    axis.title.y = element_text(face = "bold"),
    panel.grid.major.x = element_blank()
  )

ggsave("Median_Egg_Laid.png")

ggplot(Time_to_End_Stat, aes(x=Treatment_Group,y=Average)) +
  geom_bar(stat = "identity",
           fill = "royalblue2",
           width = 0.5,
           color = "black") +
  geom_errorbar(aes(ymin=Average-Std_Error,
                    ymax=Average+Std_Error),
                width=0.2,
                linewidth=0.8) +
  labs(title = "Average Time to Last Egg Laid by Treatment Group",
       x = "Treatment Group",
       y = "Days from Collection") +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(hjust = 0.9, face = "bold"),
    axis.title.x = element_text(face = "bold"),
    axis.title.y = element_text(face = "bold"),
    panel.grid.major.x = element_blank()
  )

ggsave("Last_Egg_Laid.png")


