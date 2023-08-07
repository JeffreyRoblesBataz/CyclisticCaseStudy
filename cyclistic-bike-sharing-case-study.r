{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "64ec5dab",
   "metadata": {
    "_execution_state": "idle",
    "_uuid": "051d70d956493feee0c6d64651c6a088724dca2a",
    "papermill": {
     "duration": 0.002815,
     "end_time": "2023-08-07T15:40:18.475136",
     "exception": false,
     "start_time": "2023-08-07T15:40:18.472321",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": []
  },
  {
   "cell_type": "markdown",
   "id": "0d8c3b7b",
   "metadata": {
    "papermill": {
     "duration": 0.001667,
     "end_time": "2023-08-07T15:40:18.478793",
     "exception": false,
     "start_time": "2023-08-07T15:40:18.477126",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# Cyclistic Bike Sharing Case Study: Analyzing Ride Lengths and User Behavior\n",
    "\n",
    "## Introduction\n",
    "\n",
    "As a recent graduate of the Google Data Analytics Certificate program, I had the opportunity to work on a diverse range of real-world data analysis projects. One of the most exciting and insightful projects that I undertook as part of my capstone project was the Cyclistic bike sharing case study. This project not only allowed me to apply the skills and knowledge I gained during the program but also provided a practical avenue to showcase my data analysis abilities.\n",
    "\n",
    "In collaboration with Cyclistic, a prominent bike-sharing company with 5,824 bicycles and 692 stations located in Chicago, this case study aims to explore and understand user behavior and ride patterns using a comprehensive dataset spanning 12 months. The primary focus of the analysis is to investigate differences in ride lengths between casual riders and members, thereby providing valuable insights to optimize operational decisions and enhance the overall user experience.\n",
    "\n",
    "This case study is a culmination of my learning journey in the Google Data Analytics program, where I honed my skills in data wrangling, exploratory data analysis, and data visualization. By meticulously following the data analysis lifecycle, from data acquisition and cleaning to drawing actionable insights, I am excited to present a robust and informative analysis that contributes to Cyclistic's business strategy.\n",
    "\n",
    "In this report, I will walk you through the steps I took to extract meaningful insights from the Cyclistic dataset, showcase the techniques employed to handle and transform the data, and present the results in an accessible and visually appealing manner. Additionally, I will provide recommendations derived from the analysis, which Cyclistic can consider to improve user engagement, enhance services, and drive operational efficiencies."
   ]
  },
  {
   "cell_type": "markdown",
   "id": "bdfd6a2c",
   "metadata": {
    "papermill": {
     "duration": 0.002506,
     "end_time": "2023-08-07T15:40:18.482972",
     "exception": false,
     "start_time": "2023-08-07T15:40:18.480466",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Utilities and Languages Used\n",
    "- **R programming language 4.3.1**\n",
    "- **tidyverse: An package that helps transform and present data**\n",
    "- **lubridate: A package that makes working with dates and times easier .**\n",
    "- **ggplot2: A data visualization package.**\n",
    "- **dplyr: A package for data manipulation.**"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "06edaea0",
   "metadata": {
    "papermill": {
     "duration": 0.001721,
     "end_time": "2023-08-07T15:40:18.486770",
     "exception": false,
     "start_time": "2023-08-07T15:40:18.485049",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Utilities and Languages Used\n",
    "- **Windows 11**\n",
    "- **RStudio**\n",
    "- **Tableau**"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "97321448",
   "metadata": {
    "papermill": {
     "duration": 0.001642,
     "end_time": "2023-08-07T15:40:18.490135",
     "exception": false,
     "start_time": "2023-08-07T15:40:18.488493",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# Data Preparation Phase\n",
    "\n",
    "## Data Acquisition\n",
    "\n",
    "To begin the analysis, I acquired the necessary data from Cyclistic. The dataset comprises trip data spanning 12 months, which is crucial for conducting a comprehensive analysis of ride patterns and user behavior. The data was obtained as individual CSV files, each representing a month's worth of trip records. These were then imported into RStudio.\n",
    "```\n",
    "    Jul_2022 <- read.csv(\"202207-divvy-tripdata.csv\")\n",
    "    Aug_2022 <- read.csv(\"202208-divvy-tripdata.csv\")\n",
    "    Sep_2022 <- read.csv(\"202209-divvy-tripdata.csv\")\n",
    "    Oct_2022 <- read.csv(\"202210-divvy-tripdata.csv\")\n",
    "    Nov_2022 <- read.csv(\"202211-divvy-tripdata.csv\")\n",
    "    Dec_2022 <- read.csv(\"202212-divvy-tripdata.csv\")\n",
    "    Jan_2023 <- read.csv(\"202301-divvy-tripdata.csv\")\n",
    "    Feb_2023 <- read.csv(\"202302-divvy-tripdata.csv\")\n",
    "    Mar_2023 <- read.csv(\"202303-divvy-tripdata.csv\")\n",
    "    Apr_2023 <- read.csv(\"202304-divvy-tripdata.csv\")\n",
    "    May_2023 <- read.csv(\"202305-divvy-tripdata.csv\")\n",
    "    Jun_2023 <- read.csv(\"202306-divvy-tripdata.csv\")\n",
    "```\n",
    "## Data Cleaning\n",
    "\n",
    "Before diving into the analysis, it's essential to ensure the dataset is clean and structured properly. Here are the key steps I took during the data cleaning phase:\n",
    "\n",
    "1. **Combining Data Sets** I combined all the data sets into one data frame\n",
    "```\n",
    "    trips_2022 <- rbind(Jul_2022, Aug_2022, Sep_2022, Oct_2022, Nov_2022, Dec_2022)\n",
    "    trips_2023 <- rbind(Jan_2023, Feb_2023, Mar_2023, Apr_2023, May_2023, Jun_2023)\n",
    "    all_trips <- rbind(trips_2022, trips_2023)\n",
    "```\n",
    "2. **Removing Empty Values:** I utilized the `janitor` package to remove both empty rows and empty columns from the dataset, ensuring that we are working with complete and meaningful data.\n",
    "```\n",
    "    all_trips <- janitor::remove_empty(dat = all_trips,which = c(\"cols\"))\n",
    "        all_trips <- janitor::remove_empty(dat = all_trips,which = c(\"rows\"))\n",
    "        dim(all_trips)\n",
    "```\n",
    "3. **Selecting Relevant Columns:** Since not all columns are necessary for the analysis, I used the `dplyr` package to select only the relevant columns, excluding attributes like start and end coordinates, station names, and IDs.\n",
    "```\n",
    "    all_trips <- all_trips %>%  \n",
    "        select(-c(start_lat, start_lng, end_lat, end_lng, start_station_name, start_station_id, end_station_name, end_station_id))\n",
    "```      \n",
    "4. **Datetime Conversion:** The `lubridate` package was used to convert the \"started_at\" and \"ended_at\" columns to datetime format. This conversion enables us to extract valuable insights related to dates and times.\n",
    "```\n",
    "    all_trips$started_at <- lubridate::as_datetime(all_trips$started_at)\n",
    "    all_trips$ended_at <- lubridate::as_datetime(all_trips$ended_at)\n",
    "```\n",
    "5. **Creating Additional Variables:** I derived several variables from the datetime columns, such as \"date,\" \"month,\" \"day,\" \"year,\" \"day_of_week,\" \"start_time,\" and \"end_time.\" These variables provide a structured foundation for further analysis.\n",
    "```\n",
    "all_trips <- all_trips %>%\n",
    "  mutate(\n",
    "    date = as.Date(started_at),\n",
    "    month = month(started_at),\n",
    "    day = day(started_at),\n",
    "    year = year(started_at),\n",
    "    day_of_week = wday(started_at, label = TRUE),\n",
    "    start_time = paste(hour(started_at), minute(started_at), sep = \":\"),\n",
    "    end_time = paste(hour(ended_at), minute(ended_at), sep = \":\"))\n",
    "```\n",
    "6. **Calculating Ride Lengths:** By calculating the difference between \"ended_at\" and \"started_at,\" I obtained ride lengths in both minutes and hours. These metrics will be instrumental in understanding ride patterns.\n",
    "```\n",
    "all_trips$length_min <- difftime(all_trips$ended_at, all_trips$started_at, units = \"mins\")\n",
    "    all_trips$length_min <- round(as.numeric(all_trips$length_min), 3)\n",
    "    all_trips$length_hr <- difftime(all_trips$ended_at, all_trips$started_at, units = \"hours\")\n",
    "    all_trips$length_hr <- round(as.numeric(all_trips$length_hr), 2)\n",
    "```\n",
    "## Data Aggregation\n",
    "\n",
    "Aggregating data allows us to extract summary statistics and gain a high-level view of the dataset. Here are the key aggregation steps I performed:\n",
    "\n",
    "- **Mean, Median, Max, Min Ride Lengths:** I calculated the mean, median, maximum, and minimum ride lengths for the entire dataset. These statistics provide a baseline understanding of ride durations.\n",
    "```\n",
    "    mean_ride_length <- mean(all_trips$ride_length)\n",
    "    median_ride_length <- median(all_trips$ride_length)\n",
    "    max_ride_length <- max(all_trips$ride_length)\n",
    "    min_ride_length <- min(all_trips$ride_length)\n",
    "```\n",
    "- **Aggregate by User Type:** I used the `aggregate` function to compute mean, median, maximum, and minimum ride lengths for both casual riders and members. This segmentation sheds light on user behavior and preferences.\n",
    "```\n",
    "    aggregate(all_trips$ride_length ~ all_trips$member_casual, FUN = mean)\n",
    "    aggregate(all_trips$ride_length ~ all_trips$member_casual, FUN = median)\n",
    "    aggregate(all_trips$ride_length ~ all_trips$member_casual, FUN = max)\n",
    "    aggregate(all_trips$ride_length ~ all_trips$member_casual, FUN = min)\n",
    "```\n",
    "## Data Transformation and Export\n",
    "\n",
    "To ensure seamless integration with visualization tools, I transformed the dataset and exported it for further analysis. The final dataset, named \"cyclist_data_tableau.csv,\" is ready for exploration and visualization using tools like Tableau.\n",
    "```\n",
    "    write.csv(all_trips, file = \"cyclist_data_tableau.csv\", row.names = FALSE)\n",
    "```\n",
    "By meticulously preparing the data, I have laid the foundation for insightful analysis in the subsequent phases of this project.\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "98a09711",
   "metadata": {
    "papermill": {
     "duration": 0.001622,
     "end_time": "2023-08-07T15:40:18.493500",
     "exception": false,
     "start_time": "2023-08-07T15:40:18.491878",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# Data Analysis Phase\n",
    "\n",
    "## Exploratory Data Analysis\n",
    "\n",
    "With a well-prepared dataset in hand, I conducted an exploratory data analysis to uncover meaningful insights about Cyclistic's ride patterns and user behavior.\n",
    "\n",
    "### Ride Patterns Over Time\n",
    "\n",
    "To understand how ride patterns change over time, I conducted the following analyses:\n",
    "\n",
    "1. **Day of the Week Analysis:** By examining ride lengths on different days of the week, I revealed variations in demand. This information can inform resource allocation and marketing strategies.\n",
    "\n",
    "### Ride Duration Analysis\n",
    "\n",
    "Ride duration is a key metric that sheds light on user preferences and behaviors. I explored this metric in depth:\n",
    "\n",
    "1. **Distribution of Ride Lengths:** Visualizing the distribution of ride lengths provides insights into common trip durations and potential outliers.\n",
    "\n",
    "2. **Average Ride Lengths by User Type:** Comparing ride lengths between casual riders and members reveals whether there are significant differences in usage patterns.\n",
    "\n",
    "## Summary Statistics and Insights\n",
    "\n",
    "### Key Findings\n",
    "\n",
    "1. **Monthly Trends:** The analysis revealed that ride counts generally increase during warmer months, suggesting a seasonal aspect to Cyclistic's usage.\n",
    "\n",
    "2. **Weekday vs. Weekend:** Ride counts are consistently higher on weekends compared to weekdays, indicating distinct user behavior patterns.\n",
    "\n",
    "3. **Ride Lengths:** The average ride length varies between casual riders and members, suggesting different usage intentions. Casual riders tend to have longer rides on average.\n",
    "\n",
    "## Recommendations for Action\n",
    "\n",
    "Based on the analysis, I recommend the following actions to Cyclistic:\n",
    "\n",
    "1. **Seasonal Promotions:** Capitalize on the seasonal nature of ride demand by offering promotions during peak months to attract more users.\n",
    "\n",
    "2. **Weekend Specials:** Introduce special offers or incentives on weekends to cater to increased weekend usage.\n",
    "\n",
    "3. **Membership Benefits:** Tailor membership benefits to address the varying ride patterns of casual riders and members.\n",
    "\n",
    "4. **Customer Engagement:** Leverage insights about ride lengths to create engaging content that resonates with different user segments.\n",
    "\n",
    "By understanding Cyclistic's ride patterns and user behaviors, the company can make informed decisions that drive customer satisfaction and business growth.\n",
    "[](http://)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "7422aad3",
   "metadata": {
    "papermill": {
     "duration": 0.001647,
     "end_time": "2023-08-07T15:40:18.496871",
     "exception": false,
     "start_time": "2023-08-07T15:40:18.495224",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# Results and Insights\n",
    "\n",
    "## Key Takeaways\n",
    "\n",
    "Completing this data analysis journey has provided valuable insights into Cyclistic's bike-sharing business. Here are the key takeaways from this project:\n",
    "\n",
    "1. **Seasonal Patterns:** The analysis revealed distinct seasonal trends in ride lengths, with higher usage during warmer months. This suggests that Cyclistic can plan targeted marketing campaigns and promotions to boost ridership during the peak season.\n",
    "\n",
    "2. **Weekday vs. Weekend:** Ride patterns showed consistent spikes in usage during weekends, indicating the popularity of leisure rides. Cyclistic can use this information to create tailored weekend promotions and offers.\n",
    "\n",
    "3. **User Segmentation:** Differentiating between casual riders and members allowed us to identify varying ride behaviors. Members tend to have shorter rides on average, while casual riders take longer rides. Cyclistic can tailor its services to these segments more effectively.\n",
    "\n",
    "4. **Engagement Opportunities:** Insights from ride duration analysis open doors to engage customers with relevant content. Cyclistic can create blog posts, social media content, or newsletter features that resonate with the different user types.\n",
    "\n",
    "## Business Recommendations\n",
    "\n",
    "Based on the comprehensive analysis performed in this project, I propose the following actionable recommendations for Cyclistic:\n",
    "\n",
    "1. **Targeted Marketing:** Utilize the knowledge of seasonal patterns to design marketing campaigns that effectively capture the attention of potential riders during peak months.\n",
    "\n",
    "2. **Weekend Promotions:** Introduce weekend-specific promotions to tap into the higher demand during those days, enticing users to take more rides.\n",
    "\n",
    "3. **Membership Benefits:** Tailor membership benefits to align with the usage patterns of members. Offer perks that cater to shorter rides or quick rides around the city.\n",
    "\n",
    "4. **Content Strategy:** Leverage the insights on ride duration to craft engaging content that speaks to the preferences and behaviors of casual riders and members.\n",
    "\n",
    "## Conclusion\n",
    "\n",
    "This case study served as a capstone project that allowed me to apply the skills and techniques learned throughout the program. By combining data preparation, exploration, and analysis, I was able to provide actionable insights to Cyclistic. The recommendations put forth are aimed at driving growth, enhancing customer experience, and boosting Cyclistic's position in the bike-sharing market.\n",
    "\n",
    "I am excited to have successfully completed this project and am confident in the value it brings to Cyclistic's decision-making processes. This experience further solidified my passion for data analytics and its power to drive meaningful change in businesses.\n",
    "\n",
    "Thank you for joining me on this data analysis journey with Cyclistic!\n"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.0.5"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 3.924008,
   "end_time": "2023-08-07T15:40:18.620860",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2023-08-07T15:40:14.696852",
   "version": "2.4.0"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
