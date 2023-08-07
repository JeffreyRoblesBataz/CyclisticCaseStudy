# Cyclistic Bike Sharing Case Study: Analyzing Ride Lengths and User Behavior

## Introduction

As a recent graduate of the Google Data Analytics Certificate program, I had the opportunity to work on a diverse range of real-world data analysis projects. One of the most exciting and insightful projects that I undertook as part of my capstone project was the Cyclistic bike sharing case study. This project not only allowed me to apply the skills and knowledge I gained during the program but also provided a practical avenue to showcase my data analysis abilities.

In collaboration with Cyclistic, a prominent bike-sharing company with 5,824 bicycles and 692 stations located in Chicago, this case study aims to explore and understand user behavior and ride patterns using a comprehensive dataset spanning 12 months. The primary focus of the analysis is to investigate differences in ride lengths between casual riders and members, thereby providing valuable insights to optimize operational decisions and enhance the overall user experience.

This case study is a culmination of my learning journey in the Google Data Analytics program, where I honed my skills in data wrangling, exploratory data analysis, and data visualization. By meticulously following the data analysis lifecycle, from data acquisition and cleaning to drawing actionable insights, I am excited to present a robust and informative analysis that contributes to Cyclistic's business strategy.

In this report, I will walk you through the steps I took to extract meaningful insights from the Cyclistic dataset, showcase the techniques employed to handle and transform the data, and present the results in an accessible and visually appealing manner. Additionally, I will provide recommendations derived from the analysis, which Cyclistic can consider to improve user engagement, enhance services, and drive operational efficiencies.

## Utilities and Languages Used
- **R programming language 4.3.1**
- **tidyverse: An package that helps transform and present data**
- **lubridate: A package that makes working with dates and times easier .**
- **ggplot2: A data visualization package.**
- **dplyr: A package for data manipulation.**

- ## Environments Used
- **Windows 11**
- **RStudio**
- **Tableau**

- # Data Preparation Phase

## Data Acquisition

To begin the analysis, I acquired the necessary data from Cyclistic. The dataset comprises trip data spanning 12 months, which is crucial for conducting a comprehensive analysis of ride patterns and user behavior. The data was obtained as individual CSV files, each representing a month's worth of trip records. These were then imported into RStudio.
```
    Jul_2022 <- read.csv("202207-divvy-tripdata.csv")
    Aug_2022 <- read.csv("202208-divvy-tripdata.csv")
    Sep_2022 <- read.csv("202209-divvy-tripdata.csv")
    Oct_2022 <- read.csv("202210-divvy-tripdata.csv")
    Nov_2022 <- read.csv("202211-divvy-tripdata.csv")
    Dec_2022 <- read.csv("202212-divvy-tripdata.csv")
    Jan_2023 <- read.csv("202301-divvy-tripdata.csv")
    Feb_2023 <- read.csv("202302-divvy-tripdata.csv")
    Mar_2023 <- read.csv("202303-divvy-tripdata.csv")
    Apr_2023 <- read.csv("202304-divvy-tripdata.csv")
    May_2023 <- read.csv("202305-divvy-tripdata.csv")
    Jun_2023 <- read.csv("202306-divvy-tripdata.csv")
```
## Data Cleaning

Before diving into the analysis, it's essential to ensure the dataset is clean and structured properly. Here are the key steps I took during the data cleaning phase:

1. **Combining Data Sets** I combined all the data sets into one data frame
```
    trips_2022 <- rbind(Jul_2022, Aug_2022, Sep_2022, Oct_2022, Nov_2022, Dec_2022)
    trips_2023 <- rbind(Jan_2023, Feb_2023, Mar_2023, Apr_2023, May_2023, Jun_2023)
    all_trips <- rbind(trips_2022, trips_2023)
```
2. **Removing Empty Values:** I utilized the `janitor` package to remove both empty rows and empty columns from the dataset, ensuring that we are working with complete and meaningful data.
```
    all_trips <- janitor::remove_empty(dat = all_trips,which = c("cols"))
        all_trips <- janitor::remove_empty(dat = all_trips,which = c("rows"))
        dim(all_trips)
```
3. **Selecting Relevant Columns:** Since not all columns are necessary for the analysis, I used the `dplyr` package to select only the relevant columns, excluding attributes like start and end coordinates, station names, and IDs.
```
    all_trips <- all_trips %>%  
        select(-c(start_lat, start_lng, end_lat, end_lng, start_station_name, start_station_id, end_station_name, end_station_id))
```      
4. **Datetime Conversion:** The `lubridate` package was used to convert the "started_at" and "ended_at" columns to datetime format. This conversion enables us to extract valuable insights related to dates and times.
```
    all_trips$started_at <- lubridate::as_datetime(all_trips$started_at)
    all_trips$ended_at <- lubridate::as_datetime(all_trips$ended_at)
```
5. **Creating Additional Variables:** I derived several variables from the datetime columns, such as "date," "month," "day," "year," "day_of_week," "start_time," and "end_time." These variables provide a structured foundation for further analysis.
```
all_trips <- all_trips %>%
  mutate(
    date = as.Date(started_at),
    month = month(started_at),
    day = day(started_at),
    year = year(started_at),
    day_of_week = wday(started_at, label = TRUE),
    start_time = paste(hour(started_at), minute(started_at), sep = ":"),
    end_time = paste(hour(ended_at), minute(ended_at), sep = ":"))
```
6. **Calculating Ride Lengths:** By calculating the difference between "ended_at" and "started_at," I obtained ride lengths in both minutes and hours. These metrics will be instrumental in understanding ride patterns.
```
all_trips$length_min <- difftime(all_trips$ended_at, all_trips$started_at, units = "mins")
    all_trips$length_min <- round(as.numeric(all_trips$length_min), 3)
    all_trips$length_hr <- difftime(all_trips$ended_at, all_trips$started_at, units = "hours")
    all_trips$length_hr <- round(as.numeric(all_trips$length_hr), 2)
```
## Data Aggregation

