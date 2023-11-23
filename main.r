#Step 1: Install and activate all packages
install.packages("tidyverse")
install.packages("janitor")
install.packages("lubridate")
install.packages("readr")

library(tidyverse)
library(lubridate)
library(skimr)
library(janitor)
library(readr)
library(scales)
library(dplyr)

#Step 2: Load the datasets

jan_2022 <- read.csv("202201-divvy-tripdata.csv")
feb_2022 <- read.csv("202202-divvy-tripdata.csv")
mar_2022 <- read.csv("202203-divvy-tripdata.csv")
apr_2022 <- read.csv("202204-divvy-tripdata.csv")
may_2022 <- read.csv("202205-divvy-tripdata.csv")
jun_2022 <- read.csv("202206-divvy-tripdata.csv")
jul_2022 <- read.csv("202207-divvy-tripdata.csv")
aug_2022 <- read.csv("202208-divvy-tripdata.csv")
sep_2022 <- read.csv("202209-divvy-publictripdata.csv")
oct_2022 <- read.csv("202210-divvy-tripdata.csv")
nov_2022 <- read.csv("202211-divvy-tripdata.csv")
dec_2022 <- read.csv("202212-divvy-tripdata.csv")

#Step 3: Check to ensure the datasets have the same column names

colnames(jan_2022)
colnames(feb_2022)
colnames(mar_2022)
colnames(apr_2022)
colnames(may_2022)
colnames(jun_2022)
colnames(jul_2022)
colnames(aug_2022)
colnames(sep_2022)
colnames(oct_2022)
colnames(nov_2022)
colnames(dec_2022)

#Step 4: Check for any mismatches in column data types

compare_df_cols(jan_2022, feb_2022, mar_2022, apr_2022, may_2022, jun_2022, jul_2022, aug_2022, sep_2022, oct_2022, nov_2022, dec_2022)

#Step 5: Combine the data from all months into one dataframe
 
trips_2022 <- bind_rows(jan_2022, feb_2022, mar_2022, apr_2022, may_2022, jun_2022, jul_2022, aug_2022, sep_2022, oct_2022, nov_2022, dec_2022)

trips_2022$tripduration <- difftime(trips_2022$ended_at, trips_2022$started_at, units = "min")

trips_2022$tripduration <- as.numeric(as.character(trips_2022$tripduration))

str(trips_2022)
 
skim_without_charts(trips_2022)

#Step 5: Extract the date elements for potential use
 
trips_2022$trip_month_num <- format(as.Date(trips_2022$started_at), "%m")
trips_2022$trip_month_num <- as.numeric(as.character(trips_2022$trip_month_num))
trips_2022$trip_month <- month.abb[trips_2022$trip_month_num]
 
trips_2022$trip_day_num <- format(as.Date(trips_2022$started_at), "%d")
trips_2022$trip_day_num <- as.numeric(as.character(trips_2022$trip_day_num))
trips_2022$trip_day <- wday(trips_2022$started_at, label=TRUE)

#Check for consistency again

str(trips_2022)

#Step 6: Clean data

#First, start with searching for any negative values of tripduration, as
#it wouldn't make sense for the start date to be later than the end date

#First, we make a copy, in case we need the original dataset. This will
#also drop any rows with missing values

trips_2022_copy <- drop_na(trips_2022)

trips_2022_copy <- filter(trips_2022_copy, end_station_name != "")
trips_2022_copy <- filter(trips_2022_copy, start_station_name !="")

#This step will get rid of any rows that have negative values for
#tripduration

trips_2022_copy <- filter(trips_2022_copy, tripduration > 0)

#Step 7: Summarize the data so far
 
#This block will show the number of both Customers and Subscribers, as
#well as the the average trip length of each type of user

trips_2022_copy %>%
  group_by(member_casual) %>%
  summarise(numRides = n(), tripLenAvg = mean(tripduration))

#This block gives us the stats for Customers and Subscribers, grouped by
#days of the week

trips_2022_copy %>%
  group_by(member_casual, trip_day) %>%
  summarise(numRides = n(), tripLenAvg = mean(tripduration)) %>%
  arrange(trip_day)

#The next 2 blocks are to find the most popular starting and
#destination stations for Members
trips_2022_copy %>% 
  group_by(member_casual, start_station_name) %>% 
  summarise(numRides = n()) %>% 
  arrange(desc(numRides)) %>% 
  filter(member_casual == "casual") %>% 
  select(start_station_name, numRides)

trips_2022_copy %>% 
  group_by(member_casual, end_station_name) %>% 
  summarise(numRides = n()) %>% 
  arrange(desc(numRides)) %>% 
  filter(member_casual == "casual") %>% 
  select(end_station_name, numRides)

# Step 8: We export our main dataframe for use in Tableau
write.csv(trips_2022_copy,"trips_2022.csv")
