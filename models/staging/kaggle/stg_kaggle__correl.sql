-- models/staging/kaggle/stg_kaggle__correl.sql
WITH raw_correl AS 
(
    SELECT 
    topic_id as id_topic, 
    -- probably can do some sort of transformation here it should be a list not a string --  
    -- sql doesn't natively use lists though -- 
    -- have to make the table better don't use lists -- 
    content_id as id_content 
FROM {{ source('kaggle', 'kaggle_correlation') }}
)

SELECT 
    * 
FROM raw_correl

