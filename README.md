# Best Time to Meet Up

Suppose we have a CSV file with calendar events.  This file has the following format:
user id, begin time, end time
...

For example, the file may be 
100, 2017-04-03 13:30:00, 2017-04-03 14:30:00
101, 2017-04-15 00:00:00, 2017-04-15 23:59:59

The times listed in the file are times when each user is busy, in the format above. A single user may have several events listed and some events may overlap.  The file is not necessarily sorted by any of the fields in it. Write a program to read the CSV file (called calendar.csv) and find the longest block of time in a single day that's free for all the users to meet. Only look for meetings between 8AM and 10PM, on days up to one week from the date the program is run.

Write your code in Java, C#, C++, Python, or JavaScript.

# Compiling 
```
make
```

# Running

Ensure that calendar.csv is in the same directory.

```
./best_time_to_meet
```
