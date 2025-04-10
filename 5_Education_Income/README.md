# Project : Education and income relation

This project is my first project with real data. I got the data from [Educational Attainment and income](https://catalog.data.gov/dataset/ca-educational-attainment-personal-income).
This table contains age brackets, income range, educational attainment, gender, year. Using python, I explored relations.

# Questions

Those are I'm interested to explore.
1. Does educational level affect to income?
2. Yearly change of educational attainment and income.
3. Education and income difference between gender.
4. Age and income difference.

# Tools I used

- Excel : To start, I used excel to explore NaN data and data categories. For meaningful data, I removed children data from excel.
- Python:: I used following libraries:
    - Pandas : To analyze and clean data.
    - Matplotlib and Seaborn : To visualize data.
- Visual Studio Code : Excute python and to include Jupyter Notebooks.
- GitHub : I share my code and visualization on repository

# Data Preparation and Clean

I got the data as CSV file and removed children data for better analysis.

## Import libraries & Clean Data

Import necessary libraries and load dataset, then initial data cleaning to better use.


``` python
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt  

from adjustText import adjust_text
from matplotlib.ticker import PercentFormatter, FuncFormatter

df = pd.read_csv(r'C:\Users\Dell\DA_FILE\100_My_Project\5_Education_Income\working sheet.csv')
df['Year']=pd.to_datetime(df['Year']).dt.year
# Yearly data, so just extract year from date

incomes= {'0': '0',
          '$5,000 to $9,999': '5k-10k',
          '$10,000 to $14,999':'10k-15k',
          '$15,000 to $24,999' :'15k-25k',
          '$25,000 to $34,999' :'25k-35k',
          '$35,000 to $49,999' :'35k-50k',
          '$50,000 to $74,999' :'50k-75k',
          '$75,000 and over' :'75k+'}

#Replace them for better visualization
df['income']=df['Personal Income'].replace(incomes)

#drop the row where no population
df = df.dropna()


sorted =['0', '5k-10k', '10k-15k', '15k-25k', '25k-35k', '35k-50k', '50k-75k','75k+']
deg_sorted= ['No high school diploma','High school or equivalent', 
             'Some college, less than 4-yr degree',"Bachelor's degree or higher"]

```

# Analysis

## 1. Does educational level affect to income?

To find out the relation between educational attainment and income, I summed up the population on the dataset which contains 2008 to 2014. This query will show me how the relation is it.

Check my full code here : [Education and Income](5_Education_Income/1_EDA.ipynb)



```python

df_edu = df.pivot_table(values='Population Count',aggfunc='sum',index='Educational Attainment',columns='income')


df_edu.plot(kind='line')
plt.title('Total population by Educational attainment', fontsize=20)
plt.xlabel('Income ($)')

plt.ylabel('Popluation')
plt.gca().yaxis.set_major_formatter(FuncFormatter(lambda x, pos : f'{(x/1000000):.1f}M'))

```

![result](FIXTHIs: income and education pop)

*line chart income range and population by educational attainment.*
### Insights:

!!!!!FIX TJISTSIS



## 2. Yearly change of educational attainment and income.

How does population had changed from 2008 to 2014? I will explore the yearly population by educational attainment and income range. 

Check my full code here : [Yearly change of Education and Income](5_Education_Income/2_Education_level_and_Income.ipynb)



```python

df_total_year = df.pivot_table(index='Year',columns='Educational Attainment', values='Population Count', aggfunc='sum')

sns.color_palette('Set1')
df_total_year.plot(lw=2)
plt.title('Yearly distribution of education level', fontsize=20)
plt.xlabel('')
plt.ylabel('Population')
plt.gca().yaxis.set_major_formatter(FuncFormatter(lambda x, pos : f'{float(x/1000000):.1f}M'))

```

![result](FIXTHIs:Yearly distribution of education level)

*line chart Yearly distribution of education level.*


```python
df_year_income = df.pivot_table(
    index='Year',columns='income', values='Population Count', aggfunc='sum'
    ).reindex(sorted, axis=1)
df_year_income


sns.color_palette('Set1')
df_year_income.plot(lw=2)
plt.title('Yearly population of income range', fontsize=20)
plt.xlabel('')
plt.ylabel('Population')
plt.legend(title='Income ($)',loc='upper right', bbox_to_anchor=(1.25, 1))
plt.gca().yaxis.set_major_formatter(FuncFormatter(lambda x, pos : f'{float(x/1000000):.1f}M'))

```

![result](FIXTHIs: Yearly population of income range)

*line chart Yearly population of income range.*


### Insights:

!!!!!FIX TJISTSIS



## 3. Education and income difference between gender.

To find out the difference between gender, I did looked up the distrubution first. Then I visualized the data to compare income distribution.

Check my full code here : [Gender and Income](5_Education_Income/3_Gender_Income.ipynb)



```python
df_gen = df.pivot_table(index='Gender',values='Population Count',aggfunc='mean',columns='Educational Attainment')

sns.set_style('ticks')
fig, ax = plt.subplots(1,4,figsize=(15,5))

for i, deg in enumerate(deg_sorted):
    df_plot = df_gen[deg]
    ax[i].pie(df_plot,autopct='%1.1f%%', startangle=90, labels=['Female','Male'], labeldistance=0.9 )
    ax[i].set_title(deg)


plt.suptitle("Education rate between Gender",fontsize=22)
plt.show()



```
![result](FIXTHIs: Education rate between Gender)

*Pie chart to see if there is educational difference.*



![result](FIXTHIs: E"Total income distribution 2008-2014)

*Pie chart to see if there is educational difference.*
### Insights:

!!!!!FIX TJISTSIS


## 4. Age and income difference.
To look up if there is income difference by age bracket. I removed under 18 bracket to use validated data.

Check my full code here : [Education and Income](5_Education_Income/4_Age.ipynb)

```python
df_1880_pie = df_1880.groupby('Educational Attainment')['Population Count'].sum().to_frame().reindex(deg_sorted)
plt.gca().pie(df_1880_pie['Population Count'],autopct='%1.1f%%', startangle=90, labels=df_1880_pie.index)
plt.title("Age over 17 Education distribution")
plt.show()

```
![result](FIXTHIs: Age over 17 Education distribution)

*line chart income range and population by educational attainment.*


```python

df_1880_pivot = df_1880.pivot_table(
    values='Population Count',index='Educational Attainment', columns='income', aggfunc='sum'
                                      ).reindex(deg_sorted).reindex(sorted, axis=1)
df_1880_pivot.T.plot()
plt.title('Age over 17 income range by educational attainment')
plt.ylim(0,19000000)
plt.gca().yaxis.set_major_formatter(FuncFormatter(lambda x, pos : f'{(x/1000000):.0f}M'))
plt.xlabel('Income ($)')
plt.show()
```

![result](FIXTHIs: income and education pop)

*line chart income range and population by educational attainment.*
### Insights:

!!!!!FIX TJISTSIS