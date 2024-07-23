-- {% macro generate_topic_hierarchy(id_topic_column) -%}
-- {% set query %}
-- WITH RECURSIVE hierarchy AS (
--     SELECT t1.id_topic, t1.id_topic_parent, t1.val_topic_level, t1.cat_topic_title
--     FROM {{ ref('stg_kaggle__topic') }} t1
--     WHERE t1.id_topic = {{ id_topic }}

--     UNION ALL

--     SELECT t2.id_topic, t2.id_topic_parent, t2.val_topic_level, t2.cat_topic_title
--     FROM {{ ref('stg_kaggle__topic') }} t2
--     JOIN hierarchy h ON t2.id_topic = h.id_topic_parent
-- )
-- SELECT 
--     TO_JSON_STRING(
--         ARRAY_AGG(
--             STRUCT(
--                 id_topic,
--                 id_topic_parent,
--                 val_topic_level,
--                 cat_topic_title
--             )
--         )
--     ) AS hierarchy_json
-- FROM hierarchy
-- {% endset %}

-- {{ return(query) }}
-- {%- endmacro %}

