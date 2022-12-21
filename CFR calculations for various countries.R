# set working directory
setwd("/Users/spenc/Documents/George Mason University/Fall 2020/AIT 580/AIT 580 Project")

# load the Mexican data from the results of the SQL query I ran to isolate it
Mexico <- read.csv("All Mexico COVID-19 data query results.csv")
# calculate the current case fatality rate (CFR) for Mexico
td_Mex <- Mexico$total_deaths
tc_Mex <- Mexico$total_cases
CFR_Mex <- max(td_Mex)/max(tc_Mex)
CFR_Mex

# load the American data from the results of the SQL query I ran to isolate it
USA <- read.csv("All USA COVID-19 data query results.csv")
# calculate the current case fatality rate (CFR) for the United States
td_US <- USA$total_deaths
tc_US <- USA$total_cases
CFR_US <- max(td_US)/max(tc_US)
CFR_US

# load the Canadian data from the results of the SQL query I ran to isolate it
Canada <- read.csv("All Canada COVID-19 data query results.csv")
# calculate the current case fatality rate for Canada
td_Canada <- Canada$total_deaths
tc_Canada <- Canada$total_cases
CFR_Canada <- max(td_Canada)/max(tc_Canada)
CFR_Canada









