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

jan_2021 <- read.csv("202101-divvy-tripdata.csv")
feb_2021 <- read.csv("202102-divvy-tripdata.csv")
mar_2021 <- read.csv("202103-divvy-tripdata.csv")
apr_2021 <- read.csv("202104-divvy-tripdata.csv")
may_2021 <- read.csv("202105-divvy-tripdata.csv")
jun_2021 <- read.csv("202106-divvy-tripdata.csv")
jul_2021 <- read.csv("202107-divvy-tripdata.csv")
aug_2021 <- read.csv("202108-divvy-tripdata.csv")
sep_2021 <- read.csv("202109-divvy-tripdata.csv")
oct_2021 <- read.csv("202110-divvy-tripdata.csv")
nov_2021 <- read.csv("202111-divvy-tripdata.csv")
dec_2021 <- read.csv("202112-divvy-tripdata.csv")

#Step 3: Check to ensure the datasets have the same column names

colnames(jan_2021)
colnames(feb_2021)
colnames(mar_2021)
colnames(apr_2021)
colnames(may_2021)
colnames(jun_2021)
colnames(jul_2021)
colnames(aug_2021)
colnames(sep_2021)
colnames(oct_2021)
colnames(nov_2021)
colnames(dec_2021)

#Step 4: Check for any mismatches in column data types

compare_df_cols(jan_2021, feb_2021, mar_2021, apr_2021, may_2021, 
                jun_2021, jul_2021, aug_2021, sep_2021, oct_2021,
                nov_2021, dec_2021)

#Step 5: Combine the data from all months into one dataframe
 
trips_2021 <- bind_rows(jan_2021, feb_2021, mar_2021, apr_2021, may_2021, 
                        jun_2021, jul_2021, aug_2021, sep_2021, oct_2021,
                        nov_2021, dec_2021)

trips_2021$tripduration <- difftime(trips_2021$ended_at, 
                                    trips_2021$started_at, units = "min")
trips_2021$tripduration <- as.numeric(as.character(trips_2021$tripduration))

str(trips_2021)
 
skim_without_charts(trips_2021)

#Step 5: Extract the date elements for potential use
 
trips_2021$trip_month_num <- format(as.Date(trips_2021$started_at), "%m")
trips_2021$trip_month_num <- as.numeric(as.character(trips_2021$trip_month_num))
trips_2021$trip_month <- month.abb[trips_2021$trip_month_num]
 
trips_2021$trip_day_num <- format(as.Date(trips_2021$started_at), "%d")
trips_2021$trip_day_num <- as.numeric(as.character(trips_2021$trip_day_num))
trips_2021$trip_day <- wday(trips_2021$started_at, label=TRUE)

#Check for consistency again

str(trips_2021)

#Step 6: Clean data

#First, start with searching for any negative values of tripduration, as
#it wouldn't make sense for the start date to be later than the end date

#First, we make a copy, in case we need the original dataset. This will
#also drop any rows with missing values

trips_2021_copy <- drop_na(trips_2021)
trips_2021_copy <- filter(trips_2021_copy, end_station_name != "")

coordinates <- select(trips_2021_copy, start_station_name, end_station_name, 
                   start_lat, start_lng, end_lat, end_lng, member_casual)
trips_2021_copy <- trips_2021_copy %>% 
  select (-c(start_lat, start_lng, end_lat, end_lng))

#This step will get rid of any rows that have negative values for
#tripduration

trips_2021_copy <- filter(trips_2021_copy, tripduration > 0)

trips_2021$trip_month = factor(trips_2021$trip_month, levels = month.abb)

#Step 7: Summarize the data so far
 
#This block will show the number of both Customers and Subscribers, as
#well as the the average trip length of each type of user

trips_2021_copy %>%
  group_by(member_casual) %>%
  summarise(numRides = n(), tripLenAvg = mean(tripduration))

#This block gives us the stats for Customers and Subscribers, grouped by
#days of the week

trips_2021_copy %>%
  group_by(member_casual, trip_day) %>%
    summarise(numRides = n(), tripLenAvg = mean(tripduration)) %>%
      arrange(trip_day)

#The next 2 blocks are to find the most popular starting and
#destination stations for Members
trips_2021_copy %>% 
  group_by(member_casual, start_station_name) %>% 
  summarise(numRides = n()) %>% 
  arrange(desc(numRides)) %>% 
  filter(member_casual == "casual") %>% 
  select(start_station_name, numRides)

trips_2021_copy %>% 
  group_by(member_casual, end_station_name) %>% 
  summarise(numRides = n()) %>% 
  arrange(desc(numRides)) %>% 
  filter(member_casual == "casual") %>% 
  select(end_station_name, numRides)

#The next 2 blocks are to find the most popular starting and
#destination stations for Members

trips_2021_copy %>% 
  group_by(member_casual, start_station_name) %>% 
  summarise(numRides = n()) %>% 
  arrange(desc(numRides)) %>% 
  filter(member_casual == "member") %>% 
  select(start_station_name, numRides)

trips_2021_copy %>% 
  group_by(member_casual, end_station_name) %>% 
  summarise(number_of_rides = n()) %>% 
  arrange(desc(number_of_rides)) %>% 
  filter(member_casual == "member") %>% 
  select(end_station_name, number_of_rides)

