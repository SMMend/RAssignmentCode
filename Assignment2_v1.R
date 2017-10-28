#Using the dplyr and tidyr packages, perform all of the following in one or two chained (meaning, use the %>%  operator) series of functions. Note, the order of these operations is up to you, as long as you use all of them:
# . Column renaming with rename();
#. Column selection using select() and one of the select() helper functions (LINK);
#. Row-wise filtering using two conditions, combined with either | or &;
#. New column creation with mutate();
#. A grouped aggregation, grouping by two variables and creating two or more new #calculated variables;
#. Transforming the data from wide to long, or long to wide;
#. Row-wise reordering with arrange();

library(dplyr)
setwd("C:/Users/sybil/Desktop/R testcode/dow_jones_index")  #forward slashes.
dir()

#reading in the data
dow <- read.csv("dow_jones_index.csv")
dow

#mutate function- to add a new column
dow_price_change <- dow %>%
  select(quarter, stock, percent_change_price, percent_change_next_weeks_price, open ) %>%
  filter(quarter==1 & percent_change_price >2.0) %>%
  group_by(stock, quarter) %>%
  rename(price_open = open) %>%
  mutate(price_change= percent_change_price-percent_change_next_weeks_price) %>%
  summarize(avg_change = mean(price_change, na.rm=TRUE), 
            median_change = median(price_change, na.rm=TRUE)) %>%
  arrange(-avg_change)



#. Transforming the data from wide to long, or long to wide;
library(tidyr)
dow_price_change_wide <- dow_price_change %>%
  spread(stock, avg_change)
dow_price_change_wide

