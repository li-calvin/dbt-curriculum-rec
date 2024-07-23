WITH 
content AS (
    SELECT * FROM {{ ref('stg_kaggle__content') }}
),

correlation AS (
    SELECT * FROM {{ ref('stg_kaggle__correl') }}
),

hierarchy AS (
    SELECT * FROM {{ ref('int_topic_generate_hierarchy') }}
),

combined_content AS ( 
    SELECT content.*, correlation.id_topic, hierarchy.json_hierarchy
    FROM content 
    LEFT OUTER JOIN correlation ON content.id_content = correlation.id_content
    LEFT OUTER JOIN hierarchy ON correlation.id_topic = hierarchy.id_topic
)

SELECT * FROM combined_content



