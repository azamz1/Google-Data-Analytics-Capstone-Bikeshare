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
The main business task is to develop a marketing strategy to convert casual riders to members. To that end, three questions are asked.

1. How do annual members and casual riders use Cyclistic bikes differently?
2. Why would casual riders buy Cyclistic annual memberships?
3. How can Cyclistic use digital media to influence casual riders to become members?

Moreno has assigned you the first question to answer: How do annual members and casual riders use Cyclistic bikes differently?

# Prepare

From [divvy-tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html), I used trip data from January 2022 to December 2022. The data has been made available by Motivate International Inc. under this [license](https://divvybikes.com/data-license-agreement).
