# -*- coding: utf-8 -*-
"""
Created on Mon Oct  5 06:41:35 2020
@author: spenc
"""
import pandas as pd
import numpy as np
import scipy.stats as st
import os

os.getcwd()
os.chdir("/Users/spenc/Documents/George Mason University/Fall 2020/AIT 580/AIT 580 Project")

# import the dataset
df = pd.read_csv("owid-covid-data.csv")
df.head(50)

# correlation analysis
y = df.corr(method = 'pearson', min_periods = 1)
print(y)

# drop all of the rows with missing values from the DataFrame
df_no_nulls = df.dropna()
# correlation between population density & total cases per million
r = np.corrcoef(df_no_nulls['population_density'], 
            df_no_nulls['total_cases_per_million'])
print(r)

st.pearsonr(df_no_nulls['population_density'], 
            df_no_nulls['total_cases_per_million'])



# create a scatterplot
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
# cd stands for current data, meaning
# all of the columns in the covid dataset for 9/23/20 only
cd = pd.read_csv("covid data for 9-23-20.csv")

# CFR stands for case fatality rate
GDPpc = cd['gdp_per_capita']
CFR = cd['total_deaths']/cd['total_cases']
print(CFR)

# scatterplot of gdp per capita vs case fatality rate
fig, ax = plt.subplots()
plt.scatter(GDPpc, CFR, s=1)
plt.title("COVID-19 Case Fatality Rate vs GDP per capita")
plt.xlabel("GDP per capita")
plt.ylabel("Case Fatality Rate")
formatter = ticker.FormatStrFormatter('$%1.0f')
ax.xaxis.set_major_formatter(formatter)
plt.gcf().set_size_inches((8, 7));

# scatterplot of log(GDP per capita) vs log(CFR)
lnGDPpc = np.log(GDPpc)
print(lnGDPpc)
lnCFR = np.log(CFR)
print(lnCFR)
plt.scatter(lnGDPpc, lnCFR, s=1)
plt.title("Log Case Fatality Rate vs Log GDP per capita")
plt.xlabel("Log of GDP per capita")
plt.ylabel("Log of Case Fatality Rate");


# scatterplot of total confirmed deaths per million vs GDP per capita
tdpm = cd['total_deaths_per_million']
# create the plot
fig, ax = plt.subplots()
plt.scatter(GDPpc, tdpm, s=1)
plt.title("Total Confirmed Covid-19 Deaths per Million vs GDP per capita")
plt.xlabel("GDP per capita")
plt.ylabel("Total Covid Deaths per Million")
formatter = ticker.FormatStrFormatter('$%1.0f')
ax.xaxis.set_major_formatter(formatter)
plt.gcf().set_size_inches((8, 7));

# log-log scatterplot of total deaths per million vs GDP per capita
lntdpm = np.log(tdpm)
plt.scatter(np.log(GDPpc), lntdpm, s=1)
plt.title("Total Covid-19 Deaths per Million of Population vs GDP per capita")
plt.xlabel("Log of GDP per capita")
plt.ylabel("Log of Total COVID-19 Deaths per Million");



# log-log scatterplot of case fatality rate vs GDP per capita,
# but with log base 10 instead of using the natural logarithm
cd_no_nulls = cd.dropna()
GDPpcnn = cd_no_nulls['gdp_per_capita']
logGDPpcnn = np.log10(GDPpcnn)
print(logGDPpcnn)
CFRnn = cd_no_nulls['total_deaths']/cd_no_nulls['total_cases']
logCFRnn = np.log10(CFRnn)
print(logCFRnn)
plt.scatter(logGDPpcnn, logCFRnn, s=1)
plt.title("Change in Case Fatality Rate vs Change in GDP per capita")
plt.xlabel("Log of GDP per capita")
plt.ylabel("Log of Case Fatality Rate");




# create a boxplot
US = pd.read_csv("All USA COVID-19 data query results.csv")
print(US)
import seaborn as sns
box = sns.boxplot(x='location', y='new_deaths', data=US)
box.set(ylabel="New Confirmed Covid Deaths")
box.set_title('The Range of New Daily Deaths from COVID-19 in the U.S.\
        \n (New Deaths is the Number of Confirmed Deaths Reported Per Day)');


China = pd.read_csv("All China COVID-19 data query results.csv")
b2=sns.boxplot(x='location',y='new_deaths',data=China)
b2.set(ylabel = "New Confirmed Covid Deaths")
b2.set_title('The Range of New Covid-19 Deaths per day in China');




