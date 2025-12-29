-- CREATE TABLE netflix (
--   show_id varchar(10),
--   type varchar(20),
--   title varchar(255),
--   director varchar(255),
--   cast text,
--   country varchar(255),
--   date_added varchar(50),
--   release_year INT,
--   rating varchar(20),
--   duration varchar(50),
--   listed_in varchar(255),
--   description text
-- );
-----copy netflix
-----from 'C:\temp\netflix_titles.csv'
------with (format csv, header true);

select * from netflix limit 10;

------alter table netflix
-------add column date_added_clean date;

update netflix 
set date_added_clean = to_date(date_added, 'FMMonth DD, YYYY')
Where date_added ~ '^[A-Za-z]+[0-9]{1,2}, [0-9]{4}$';

update netflix 
set date_added_clean = to_date(date_added, 'DD-Mon-YY')
Where date_added ~ '^[0-9]{1,2}-[A-Za-z]{3}-[0-9]{2}$';

select date_added, date_added_clean
From netflix
limit 10;

------Alter table netflix
------add column duration_minutes INT;


select column_name
from information_schema.columns
where table_name = 'netflix';

update netflix
set duration_minutes = cast(replace(duration, 'min', '') AS INT)
where duration like '% min';

select type, duration, duration_minutes
From netflix
limit 20;

Select type, duration, duration_minutes
From netflix
where type = 'Movie'
Limit 20;

-----Alter table netflix
------add column season int;

update netflix
set season = cast(REGEXP_replace(duration, '[^0-9]','','g')AS INT)
where duration Ilike '%season%';

--------Analysis queries

----Movies vs TV shows count
select type, count(*) as total_titles
from netflix
group by type;

-----Top 10 countries by number of Titles
select country, count(*) as total_titles
from netflix
where country is not null
group by country
order by total_titles desc
limit 10;

----titles by release year
select release_year, count(*) as total_titles
from netflix
group by release_year
order by release_year;

-----common genres
select trim(unnest(string_to_array(listed_in, ','))) as genre,
count(*) as total_titles
from netflix
group by genre
order by total_titles desc
limit 10;

-----active directors
select director, count(*) as total_titles
from netflix
where director is not null
group by director
order by total_titles desc
limit 10;

----which year added the most shows or movies on netflix?
select Extract (year from date_added_clean) as year_added,
count(*) as total_added
from netflix
group by year_added
order by total_added desc;

----Total TV show per number of seasons
select season, count(*) as total_shows
from netflix
where season is not null
group by season
order by season;

------countries with most movies
select country, count(*) as total_movies
from netflix
where type = 'Movie'
and country is not null
group by country
order by total_movies desc
limit 10;