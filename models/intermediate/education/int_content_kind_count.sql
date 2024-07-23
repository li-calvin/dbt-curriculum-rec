{% set kinds = ['document','video','exercise', 'audio', 'html5'] %}

WITH 
content AS (
    SELECT * FROM {{ref('stg_kaggle__content')}}
), 
correlation AS (
    SELECT * FROM {{ref('stg_kaggle__correlation')}}
), 

topic AS ( 
  SELECT * FROM {{ref('stg_kaggle__topic')}}
),

-- look at only content that exist in the file not all of the contents in correlation 
topic_correlation_content AS (
  SELECT topic.id_topic, content.*
  FROM topic
  LEFT OUTER JOIN correlation ON topic.id_topic = correlation.id_topic
  LEFT OUTER JOIN content ON correlation.id_content = content.id_content 
),

kind_count AS (
    SELECT id_topic, 

    {% for kind in kinds -%} 
        COUNT(
            CASE 
                WHEN cat_content_kind = '{{kind}}' 
                THEN 1 
                ELSE NULL 
            END
            ) 
            as {{kind}}_kind_count,
    {%- endfor %}

    COUNT(
        CASE 
            WHEN id_content IS NOT NULL 
            THEN 1 
            ELSE NULL 
        END
    ) AS kind_total_count

    FROM topic_correlation_content
    GROUP BY id_topic
)

SELECT * FROM kind_count


