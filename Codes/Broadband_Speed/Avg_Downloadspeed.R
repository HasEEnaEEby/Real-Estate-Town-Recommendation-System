# Load required libraries
library(dplyr)
library(ggplot2)
library(tidyr)

# Load the cleaned broadband dataset
broadband_data <- read.csv("~/Documents/DataScience/Cleaned_Data/cleaned_broadband_data.csv")

# 1. Boxplot for Average Download Speeds in Both Counties (Bristol and Cornwall)
ggplot(broadband_data, aes(x = Region_County, y = Average_Download_Speed, fill = Region_County)) +
  geom_boxplot() +
  labs(title = "Distribution of Average Download Speeds in Bristol and Cornwall",
       x = "County",
       y = "Average Download Speed (Mbit/s)") +
  theme_minimal(base_size = 14) +
  scale_fill_manual(values = c("Bristol, City of" = "steelblue", "Cornwall" = "darkorange"))

# 2. Bar Chart of Average and Maximum Download Speeds for Cornwall
broadband_data_cornwall <- broadband_data %>%
  filter(Region_County == "Cornwall") %>%
  summarise(Average_Download_Speed = mean(Average_Download_Speed),
            Maximum_Download_Speed = max(Maximum_Download_Speed))

broadband_data_cornwall_long <- broadband_data_cornwall %>%
  pivot_longer(cols = c(Average_Download_Speed, Maximum_Download_Speed), names_to = "Speed_Type", values_to = "Speed")

ggplot(broadband_data_cornwall_long, aes(x = Speed_Type, y = Speed, fill = Speed_Type)) +
  geom_bar(stat = "identity") +
  labs(title = "Average and Maximum Download Speeds in Cornwall",
       x = "Speed Type",
       y = "Download Speed (Mbit/s)") +
  theme_minimal(base_size = 14) +
  scale_fill_manual(values = c("Average_Download_Speed" = "darkorange", "Maximum_Download_Speed" = "lightblue"))

# 3. Bar Chart of Average and Maximum Download Speeds for Bristol
broadband_data_bristol <- broadband_data %>%
  filter(Region_County == "Bristol, City of") %>%
  summarise(Average_Download_Speed = mean(Average_Download_Speed),
            Maximum_Download_Speed = max(Maximum_Download_Speed))

broadband_data_bristol_long <- broadband_data_bristol %>%
  pivot_longer(cols = c(Average_Download_Speed, Maximum_Download_Speed), names_to = "Speed_Type", values_to = "Speed")

ggplot(broadband_data_bristol_long, aes(x = Speed_Type, y = Speed, fill = Speed_Type)) +
  geom_bar(stat = "identity") +
  labs(title = "Average and Maximum Download Speeds in Bristol",
       x = "Speed Type",
       y = "Download Speed (Mbit/s)") +
  theme_minimal(base_size = 14) +
  scale_fill_manual(values = c("Average_Download_Speed" = "steelblue", "Maximum_Download_Speed" = "lightblue"))
