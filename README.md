# netflix-analytics-dashboard

Power BI, PostgreSQL, SQL, DAX

This project analyzes Netflix’s catalog using SQL for data cleaning and Power BI for interactive visualization.
It demonstrates an end-to-end BI workflow: data extraction - cleaning - modeling - dashboard development.

Tools & Technologies

- PostgreSQL – Data cleaning, transformation, and querying
- Power BI – Dashboard design & interactive visuals
- DAX – KPI calculations and analytical measures
- SQL – ETL processing and data preparation

Project Overview

This dashboard is built using a cleaned PostgreSQL dataset of 8,000+ Netflix titles.
It provides insights into:

- Movies vs. TV Shows
- Content growth over time
- Top genres
- Countries producing the most titles
- Directors with the most shows/movies
- The goal was to build a clean, professional BI dashboard suitable for real business use.

SQL Data Cleaning (ETL Steps):

- Convert raw date strings into proper dates

UPDATE netflix

SET date_added_clean = TO_DATE(date_added, 'Mon DD, YYYY')

WHERE date_added ~ '^[A-Za-z]{3} [0-9]{1,2}, [0-9]{4}$';

- Extract movie duration (minutes)

UPDATE netflix

SET duration_minutes = CAST(REGEXP_REPLACE(duration, '[^0-9]', '', 'g') AS INT)

WHERE duration ILIKE '%min%';

- Extract number of seasons

UPDATE netflix

SET seasons = CAST(REGEXP_REPLACE(duration, '[^0-9]', '', 'g') AS INT)

WHERE duration ILIKE '%season%';

Power BI Dashboard Features

KPI Cards
- Total Titles

Visuals Include

- Line Chart: Titles added over time
- Map: Titles by country
- Top Genres bar visual
- Top Directors table

Slicers / Filters
- Country
- Type (Movie / TV Show)
- Release Year

Key Insights
- Movies represent the majority of Netflix content.
- India and the USA are the top-producing countries.
- Dramas and comedies appear most frequently across titles.
- Content grew significantly from 2015 to 2020.

How to Use
- Download the .pbix file
- Open in Power BI Desktop
- (Optional) Update PostgreSQL connection
- Explore the interactive dashboard

