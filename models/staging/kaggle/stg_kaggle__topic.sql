-- models/staging/kaggle/stg_kaggle__topics.sql
SELECT *
FROM {{ source('kaggle', 'kaggle_topic') }}


