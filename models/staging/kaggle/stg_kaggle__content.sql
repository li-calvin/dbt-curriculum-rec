-- models/staging/kaggle/stg_kaggle__content.sql
WITH raw_content AS 
(
SELECT 
    id as id_content, 
    title as content_title, 
    description as content_description, 
    kind as cat_content_kind,
    text as content_text,
    copyright_holder as content_copyright_holder,
    license as id_content_license 
FROM {{ source('kaggle', 'kaggle_content') }}
) 

SELECT 
    * 
FROM raw_content

