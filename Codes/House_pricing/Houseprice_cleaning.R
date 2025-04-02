# Load the required libraries
library(dplyr)

# Set working directory to the Housing folder (if needed)
setwd("~/Documents/DataScience/Obtain_Data/Datasets/Housing")

# Load the datasets
data_2020 <- read.csv("pp-2020.csv", header = FALSE)
data_2021 <- read.csv("pp-2021.csv", header = FALSE)
data_2022 <- read.csv("pp-2022.csv", header = FALSE)
data_2023 <- read.csv("pp-2023.csv", header = FALSE)

# Concatenate all datasets
house_data <- bind_rows(data_2020, data_2021, data_2022, data_2023)

View(house_data)
summary(house_data)

# Select relevant columns
relevant_columns <- c("V2", "V3", "V4", "V5", "V12", "V14")
house_data <- house_data[, relevant_columns]


# Rename the columns
colnames(house_data) <- c("price", "date_of_transfer", "postcode", "property_type", "town_city", "county")

# Convert date column to Date type
house_data$date_of_transfer <- as.Date(house_data$date_of_transfer, format = "%Y-%m-%d")  # Adjusted format

# Convert price column to numeric
house_data$price <- as.numeric(house_data$price)

# Filter data for Bristol and Cornwall
house_data <- house_data %>%
  filter(county == "CITY OF BRISTOL" | county == "CORNWALL")

# Remove rows with missing values
house_data <- na.omit(house_data)

# Remove duplicate rows
house_data <- house_data[!duplicated(house_data), ]

# View the cleaned data
print(head(house_data))
print(summary(house_data))

# Save the cleaned dataset in the Cleaned_Data folder
write.csv(house_data, "~/Documents/DataScience/Cleaned_Data/cleaned_house_Pricing.csv", row.names = FALSE)

View(house_data)
