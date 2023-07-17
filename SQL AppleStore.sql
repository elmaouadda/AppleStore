CREATE TABLE appleStore_description_combined (
    id INT,
    track_name VARCHAR(255),
    size_bytes BIGINT,
    app_desc VARCHAR(MAX)
);


-- the INSERT INTO statement
INSERT INTO appleStore_description_combined (id, track_name, size_bytes, app_desc)
SELECT id, track_name, size_bytes, app_desc FROM appleStore_description1
UNION ALL
SELECT id, track_name, size_bytes, app_desc FROM appleStore_description2
UNION ALL
SELECT id, track_name, size_bytes, app_desc FROM appleStore_description3
UNION ALL
SELECT id, track_name, size_bytes, app_desc FROM appleStore_description4;




--- Exploration Data Analysis

-- Checking the number of Unique apps in both TablesAppleStore 

select count(distinct id)
from AppleStore

select count(distinct id)
from appleStore_description_combined

-- Checking missing Values in both tables


select count(*) as MissingValues
from AppleStore
where track_name is null or user_rating is null or prime_genre is null

-- Find out the number of apps per genre

select prime_genre, count(*) as NumApps
from AppleStore
group by prime_genre
order by NumApps desc

-- General view of the apps' rating

select max(user_rating) as MaxRating
,min(user_rating) as MinRating
,avg(user_rating) as AvgRating
from AppleStore

-- Similarity between Paid and Free apps

SELECT 
    CASE 
        WHEN price > 0 THEN 'Paid'
        ELSE 'Free'
    END AS App_Type,
	AVG(user_rating)
FROM AppleStore
GROUP BY 
    CASE 
        WHEN price > 0 THEN 'Paid'
        ELSE 'Free'
    END;

-- Explore if apps supporting languages have higher ratings

SELECT 
    CASE 
        WHEN lang_num < 10 THEN '< 10 languages'
        WHEN lang_num BETWEEN 10 AND 30 THEN '10 - 30 languages'
        ELSE '30 languages'
    END AS Language_Status
	, count(*) as Count
FROM AppleStore
GROUP BY 
    CASE 
        WHEN lang_num < 10 THEN '< 10 languages'
        WHEN lang_num BETWEEN 10 AND 30 THEN '10 - 30 languages'
        ELSE '30 languages'
    END;

-- Checking Low Ratings

select TOP 10 prime_genre, avg(user_rating) as AvgRating
from AppleStore
group by prime_genre
order by AvgRating asc


-- The length of App Description and User Rating

select case
	when len(b.app_desc) < 500 then 'short'
	when len(b.app_desc) between 500 and 1000 then 'meduim'
	else 'long'
	End as Length_description,
	AVG(user_rating) as AvgRating

from AppleStore a
join appleStore_description_combined b
	on a.id=b.id
group by 

case
	when len(b.app_desc) < 500 then 'short'
	when len(b.app_desc) between 500 and 1000 then 'meduim'
	else 'long'
	End

order by AvgRating desc

--checking the top-rated app for each genre

SELECT prime_genre, track_name, user_rating
FROM (
    SELECT prime_genre, track_name, user_rating,
    RANK() OVER (PARTITION BY prime_genre ORDER BY user_rating DESC, rating_count_tot DESC) AS Rank
    FROM AppleStore
) AS a
WHERE a.Rank = 1;

