#The next few blocks will be to find the most popular trip route by
#usertype. First, we create a table has the routes as their own colum

trip_routes <- unite(trips_2021_copy, "route", start_station_name,
                     end_station_name, sep= " to ", remove = TRUE)

common_routes <- trip_routes %>%
  group_by(route) %>%
  summarise(numRide = n()) %>%
  arrange(desc(numRide))

common_routes_mem <- trip_routes %>%
  group_by(route, member_casual) %>%
  summarise(numRide = n()) %>%
  filter(member_casual == 'member') %>%
  arrange(desc(numRide))

common_routes_cas <- trip_routes %>%
  group_by(route, member_casual) %>%
  summarise(numRide = n()) %>%
  filter(member_casual == 'casual') %>%
  arrange(desc(numRide))

# #Step 8: Now we visualize

trips_2021_copy %>%
  group_by(member_casual) %>%
  summarise(tripLenAvg = mean(tripduration)) %>%
  ggplot(mapping = aes(x = member_casual, y = tripLenAvg,
                       fill = member_casual)) + geom_col() +
                       scale_y_continuous(breaks= pretty_breaks()) +
                        labs(title = "Average trip duration by customer type",
                             x="Customer type",
                             y="Average trip duration (min)")

trips_2021_copy %>%
  group_by(member_casual, trip_month) %>%
  arrange(trip_month) %>%
  summarise(numRide = n(), tripLenAvg = mean(tripduration)) %>%
  ggplot (aes(x = trip_month, y = numRide, fill = member_casual)) +
  geom_col(position = "dodge") +
  scale_y_continuous(labels = label_comma(), breaks= pretty_breaks()) +
  scale_x_discrete(limits = month.abb) +
  labs(title = "Number of rides per month, by customer type (2021)",
       x = "Month", y ="Number of rides") +
       theme(axis.text.x = element_text(angle = 60, hjust = 1))

trips_2021_copy %>%
  group_by(member_casual, trip_day) %>%
  summarise(numRide = n(), tripLenAvg = mean(tripduration)) %>%
  ggplot(aes(x = trip_day, y=numRide, fill = member_casual)) +
  geom_col(position = "dodge") +
  scale_y_continuous(labels = label_comma(), breaks= pretty_breaks()) +
  labs(title = "Number of rides per day of the week, by customer type (2021)",
       x = "Day of the week", y = "Number of rides")

trips_2021_copy %>%
  group_by(member_casual, trip_day) %>%
  summarise(numRide = n(), tripLenAvg = mean(tripduration)) %>%
  ggplot (aes(x = trip_day, y = tripLenAvg, fill=member_casual)) + 
          geom_col(position = "dodge") + 
          labs(title = "Average ride length per week day, by rider type (2021)",
               x = "Day of the week", y ="Average ride length (min)")+ 
               theme(axis.text.x = element_text(angle = 60, hjust = 1))

trips_2021_copy %>%
  group_by(member_casual, rideable_type, trip_month) %>%
    summarise(numRide = n()) %>%
    ggplot(aes(x = trip_month, y = numRide, fill = rideable_type)) + 
    geom_col(position = "dodge2") + 
    facet_wrap(~ member_casual) +
    scale_y_continuous(labels = label_comma(), breaks= pretty_breaks()) +
    scale_x_discrete(limits = month.abb) +
    labs(title ="Number of rides per rideable type per month (2021)",
         x ="Rideable Type",y ="Number of rides")

trips_2021_copy %>%
  group_by(member_casual, rideable_type, trip_month) %>%
  summarise(tripLenAvg = mean(tripduration)) %>%
  ggplot(aes(x = trip_month, y = tripLenAvg, fill = rideable_type)) + 
  geom_col(position = "dodge") + 
  facet_wrap(~ member_casual) +
  scale_y_continuous(labels = label_comma(), breaks= pretty_breaks()) +
  scale_x_discrete(limits = month.abb) +
  labs(title ="Average trip length per rideable type per month, by customer type (2021)",
       x ="Rideable Type",y ="Length of trip (min)")

trips_2021_copy %>%
  group_by(start_station_name, member_casual) %>%
  summarise(numRide = n()) %>%
  arrange(numRide) %>%
  filter(member_casual == "casual", numRide > 15700) %>%
  select(start_station_name, numRide) %>%
  ggplot(aes(x = start_station_name, y = numRide)) + 
  geom_col(fill ="blue") + coord_flip() + 
  scale_y_continuous(labels = label_comma(), breaks= pretty_breaks()) +
  labs(title = "Top 10 most popular start stations for casual riders", 
       x = "Origin station name", y = "Number of trips")

trips_2021_copy %>%
  group_by(start_station_name, member_casual) %>%
  summarise(numRide = n()) %>%
  arrange(numRide) %>%
  filter(member_casual == "member", numRide > 16100) %>%
  select(start_station_name, numRide) %>%
  ggplot(aes(x = start_station_name, y = numRide)) + 
  geom_col(fill ="blue") + coord_flip() + 
  scale_y_continuous(labels = label_comma(), breaks= pretty_breaks()) +
  labs(title = "Top 10 most popular start stations for member riders", 
       x = "Origin station name", y = "Number of trips")
