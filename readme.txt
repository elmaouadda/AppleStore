# GitHub Repository Readme

This repository contains scripts and queries for analyzing and exploring the Apple Store dataset. The dataset consists of information about various apps available on the Apple Store, including details such as app name, genre, user rating, and more.

## Dataset

The dataset is split into multiple tables, including `AppleStore` and `appleStore_description_combined`. The `AppleStore` table contains general information about the apps, while the `appleStore_description_combined` table combines descriptions from multiple sources. The schema for the `appleStore_description_combined` table is as follows:

```sql
CREATE TABLE appleStore_description_combined (
    id INT,
    track_name VARCHAR(255),
    size_bytes BIGINT,
    app_desc VARCHAR(MAX)
);
```

To populate the `appleStore_description_combined` table, you can use the following `INSERT INTO` statement, which combines data from multiple source tables:

```sql
INSERT INTO appleStore_description_combined (id, track_name, size_bytes, app_desc)
SELECT id, track_name, size_bytes, app_desc FROM appleStore_description1
UNION ALL
SELECT id, track_name, size_bytes, app_desc FROM appleStore_description2
UNION ALL
SELECT id, track_name, size_bytes, app_desc FROM appleStore_description3
UNION ALL
SELECT id, track_name, size_bytes, app_desc FROM appleStore_description4;
```

## Exploration Data Analysis

The repository provides a set of SQL queries to perform exploratory data analysis on the Apple Store dataset. Some of the analysis queries included are:

- Checking the number of unique apps in both `AppleStore` and `appleStore_description_combined` tables.
- Finding missing values in the `AppleStore` table for specific columns like `track_name`, `user_rating`, and `prime_genre`.
- Analyzing the number of apps per genre.
- Obtaining general statistics about the apps' ratings, including the maximum, minimum, and average ratings.
- Exploring the similarity between paid and free apps based on user ratings.
- Analyzing if apps supporting different numbers of languages have higher ratings.
- Checking the lowest-rated genres based on average ratings.
- Investigating the relationship between the length of app descriptions and user ratings.
- Finding the top-rated app for each genre.

Feel free to explore and use these queries to gain insights from the Apple Store dataset.

## How to Use

To use this repository, you can clone or download the files and run the provided SQL queries on your database management system. Make sure to update the queries or modify the table/column names as per your specific dataset schema.

Please note that this repository does not provide the dataset itself. You will need to obtain the Apple Store dataset separately to execute the queries successfully.

## Contribution

If you find any issues or have suggestions for improvement, feel free to open an issue or submit a pull request. Contributions are welcome!