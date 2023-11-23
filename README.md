# Introduction

Hello!

This is my capstone project for the [Google Data Analytics Professional Certificate](https://www.coursera.org/professional-certificates/google-data-analytics?utm_source=google&utm_medium=institutions&utm_campaign=gwgsite&_ga=2.233256792.777469181.1700602980-1348698226.1700602980). It is the final assignment of the last course, serving as a comprehensive summary of everything leanred during this program through a case study analysis. The case study revolves around addressing a business problem using the 6 Phase Analysis methodology (Ask, Prepare, Process, Analyze, Share, Act).

In this project, I will show my analysis of Cyclistic, a fictional bike-share company. This study draws on historical data from the actual Chicago bike-share company, Divvy.

# Scenario 
You are a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, your team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, your team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve your recommendations, so they must be backed up with compelling data insights and professional data visualizations.

# Stakeholders
● Cyclistic: A bike-share program that features more than 5,800 bicycles and 600 docking stations. Cyclistic sets itself apart by also offering reclining bikes, hand tricycles, and cargo bikes, making bike-share more inclusive to people with disabilities and riders who can’t use a standard two-wheeled bike. The majority of riders opt for traditional bikes; about 8% of riders use the assistive options. Cyclistic users are more likely to ride for leisure, but about 30% use them to commute to work each day.

● Lily Moreno: The director of marketing and your manager. Moreno is responsible for the development of campaigns and initiatives to promote the bike-share program. These may include email, social media, and other channels.

● Cyclistic marketing analytics team: A team of data analysts who are responsible for collecting, analyzing, and reporting data that helps guide Cyclistic marketing strategy. You joined this team six months ago and have been busy learning about Cyclistic’s mission and business goals — as well as how you, as a junior data analyst, can help Cyclistic achieve them.

● Cyclistic executive team: The notoriously detail-oriented executive team will decide whether to approve the recommended marketing program.

# The Company
Back in 2016, Cyclistic successfully launched its bike-share program, which has since expanded to include a fleet of 5,824 bicycles. These bikes are equipped with geotracking technology and are stationed at 692 locations across Chicago. The main feature of these bikes is the ability for users to unlock them at one station and return them to any other station within the network at any time.

Up until now, Cyclistic's marketing strategy focused on creating general awareness and appealing to a broad audience. A key element enabling this approach was the flexibility in pricing plans, offering single-ride passes, full-day passes, and annual memberships. Casual riders are those who opt for single-ride or full-day passes, while Cyclistic members consist of those who subscribe annually.

Financial analysts at Cyclistic have determined that annual members contribute significantly more to profitability compared to casual riders. While the flexible pricing plans attract a larger customer base, the company's Chief Marketing Officer, Lily Moreno, believes that future growth hinges on maximizing the number of annual members. Rather than targeting entirely new customers, Moreno sees an opportunity to convert existing casual riders into members. She emphasizes that casual riders are already familiar with the Cyclistic program and have actively chosen it for their mobility needs.

With a clear goal in mind, Moreno aims to design marketing strategies specifically geared towards converting casual riders into annual members. To achieve this, the marketing analyst team must gain a deeper understanding of the distinctions between annual members and casual riders, the motivations behind casual riders choosing a membership, and how digital media could impact their marketing tactics. Moreno and her team are eager to delve into the historical bike trip data from Cyclistic to uncover relevant trends.

# Ask

## Expected Deliverable
- A clear statement of the business task

## Deliverable
The main business task is to develop a marketing strategy to convert casual riders to members. To that end, three questions are asked.

1. How do annual members and casual riders use Cyclistic bikes differently?
2. Why would casual riders buy Cyclistic annual memberships?
3. How can Cyclistic use digital media to influence casual riders to become members?

Moreno has assigned you the first question to answer: How do annual members and casual riders use Cyclistic bikes differently?

# Prepare

## Expected Deliverable
- A description of all data sources used

## Deliverable 
From [divvy-tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html), I used trip data from January 2022 to December 2022. The data has been made available by Motivate International Inc. under this [license](https://divvybikes.com/data-license-agreement).

This is public data that you can use to explore how different customer types are using Cyclistic bikes. But note that data-privacy issues prohibit you from using riders’ personally identifiable information. This means that you won’t be able to connect pass purchases to credit card numbers to determine if casual riders live in the Cyclistic service area or if they have purchased multiple single passes.

There are 12 files with naming convention of YYYYMM-divvy-tripdata (with the exception of September 2022, which has 202209-divvy-publictripdata.csv) and each file includes information for one month, such as the ride id, bike type, start time, end time, start station, end station, start location, end location, and whether the rider is a member or not. The corresponding column names are ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng and member_casual.

The following files were used:

- 202201-divvy-tripdata.csv
- 202202-divvy-tripdata.csv
- 202203-divvy-tripdata.csv
- 202204-divvy-tripdata.csv
- 202205-divvy-tripdata.csv
- 202206-divvy-tripdata.csv
- 202207-divvy-tripdata.csv
- 202208-divvy-tripdata.csv
- 202209-divvy-publictripdata.csv
- 202210-divvy-tripdata.csv
- 202211-divvy-tripdata.csv
- 202212-divvy-tripdata.csv

# Process

## Expected Deliverable
- Documentation of any manipulation & cleaning of data

## Deliverable
For the cleaning process, I used R. It has a wide range of tools for data manipulation and transformation. The dplyr packages, for instance, offer a convenient and expressive syntax for filtering, summarizing, and reshaping data, which can be advantageous for certain data processing tasks.

After loading the files onto RStudio, I checked the structure of each dataframe with the `colnames()` command, and then did one last check with the `compare_df_cols()` command as shown below.
```Rscript
compare_df_cols(jan_2022, feb_2022, mar_2022, apr_2022, may_2022, 
                jun_2022, jul_2022, aug_2022, sep_2022, oct_2022,
                nov_2022, dec_2022)
```
```
          column_name  jan_2022  feb_2022  mar_2022  apr_2022  may_2022  jun_2022  jul_2022  aug_2022  sep_2022  oct_2022  nov_2022  dec_2022
1             end_lat   numeric   numeric   numeric   numeric   numeric   numeric   numeric   numeric   numeric   numeric   numeric   numeric
2             end_lng   numeric   numeric   numeric   numeric   numeric   numeric   numeric   numeric   numeric   numeric   numeric   numeric
3      end_station_id character character character character character character character character character character character character
4    end_station_name character character character character character character character character character character character character
5            ended_at character character character character character character character character character character character character
6       member_casual character character character character character character character character character character character character
7             ride_id character character character character character character character character character character character character
8       rideable_type character character character character character character character character character character character character
9           start_lat   numeric   numeric   numeric   numeric   numeric   numeric   numeric   numeric   numeric   numeric   numeric   numeric
10          start_lng   numeric   numeric   numeric   numeric   numeric   numeric   numeric   numeric   numeric   numeric   numeric   numeric
11   start_station_id character character character character character character character character character character character character
12 start_station_name character character character character character character character character character character character character
13         started_at character character character character character character character character character character character character
```
After which I then combined all the individual dataframes into one larger dataframe, with 5,667,717 rows.
```Rscript
trips_2022 <- bind_rows(jan_2022, feb_2022, mar_2022, apr_2022, may_2022, 
                        jun_2022, jul_2022, aug_2022, sep_2022, oct_2022,
                        nov_2022, dec_2022)
```
I then created a variable to calculate the length of each trip, and converted it to a numeric format.
```Rscript
trips_2022$tripduration <- difftime(trips_2022$ended_at, 
                                    trips_2022$started_at, units = "min")
trips_2022$tripduration <- as.numeric(as.character(trips_2022$tripduration))
```
I did the same to find the month and day of each trip, using the `started_at` variable.
```Rscript
trips_2022$trip_month_num <- format(as.Date(trips_2022$started_at), "%m")
trips_2022$trip_month_num <- as.numeric(as.character(trips_2022$trip_month_num))
trips_2022$trip_month <- month.abb[trips_2022$trip_month_num]
 
trips_2022$trip_day_num <- format(as.Date(trips_2022$started_at), "%d")
trips_2022$trip_day_num <- as.numeric(as.character(trips_2022$trip_day_num))
trips_2022$trip_day <- wday(trips_2022$started_at, label=TRUE)
```
I then began cleaning the data. First, I removed any rows that contained null or no values, as well as any with a negative or zero trip duration. After these four lines, our dataframe was reduced to 4,369,052 rows
```Rscript
trips_2022_copy <- drop_na(trips_2022)
trips_2022_copy <- filter(trips_2022_copy, end_station_name != "")
trips_2021_copy <- filter(trips_2021_copy, start_station_name != "")
trips_2022_copy <- filter(trips_2022_copy, tripduration > 0)
```
# Analyze

## Expected Deliverable
- A summary of your analysis

## Deliverable

```Rscript
trips_2022_copy %>%
  group_by(member_casual) %>%
  summarise(numRides = n(), tripLenAvg = mean(tripduration))
```
```
 member_casual numRides tripLenAvg
  <chr>            <int>      <dbl>
1 casual         1758047       24.0
2 member         2611005       12.5
```
![Amount of total rides by type](https://github.com/azamz1/Google-Data-Analytics-Capstone/assets/37313814/3aff0f97-26ff-49cb-896a-c9201bfc3c5f)

```Rscript
trips_2022_copy %>%
  group_by(member_casual, trip_day) %>%
  summarise(numRides = n(), tripLenAvg = mean(tripduration)) %>%
  arrange(trip_day)
```
```
 member_casual trip_day numRides tripLenAvg
   <chr>         <ord>       <int>      <dbl>
 1 casual        Sun        301278       27.2
 2 member        Sun        297707       13.9
 3 casual        Mon        210746       24.8
 4 member        Mon        375151       12.0
 5 casual        Tue        196367       21.4
 6 member        Tue        411226       11.8
 7 casual        Wed        203568       20.7
 8 member        Wed        412775       11.8
 9 casual        Thu        229993       21.4
10 member        Thu        415862       12.0
11 casual        Fri        248785       22.4
12 member        Fri        360029       12.2
13 casual        Sat        367310       26.8
14 member        Sat        338255       14.0
```
![Average trip duration by rider type](https://github.com/azamz1/Google-Data-Analytics-Capstone/assets/37313814/0075e4b8-e155-474a-9cad-5000a59e7ff2)

```Rscript
trips_2022_copy %>% 
  group_by(member_casual, start_station_name) %>% 
  summarise(numRides = n()) %>% 
  arrange(desc(numRides)) %>% 
  filter(member_casual == "casual") %>% 
  select(start_station_name, numRides)
```
```
 member_casual start_station_name                 numRides
   <chr>         <chr>                                 <int>
 1 casual        Streeter Dr & Grand Ave               55054
 2 casual        DuSable Lake Shore Dr & Monroe St     30261
 3 casual        Millennium Park                       23948
 4 casual        Michigan Ave & Oak St                 23760
 5 casual        DuSable Lake Shore Dr & North Blvd    22156
 6 casual        Shedd Aquarium                        19421
 7 casual        Theater on the Lake                   17332
 8 casual        Wells St & Concord Ln                 14833
 9 casual        Dusable Harbor                        13270
10 casual        Clark St & Armitage Ave               12777
# ℹ 1,444 more rows
```
```Rscript
trips_2022_copy %>% 
  group_by(member_casual, end_station_name) %>% 
  summarise(numRides = n()) %>% 
  arrange(desc(numRides)) %>% 
  filter(member_casual == "casual") %>% 
  select(end_station_name, numRides)
```
```
 member_casual end_station_name                   numRides
   <chr>         <chr>                                 <int>
 1 casual        Streeter Dr & Grand Ave               57803
 2 casual        DuSable Lake Shore Dr & Monroe St     28542
 3 casual        Millennium Park                       25673
 4 casual        Michigan Ave & Oak St                 25372
 5 casual        DuSable Lake Shore Dr & North Blvd    25304
 6 casual        Theater on the Lake                   18648
 7 casual        Shedd Aquarium                        18047
 8 casual        Wells St & Concord Ln                 14415
 9 casual        Clark St & Armitage Ave               13028
10 casual        Clark St & Lincoln Ave                12851
# ℹ 1,501 more rows
```
![Top 10 most popular start stations for casual riders (2022)](https://github.com/azamz1/Google-Data-Analytics-Capstone/assets/37313814/ea288d52-1827-4b6a-80b4-04324daa7ca9)
![Top 10 most popular end stations for riders, by customer type (2022)](https://github.com/azamz1/Google-Data-Analytics-Capstone/assets/37313814/e6fc63f8-5c2f-4b8c-865b-f3b2fd503cee)
