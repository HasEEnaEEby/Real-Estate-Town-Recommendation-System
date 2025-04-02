# Load required libraries
library(dplyr)
library(ggplot2)

# Load the cleaned dataset
cleaned_data <- read.csv("~/Documents/DataScience/Cleaned_Data/cleaned_house_Pricing.csv")

# Add a year column to the dataset
cleaned_data$year <- format(as.Date(cleaned_data$date_of_transfer), "%Y")

# Filter data for the relevant counties (Bristol and Cornwall) and years (2020 to 2023)
data_filtered <- cleaned_data %>%
  filter(county %in% c("CITY OF BRISTOL", "CORNWALL") & year %in% c("2020", "2021", "2022", "2023"))

# Calculate average house price by year and county
avg_price_by_year <- data_filtered %>%
  group_by(county, year) %>%
  summarize(average_price = mean(price, na.rm = TRUE))

# Create the line chart for Average House Prices from 2020 to 2023
ggplot(avg_price_by_year, aes(x = year, y = average_price, color = county, group = county)) +
  geom_line(linewidth = 1.2) +  # Use `linewidth` instead of `size`
  geom_point(size = 3) +
  labs(title = "Average House Prices from 2020 to 2023 for Bristol and Cornwall",
       x = "Year",
       y = "Average House Price",
       color = "County") +  # Legend label
  theme_minimal(base_family = "Arial", base_size = 14) +  # Adjusted font and size
  scale_y_continuous(labels = scales::comma) +  # Display y-axis with commas for thousands
  scale_color_manual(values = c("CITY OF BRISTOL" = "navy", "CORNWALL" = "firebrick"))  # Custom colors
