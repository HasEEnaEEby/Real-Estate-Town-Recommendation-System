# Load required libraries
library(dplyr)
library(ggplot2)

# Load the cleaned dataset
cleaned_data <- read.csv("~/Documents/DataScience/Cleaned_Data/cleaned_house_data.csv")

# Filter data for the relevant counties (Bristol and Cornwall only)
data_2022_filtered <- cleaned_data %>%
  filter(county %in% c("CITY OF BRISTOL", "CORNWALL") & format(as.Date(date_of_transfer), "%Y") == "2022")

# Calculate average house price for 2022 by county
avg_price_2022 <- data_2022_filtered %>%
  group_by(county) %>%
  summarize(average_price = mean(price, na.rm = TRUE))

# Create a bar chart for Average House Price in 2022
ggplot(avg_price_2022, aes(x = county, y = average_price, fill = county)) +
  geom_bar(stat = "identity") +
  labs(title = "Average House Prices in 2022 for Bristol and Cornwall",
       x = "County",
       y = "Average House Price (GBP)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
