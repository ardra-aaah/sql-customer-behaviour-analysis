# Free-to-Paid Conversion Rate Analysis

## Overview
This SQL project analyses student behavior on a learning platform to determine conversion rates and engagement patterns.

## Objective

- Identify how quickly students watch content after registration.
- Measure conversion from watching to purchasing.
- Calculate average time between key milestones.

## Key Metrics Calculated
- **Free-to-Paid Conversion Rate**: Percentage of students who purchased the course after watching a lecture.
- **Average Registration-to-Engagement Time**: How long it takes students to watch their first lecture.
- **Average Engagement-to-Purchase Duration**: How long students take to subscribe after first engaging.

##  Project Flow: Funnel Stages


This project tracks student behavior across three key stages on a learning platform:

1. **Registration** – Student signs up on the platform.
2. **First-Time Engagement** – Student watches their first lecture.
3. **Subscription Purchase** – Student buys a subscription to access full course content.

Using this flow, I performed a funnel analysis to:
- Calculate the **Free-to-Paid Conversion Rate**
- Measure the **average time** between registration and engagement
- Analyse the **delay** between engagement and purchasing

| **Funnel Stage**        | **Data Analysed**                                          | **What It Measures**                    |
|-------------------------|------------------------------------------------------------|-----------------------------------------|
| 1. Watched a Lecture     | Students with `first_date_watched`                         | Entry into the funnel                   |
| 2. Purchased Later       | Students with `first_date_purchased > first_date_watched` | Progression or Drop-off                 |
|    Output                | Count & % of converting students                          | Free-to-Paid Conversion Rate, Time Gaps |

Thus, the project begins by identifying students who engaged by watching a lecture.  
It then tracks how many of them went on to make a purchase, and how long it took.  
The goal is to understand user behavior and calculate conversion metrics.


## Tools Used
- SQL (MySQL)
- Aggregate functions, subqueries, conditional logic
- Funnel analysis concepts

## Files

- [`query.sql`](query.sql): Main SQL query.
- `query_output.png`: Output screenshot from SQL execution.
## Query Outputs

### Output 1
![Output 1](output1.png)

### Output 2
![Output 2](output2.png)

### Output 3
![Output 3](output3.png)

### Output 4
![Output 4](output4.png)

### Output 5
![Output 5](output5.png)

 