Aggregating data allows us to extract summary statistics and gain a high-level view of the dataset. Here are the key aggregation steps I performed:

- **Mean, Median, Max, Min Ride Lengths:** I calculated the mean, median, maximum, and minimum ride lengths for the entire dataset. These statistics provide a baseline understanding of ride durations.
```
    mean_ride_length <- mean(all_trips$ride_length)
    median_ride_length <- median(all_trips$ride_length)
    max_ride_length <- max(all_trips$ride_length)
    min_ride_length <- min(all_trips$ride_length)
```
- **Aggregate by User Type:** I used the `aggregate` function to compute mean, median, maximum, and minimum ride lengths for both casual riders and members. This segmentation sheds light on user behavior and preferences.
```
    aggregate(all_trips$ride_length ~ all_trips$member_casual, FUN = mean)
    aggregate(all_trips$ride_length ~ all_trips$member_casual, FUN = median)
    aggregate(all_trips$ride_length ~ all_trips$member_casual, FUN = max)
    aggregate(all_trips$ride_length ~ all_trips$member_casual, FUN = min)
```
## Data Transformation and Export

To ensure seamless integration with visualization tools, I transformed the dataset and exported it for further analysis. The final dataset, named "cyclist_data_tableau.csv," is ready for exploration and visualization using tools like Tableau.
```
    write.csv(all_trips, file = "cyclist_data_tableau.csv", row.names = FALSE)
```
By meticulously preparing the data, I have laid the foundation for insightful analysis in the subsequent phases of this project.

# Data Analysis Phase

## Exploratory Data Analysis

With a well-prepared dataset in hand, I conducted an exploratory data analysis to uncover meaningful insights about Cyclistic's ride patterns and user behavior.

### Ride Patterns Over Time

To understand how ride patterns change over time, I conducted the following analyses:

1. **Day of the Week Analysis:** By examining ride lengths on different days of the week, I revealed variations in demand. This information can inform resource allocation and marketing strategies.

### Ride Duration Analysis

Ride duration is a key metric that sheds light on user preferences and behaviors. I explored this metric in depth:

1. **Distribution of Ride Lengths:** Visualizing the distribution of ride lengths provides insights into common trip durations and potential outliers.

2. **Average Ride Lengths by User Type:** Comparing ride lengths between casual riders and members reveals whether there are significant differences in usage patterns.

## Summary Statistics and Insights

### Key Findings

1. **Monthly Trends:** The analysis revealed that ride counts generally increase during warmer months, suggesting a seasonal aspect to Cyclistic's usage.

2. **Weekday vs. Weekend:** Ride counts are consistently higher on weekends compared to weekdays, indicating distinct user behavior patterns.

3. **Ride Lengths:** The average ride length varies between casual riders and members, suggesting different usage intentions. Casual riders tend to have longer rides on average.

## Recommendations for Action

Based on the analysis, I recommend the following actions to Cyclistic:

1. **Seasonal Promotions:** Capitalize on the seasonal nature of ride demand by offering promotions during peak months to attract more users.

2. **Weekend Specials:** Introduce special offers or incentives on weekends to cater to increased weekend usage.

3. **Membership Benefits:** Tailor membership benefits to address the varying ride patterns of casual riders and members.

4. **Customer Engagement:** Leverage insights about ride lengths to create engaging content that resonates with different user segments.

By understanding Cyclistic's ride patterns and user behaviors, the company can make informed decisions that drive customer satisfaction and business growth.

# Results and Insights

## Key Takeaways

Completing this data analysis journey has provided valuable insights into Cyclistic's bike-sharing business. Here are the key takeaways from this project:

1. **Seasonal Patterns:** The analysis revealed distinct seasonal trends in ride lengths, with higher usage during warmer months. This suggests that Cyclistic can plan targeted marketing campaigns and promotions to boost ridership during the peak season.

2. **Weekday vs. Weekend:** Ride patterns showed consistent spikes in usage during weekends, indicating the popularity of leisure rides. Cyclistic can use this information to create tailored weekend promotions and offers.

3. **User Segmentation:** Differentiating between casual riders and members allowed us to identify varying ride behaviors. Members tend to have shorter rides on average, while casual riders take longer rides. Cyclistic can tailor its services to these segments more effectively.

4. **Engagement Opportunities:** Insights from ride duration analysis open doors to engage customers with relevant content. Cyclistic can create blog posts, social media content, or newsletter features that resonate with the different user types.

## Business Recommendations

Based on the comprehensive analysis performed in this project, I propose the following actionable recommendations for Cyclistic:

1. **Targeted Marketing:** Utilize the knowledge of seasonal patterns to design marketing campaigns that effectively capture the attention of potential riders during peak months.

2. **Weekend Promotions:** Introduce weekend-specific promotions to tap into the higher demand during those days, enticing users to take more rides.

3. **Membership Benefits:** Tailor membership benefits to align with the usage patterns of members. Offer perks that cater to shorter rides or quick rides around the city.

## Conclusion

This case study served as a capstone project that allowed me to apply the skills and techniques learned throughout the program. By combining data preparation, exploration, and analysis, I was able to provide actionable insights to Cyclistic. The recommendations put forth are aimed at driving growth, enhancing customer experience, and boosting Cyclistic's position in the bike-sharing market.

I am excited to have successfully completed this project and am confident in the value it brings to Cyclistic's decision-making processes. This experience further solidified my passion for data analytics and its power to drive meaningful change in businesses.

Thank you for joining me on this data analysis journey with Cyclistic!
