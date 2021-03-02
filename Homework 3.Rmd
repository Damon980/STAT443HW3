---
title: "Homework 3"
author: "Damon O'Connor"
date: "2/28/2021"
output: html_document
---
github repository: https://github.com/Damon980/STAT443HW3

```{r setup, include=FALSE}
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(nycflights13))
suppressPackageStartupMessages(library(lubridate))
```
Different factors in the Flights data set were plotted against average delay. Departure delay was measured using arrival delay as planes normally have a packed schedule of flights to keep up with. Therefore if a plane lands 20 minutes late, it will take an extra 20 minutes for it to begin its next flight. Reductions in delays were found in the early morning hours, flights originating out of JFK and LGA, and flights carried by HA and AS.

```{r Main}
df = flights

#To start, I will look at the overall trend across all flights to find the time of day with fewest delays. Arrival delay will be used as an indicator of
#departure delay.

df %>% group_by(hour) %>% summarize(avgDelay = mean(arr_delay, na.rm = T)) %>% 
    ggplot(mapping = aes(x = hour, y = avgDelay))+
    geom_point()+
    geom_smooth()+
    theme_minimal()+
    xlab("Hour of day")+
    ylab("Average Delay")

#It appears taking early morning flights will result in the lowest average delay
```
From 5AM-10AM, the average arrival delay is actually negative, indicating the flight arrived before its scheduled arrival time. This would give airline workers extra time to prepare the plane for the next flight, leading to very few departure delays. For this reason, taking early morning flights will give the fewest possible delays. Delays will continue to grow throughout the day, peaking at around 8PM. If an evening flight is necessary, taking one later in the night will result in fewer delays.

```{r}
#What about airport?
df %>% group_by(origin) %>% summarize(avgDelay = mean(arr_delay, na.rm = T)) %>% 
    ggplot(mapping = aes(x = origin, y = avgDelay, fill = origin))+
    geom_bar(stat = "identity")+
    theme_minimal()+
    xlab("Flight Origin")+
    ylab("Average Delay")

#Avoiding flights out of EWR will help reduce delays, JFK and LGA are about the same.
```
Flights originating from EWR are going to have the highest delays. JFK and LGA have very similar average delays. It might be better to avoid EWR flights, but this makes a much smaller difference than the time of day.
```{r}
#What about airline?
df %>% group_by(carrier) %>% summarize(avgDelay = mean(arr_delay, na.rm = T)) %>% 
    ggplot(mapping = aes(x = carrier, y = avgDelay, fill = carrier))+
    geom_bar(stat = "identity")+
    theme_minimal()+
    xlab("Flight Carrier")+
    ylab("Average Delay")
#EV, F9, FL, and YV should be avoided to reduce delays.The best airlines are AS and HA.
```
It appears that HA and AS are the best airlines to take, but this trend is a bit deceiving because those airlines are Alaska and Hawaiian airlines. As they probably have very few flights per day, its easier to not have delays. Those airlines also won't be offering flights to more well-traveled places like Denver or LA. The best general purpose airlines are US and AA, which offer flights all over the lower 48 states.




