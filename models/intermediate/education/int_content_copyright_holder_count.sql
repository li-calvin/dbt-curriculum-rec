{% set holders_query %}
    SELECT DISTINCT content_copyright_holder
    FROM {{ ref('stg_kaggle__content') }}
{% endset %}

{% set holders_result = run_query(holders_query) %}

{% if execute %}
{% set holders = holders_result.columns[0].values() %}
{% endif %}

WITH 
content AS (
    SELECT * FROM {{ ref('stg_kaggle__content') }}
), 
correlation AS (
    SELECT * FROM {{ ref('stg_kaggle__correlation') }}
), 

topic AS ( 
  SELECT * FROM {{ ref('stg_kaggle__topic') }}
),

-- look at only content that exist in the file not all of the contents in correlation 
topic_correlation_content AS (
  SELECT topic.id_topic, content.*
  FROM topic
  LEFT OUTER JOIN correlation ON topic.id_topic = correlation.id_topic
  LEFT OUTER JOIN content ON correlation.id_content = content.id_content 
),

copyright_holder_count AS (
    SELECT id_topic, 
    {% for holder in holders -%} 
        COUNT(
            CASE 
                WHEN content_copyright_holder = '{{ holder }}' 
                THEN 1 
                ELSE NULL 
            END
            ) AS {{holder | replace(" ", "_") | replace(",", "") | replace("-", "") | lower}}_holder_count,
    {%- endfor %}

    FROM topic_correlation_content
    GROUP BY id_topic
)

SELECT * FROM copyright_holder_count
