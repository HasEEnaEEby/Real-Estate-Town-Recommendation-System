# Load required libraries
library(dplyr)
library(ggplot2)

# Load the cleaned dataset
cleaned_data <- read.csv("~/Documents/DataScience/Cleaned_Data/cleaned_house_Pricing.csv")

# Filter data for the relevant counties (Bristol and Cornwall only)
data_2022_filtered <- cleaned_data %>%
  filter(county %in% c("CITY OF BRISTOL", "CORNWALL") & format(as.Date(date_of_transfer), "%Y") == "2022")

# Calculate average house price for 2022 by county
avg_price_2022 <- data_2022_filtered %>%
  group_by(county) %>%
  summarize(average_price = mean(price, na.rm = TRUE))

# Create a more refined bar chart for Average House Price in 2022
ggplot(avg_price_2022, aes(x = county, y = average_price, fill = county)) +
  geom_bar(stat = "identity", color = "black", width = 0.8) +  # Added black border and adjusted bar width
  labs(title = "Average House Prices in 2022 for Bristol and Cornwall",
       x = "County",
       y = "Average House Price",
       fill = "County") +  # Label for the legend
  theme_minimal(base_family = "Arial", base_size = 14) +  # Adjusted font and size
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 12),
        axis.text.y = element_text(size = 12),
        plot.title = element_text(size = 16, face = "bold"),
        legend.position = "right") +  # Position the legend on the right
  scale_y_continuous(labels = scales::comma) +  # Display y-axis with commas for thousands
  scale_fill_manual(values = c("CITY OF BRISTOL" = "turquoise", "CORNWALL" = "violet"))  # Custom colors
