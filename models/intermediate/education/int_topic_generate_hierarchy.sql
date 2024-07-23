WITH RECURSIVE hierarchy AS (
    SELECT 
        t1.id_topic, 
        t1.id_topic_parent, 
        t1.val_topic_level, 
        t1.topic_title,
        t1.id_topic AS root_id_topic
    FROM dbt_curriculum_rec.stg_kaggle__topic t1

    UNION ALL

    SELECT 
        t2.id_topic, 
        t2.id_topic_parent, 
        t2.val_topic_level, 
        t2.topic_title,
        h.root_id_topic
    FROM dbt_curriculum_rec.stg_kaggle__topic t2
    JOIN hierarchy h ON t2.id_topic = h.id_topic_parent
)
SELECT 
    root_id_topic as id_topic,
    TO_JSON_STRING(
        ARRAY_AGG(
            STRUCT(
                id_topic,
                id_topic_parent,
                val_topic_level,
                topic_title
            )
        )
    ) AS json_hierarchy
FROM hierarchy
GROUP BY root_id_topic
