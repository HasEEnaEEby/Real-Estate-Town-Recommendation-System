# -----------------------------------------------------------------------------
# Data Cleaning and Aggregation Script
# Author: Haseena KC
# Date: August 15
# Description: This script loads, cleans, and aggregates crime data for 
#              Avon and Somerset, and Devon and Cornwall regions.
# -----------------------------------------------------------------------------

# Load necessary libraries
library(dplyr)
library(readr)

# Set working directory to the location of the crimerate folder
setwd("~/Documents/DataScience/Obtain_Data/Datasets/crimerate")

# -----------------------------------------------------------------------------
# Function to clean the data
# -----------------------------------------------------------------------------
clean_data <- function(data) {
  data %>%
    select(Month, `Crime type`, `LSOA code`, `LSOA name`, `Falls within`) %>%  # Keep only key columns
    filter(!is.na(Month) & !is.na(`Crime type`) & !is.na(`LSOA code`) & !is.na(`LSOA name`))  # Ensure no missing values in key columns
}

# -----------------------------------------------------------------------------
# Function to load, clean, and combine data from multiple files for a specific region
# -----------------------------------------------------------------------------
load_and_clean_data <- function(region_pattern) {
  directories <- list.dirs(path = ".", full.names = TRUE, recursive = FALSE)
  data_list <- lapply(directories, function(dir) {
    files <- list.files(dir, pattern = region_pattern, full.names = TRUE)
    cleaned_data_list <- lapply(files, function(file) {
      data <- read_csv(file)
      clean_data(data)
    })
    bind_rows(cleaned_data_list)
  })
  
  combined_data <- bind_rows(data_list)
  return(combined_data)
}

# -----------------------------------------------------------------------------
# Load, clean, and combine data for both regions
# -----------------------------------------------------------------------------
avon_all_data <- load_and_clean_data("avon-and-somerset-street.csv")
devon_all_data <- load_and_clean_data("devon-and-cornwall-street.csv")

# Combine both regions into one dataset
combined_data <- bind_rows(avon_all_data, devon_all_data)

# Optional: Inspect the cleaned data
str(combined_data)
summary(combined_data)
head(combined_data)


# -----------------------------------------------------------------------------
# Aggregate the cleaned data by Month, Crime Type, and LSOA
# -----------------------------------------------------------------------------
aggregate_data <- function(data) {
  data %>%
    group_by(Month, `Crime type`, `LSOA code`, `LSOA name`, `Falls within`) %>%
    summarize(total_crimes = n(), .groups = 'drop')
}

summary_data <- aggregate_data(combined_data)

# Optional: Inspect the cleaned and aggregated data
head(summary_data)

# Uncomment the line below to view data in the RStudio Viewer
View(summary_data)

# -----------------------------------------------------------------------------
# Save the aggregated summary data for further analysis
# -----------------------------------------------------------------------------
summary_output_file <- "~/Documents/DataScience/Cleaned_Data/summary_crime_data.csv"
write_csv(summary_data, summary_output_file)

# End of Script
