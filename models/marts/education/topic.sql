WITH 
kind_count AS (
    SELECT * FROM {{ ref('int_content_kind_count') }}
),

holder_count AS (
    SELECT * FROM {{ ref('int_content_copyright_holder_count') }}
),

topic AS (
    SELECT k.document_kind_count, k.video_kind_count, k.exercise_kind_count, 
    k.audio_kind_count, k.html5_kind_count, k.kind_total_count, h.*
    FROM kind_count k
    JOIN holder_count h
    ON k.id_topic = h.id_topic
)

SELECT * FROM topic 