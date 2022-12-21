# set working directory
setwd("/Users/spenc/Documents/George Mason University/Fall 2020/AIT 580/AIT 580 Project")

# read the data from the covid data file that just has all
# of the aggregate figures from 9/23/2020, so I can calculate
# the current worldwide fatality rate easily
current_data <- read.csv("covid data for 9-23-20.csv")
head(current_data)
class(current_data)

# calculate the current worldwide CFR from covid
ctd <- current_data$total_deaths
ctc <- current_data$total_cases
cwcfr <- sum(ctd, na.rm = TRUE)/sum(ctc, na.rm = TRUE)
cwcfr


# import the csv data file into RStudio and store it in a DataFrame
data <- read.csv("owid-covid-data.csv")
attach(data) #attach the dataset

summary(data)
head(data)
tail(data)
class(data)

# What is the average fatality rate for COVID-19 worldwide?
tdpm <- data$total_deaths_per_million
tcpm <- data$total_cases_per_million
global_death_rate <- mean(tdpm/tcpm, na.rm = TRUE)
global_death_rate
# display the death rate as a percentage
library(scales)
label_percent()(global_death_rate)

# calculate the same thing another way as a sanity check
td <- data$total_deaths
tc <- data$total_cases
global_death_rate2 <- mean(td/tc, na.rm = TRUE)
global_death_rate2
label_percent()(global_death_rate2)

# calculate the current cumulative CFR worldwide
global_CFR <- max(td, na.rm = TRUE)/max(tc, na.rm = TRUE)
global_CFR


# calculate the case fatality rate (CFR) for Mexico
d.Mexico <- data[data$location == "Mexico", ]
td_Mex <- d.Mexico$total_deaths
tc_Mex <- d.Mexico$total_cases
CFR_Mex <- mean((td_Mex/tc_Mex), na.rm = TRUE)
CFR_Mex
label_percent()(CFR_Mex)

library(ggplot2)
# instantaneous/daily case fatality rate
daily_CFR_Mex <- list(td_Mex/tc_Mex)
daily_CFR_Mex
ggplot(data = d.Mexico, aes(x=date, y=daily_CFR_Mex))+
  geom_line(color = "#00AFBB", size = 2)
library(dplyr)

# calculate the case fatality rate (CFR) for the U.S.
d.USA <- data[data$location == "United States", ]
td_USA <- d.USA$total_deaths
tc_USA <- d.USA$total_cases
CFR_USA <- mean((td_USA/tc_USA), na.rm = TRUE)
CFR_USA
label_percent()(CFR_USA)

# calculate the case fatality rate (CFR) for Canada
d.Can <- data[data$location == "Canada", ]
td_Can <- d.Can$total_deaths
tc_Can <- d.Can$total_cases
CFR_Can <- mean((td_Can/tc_Can), na.rm = TRUE)
CFR_Can
label_percent()(CFR_Can)


# correlation analysis 
help(cor)
# correlation between population density & total cases per million
d <- population_density
r <- cor(d, tcpm, method = "pearson", use = "complete.obs")
r
cor(population_density, total_cases_per_million, method = "pearson", use = "complete.obs")
# conduct a correlation hypothesis test to double check my reading of the 
# strength of the correlation
test <- cor.test(population_density, total_cases_per_million, method = "pearson", use = "complete.obs")
test


# correlation between per capita income & deaths per million
gdppc <- gdp_per_capita
cor(gdppc, tdpm, method = "pearson", use = "complete.obs")



# Regression Analysis
# simple linear regression first
stringency <- stringency_index
# create the SLR and assign it to an object
SLR <- lm(tdpm ~ stringency)
coef(SLR)
summary(SLR)
plot(SLR)
plot(stringency, tdpm)


# assign all of the regressors to new R variables with shorter names
age <- median_age
old <- aged_70_older
poverty <- extreme_poverty
diabetes <- diabetes_prevalence
HDI <- human_development_index
# create the multiple linear regression model and assign it to an object
model <- lm(tdpm ~ stringency + age + old + poverty + diabetes + HDI)
coef(model)
summary(model)
plot(model)

# create a multiple linear regression model and assign it to a variable
# this time, try to explain total deaths as the dependent variable
# instead of total deaths per million
model <- lm(td ~  age + old + poverty + diabetes + HDI)
coef(model)
summary(model)
plot(model)

# create a multiple regression model and assign it to an object
# for this model, back to total deaths per million and remove diabetes prevalence,
# stringency index, & human development index from the list of eplanatory variables
# included and add gdp per capita to the included list
model <- lm(tdpm ~  age + old + gdppc + poverty)
coef(model)
summary(model)
plot(model)






# Hypothesis Test
# Test the implicit hypothesis within the common claim
# that the SARS-CoV-2 virus is no more dangerous than 
# your standard seasonal influenza virus strains
# that make their way through the American population every year.

# Calculate the case fatality rate of the seasonal flu in 
# the U.S. during the 2020 flu season (from 10/1/19 to 4/4/20)
# using estimates of total flu deaths and total flu cases
# from the U.S. Center for Disease Control aka the CDC.
fluCFR <- (55000/51000000)
fluCFR
library(scales)
label_percent()(fluCFR)

# I will use a t-test here
US_CFR_data <- read.csv("US CFR data.csv")
t.test(x = US_CFR_data, mu = 0.001078431, alternative = "greater")

t.test(x = US_CFR_data, mu = fluCFR, alternative = "greater")


