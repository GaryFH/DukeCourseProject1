#misc duke stuff

install.packages("devtools")

install.packages("dplyr")

install.packages("rmarkdown")

install.packages("ggplot2")

install.packages("broom")

install.packages("gridExtra")

install.packages("shiny")

install.packages("cubature")

library(devtools)

#install_github("StatsWithR/statsr")
library(dplyr)
library(ggplot2)
library(statsr)

data(arbuthnot)  #load data

dim(arbuthnot)

class(arbuthnot)

arbuthnot #view data

names(arbuthnot)


data(present)


present<-mutate(present,total=boys+girls)

present<-mutate(present,prop_boys=boys/total)

plot(y=present$prop_boys,x=present$year)

present<-mutate(present,more_boy=(boys>=girls))

present<-mutate(present,prop_boy_girl=boys/girls)

plot(x=present$year,y=present$prop_boy_girl)


arrange(present,total)




#WEEK 2


#using nycflights  data

data("nycflights")
nycflights


#Create a new data frame that includes flights headed to SFO in February, and save this data frame assfo_feb_flights. How many flights meet these criteria?
assfo_feb_flights<-filter(nycflights,dest=="SFO"&month=="2")

df1<-assfo_feb_flights
df1


#Make a histogram and calculate appropriate summary statistics for arrival delays of sfo_feb_flights. Which of the following is false?
hist(df1$arr_delay)

#
#Calculate the median and interquartile range for arr_delays of flights in the sfo_feb_flights data frame, grouped by carrier. Which carrier has the highest IQR of arrival delays?
#boxplot(arr_delay~carrier,df1)?

df11<-group_by(df1,carrier)
summarise(df11,iqr=IQR(arr_delay))





#Considering the data from all the NYC airports, which month has the highest average departure delay?Considering the data from all the NYC airports, which month has the highest average departure delay?
#Which month has the highest median departure delay from an NYC airport?

df2<-group_by(nycflights,month)
arrange(summarise(df2,meandelay=mean(dep_delay)),desc(meandelay))
arrange(summarise(df2,mediandelay=median(dep_delay)),desc(mediandelay))


df3<-group_by(nycflights,origin)


##If you were selecting an airport simply based on on time departure percentage, which NYC airport would you choose to fly out of?

df4<-mutate(df3,percontime=(dep_delay<=0))
df5<-summarise(df4,pertime=mean(percontime))


#Mutate the data frame so that it includes a new variable that contains the average speed, avg_speed traveled by the plane for each journey (in mph). What is the tail number of the plane with the fastest avg_speed? Hint: Average speed can be calculated as distance divided by number of hours of travel, and note that air_time is given in minutes. If you just want to show the avg_speed and tailnum and none of the other variables, use the select function at the end of your pipe to select just these two variables with select(avg_speed, tailnum). You can google this tail number to find out more about the aircraft.

df6<-arrange(mutate(nycflights,speed=distance/air_time),desc(speed))
head(df6$tailnum)


#Make a scatterplot of avg_speed vs. distance. Which of the following is true about the relationship between average speed and distance.

plot(x=df6$speed,y=df6$distance)



#Suppose you define a flight to be "on time" if it gets to the destination on time or earlier than expected, regardless of any departure delays. Mutate the data frame to create a new variable called arr_type with levels "on time" and "delayed" based on this definition. Also mutate to create a new variable called dep_type with levels "on time" and "delayed" depending on the flight was delayed for fewer than 5 minutes or 5 minutes or more, respectively. In other words, if arr_delay is 0 minutes or fewer, arr_type is "on time". If dep_delay is less than 5 minutes, dep_type is "on time". Then, determine the on time arrival percentage based on whether the flight departed on time or not. What fraction of flights that were "delayed" departing arrive "on time"? (Enter the answer in decimal point, like 0.xx)

df44<-mutate(df3,percontime=(dep_delay<5))
df7<-mutate(df44,arvontime=(arr_delay<=0))

df8T<-filter(df7,percontime=="TRUE")
df8F<-filter(df7,percontime=="FALSE")

answer<-mean(df8F$arvontime)



