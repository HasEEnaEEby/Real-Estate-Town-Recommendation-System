# Load required libraries
library(dplyr)
library(readr)

# Load the Postcode to LSOA dataset
postcode_data <- read_csv("~/Documents/DataScience/Obtain_Data/Datasets/Postcode/Postcode_to_LSOA.csv")

# Inspect the data (optional, for initial exploration)
str(postcode_data)
head(postcode_data)
View(postcode_data)

# Select relevant columns and rename them
postcode_data_cleaned <- postcode_data %>%
  select(Postcode = pcds, LSOA_Code = lsoa11cd, Region_County = ladnm)

# Handle missing values (remove rows with any NA values)
postcode_data_cleaned <- na.omit(postcode_data_cleaned)

# Ensure all columns are of the correct type (character type in this case)
postcode_data_cleaned <- postcode_data_cleaned %>%
  mutate(
    Postcode = as.character(Postcode),
    LSOA_Code = as.character(LSOA_Code),
    Region_County = as.character(Region_County)
  )

# Verify the cleaned data
str(postcode_data_cleaned)
summary(postcode_data_cleaned)
head(postcode_data_cleaned)

# Save the cleaned dataset with new column names
write_csv(postcode_data_cleaned, "~/Documents/DataScience/Cleaned_Data/cleaned_postcode_to_LSOA.csv")

# View the cleaned data (optional, to inspect the final output)
View(postcode_data_cleaned)
str(postcode_data_cleaned)
head(postcode_data_cleaned)