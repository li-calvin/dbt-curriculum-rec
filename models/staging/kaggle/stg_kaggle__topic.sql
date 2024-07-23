-- models/staging/kaggle/stg_kaggle__topics.sql
WITH raw_topics AS 
(
SELECT  
    id as id_topic, 
    title as topic_title, 
    description as topic_description, 
    channel as id_topic_description, 
    -- already encoded don't need to use case when -- 
    category as cat_topic_category, 
    level as val_topic_level, 
    parent as id_topic_parent, 
    has_content as ind_topic_has_content
FROM {{ source('kaggle', 'kaggle_topic') }}
) 

SELECT 
    *
FROM raw_topics 
