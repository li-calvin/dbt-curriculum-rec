-- models/staging/kaggle/stg_kaggle__content.sql
SELECT *
FROM {{ source('kaggle', 'kaggle_content') }}


