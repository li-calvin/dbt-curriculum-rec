-- models/staging/kaggle/stg_kaggle__correl.sql
SELECT *
FROM {{ source('kaggle', 'kaggle_correlation') }}

