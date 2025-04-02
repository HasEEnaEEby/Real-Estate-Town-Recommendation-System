# Load required libraries
library(dplyr)
library(readr)

# Load the cleaned Postcode to LSOA dataset
postcode_lsoa <- read_csv("~/Documents/DataScience/Cleaned_Data/cleaned_postcode_to_LSOA.csv")

# Load the broadband coverage and performance datasets
broadband_coverage <- read_csv("~/Documents/DataScience/Obtain_Data/Datasets/broadband_speed/fixed_pc/broadband_coverage.csv")
broadband_performance <- read_csv("~/Documents/DataScience/Obtain_Data/Datasets/broadband_speed/fixed_pc/broadband_performance.csv")

summary(broadband_coverage)
summary(broadband_performance)

colnames(broadband_coverage)
colnames(broadband_performance)

colnames(postcode_lsoa)

# Clean and select relevant columns from the broadband coverage dataset
broadband_coverage_cleaned <- broadband_coverage %>%
  select(Postcode = pcds, 
         SFBB_Availability = SFBB.availability....premises., 
         UFBB_Availability = UFBB.availability....premises., 
         FTTP_Availability = FTTP.availability....premises.)

# Clean and select relevant columns from the broadband performance dataset
broadband_performance_cleaned <- broadband_performance %>%
  select(Postcode = postcode_space, 
         Median_Download_Speed = Median.download.speed..Mbit.s., 
         Average_Download_Speed = Average.download.speed..Mbit.s., 
         Maximum_Download_Speed = Maximum.download.speed..Mbit.s.)

# Merge the coverage data with the Postcode to LSOA data
coverage_merged <- merge(postcode_lsoa, broadband_coverage_cleaned, by = "Postcode", all.x = TRUE)

# Merge the performance data with the previously merged data
broadband_merged <- merge(coverage_merged, broadband_performance_cleaned, by = "Postcode", all.x = TRUE)

# Filter the dataset for Bristol and Cornwall only
broadband_merged_filtered <- broadband_merged %>%
  filter(Region_County %in% c("Bristol, City of", "Cornwall"))

# Handle missing values (if any) after merging and filtering
broadband_merged_filtered <- na.omit(broadband_merged_filtered)

# Final inspection of the cleaned and filtered dataset
summary(broadband_merged_filtered)
head(broadband_merged_filtered)

# Save the cleaned and filtered dataset
write.csv(broadband_merged_filtered, "~/Documents/DataScience/Cleaned_Data/cleaned_broadband_data.csv", row.names = FALSE)

# View the final dataset (optional)
View(broadband_merged_filtered)
