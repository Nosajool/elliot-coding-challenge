# Best Time to Meet Up

Suppose we have a CSV file with calendar events.  This file has the following format:
user id, begin time, end time
...

For example, the file may be 
100, 2017-04-03 13:30:00, 2017-04-03 14:30:00
101, 2017-04-15 00:00:00, 2017-04-15 23:59:59

The times listed in the file are times when each user is busy, in the format above. A single user may have several events listed and some events may overlap.  The file is not necessarily sorted by any of the fields in it. Write a program to read the CSV file (called calendar.csv) and find the longest block of time in a single day that's free for all the users to meet. Only look for meetings between 8AM and 10PM, on days up to one week from the date the program is run.

Write your code in Java, C#, C++, Python, or JavaScript.

# Ruby

I wrote this in Ruby because I did not want to do csv or date parsing but will update this repo to solve in C++ if I have time.

## Running

```
ruby best_time_to_meet.rb
```

# C++

## Compiling
```
make
```

## Running

Ensure that calendar.csv is in the same directory.

```
./best_time_to_meet
```

# Algorithm

I use a greedy solution to sort the events by the starting time. I add events from 0:00:00 to 8:00:00 and from 22:00:00 to 24:00:00 to represent times where nobody is free.

While iterating through the events in ascending order of start time, if an ending time is greater than the latest end time we've encountered, we update it. If we see a start time that is later than the latest end time, we've found a gap in the schedule where no one is at an event. We can check to see if it is the largest gap or not.

There are a couple of circuit breaks employed to exit early if we see events that we do not care about; Events that are in the past or 1 week in the future.

The running time of the algorithm where n is the number of events is calculated as follows:

O(n) to read in the events.
O(1) to add a weeks worth of blackout events
O(nlogn) to sort the events by ascending starting time
O(n) to determine the largest gap

Overall, the running time is O(nlogn) where the bottleneck is sorting the events by ascending start time.

