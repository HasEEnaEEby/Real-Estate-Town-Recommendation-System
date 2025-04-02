# Load necessary libraries
library(dplyr)
library(readr)

# Set working directory to where the population dataset is located
setwd("~/Documents/DataScience/Obtain_Data/Datasets/")

# Load the population dataset
population_data <- read_csv("population2011.csv")

# Clean the Population column by removing commas and converting to numeric
population_data <- population_data %>%
  mutate(Population = as.numeric(gsub(",", "", Population)))

# Convert Population2011 to Population2023 using the provided formula
population_data <- population_data %>%
  mutate(Population2023 = 1.00561255390388033 * Population)

# Optional: Inspect the updated data
head(population_data)
summary(population_data)

# Save the updated dataset with Population2023 in the Cleaned_Data folder
write_csv(population_data, "~/Documents/DataScience/Cleaned_Data/population2023_cleaned.csv")

# End of Script
