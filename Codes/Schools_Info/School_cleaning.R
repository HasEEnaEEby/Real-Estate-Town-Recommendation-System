# Load required libraries
library(dplyr)

# Set working directory to the school dataset folder
setwd("~/Documents/DataScience/Obtain_Data/Datasets/School_dataset")

# Load Bristol's school data for 2021-2022
bristol_ks4 <- read.csv("Bristol School info/2021-2022/801_ks4final.csv")
bristol_info <- read.csv("Bristol School info/2021-2022/801_school_information.csv")

# Load Cornwall's school data for 2021-2022
cornwall_ks4 <- read.csv("Cornwall School info/2021-2022/908_ks4final.csv")
cornwall_info <- read.csv("Cornwall School info/2021-2022/908_school_information.csv")

