/*
 * Calculates the hashtags that are commonly used with the hashtag #coronavirus
 */
SELECT '#' || tag AS tag, COUNT(*) AS count
FROM (
    SELECT DISTINCT
        data->>'id' AS id_tweet,  -- Get unique tweet ID
        hashtag ->> 'text' AS tag  -- Extract hashtag text
    FROM tweets_jsonb,
    LATERAL jsonb_array_elements(  -- Unnest hashtags from the JSON array
        COALESCE(
            data->'extended_tweet'->'entities'->'hashtags',  -- Check extended tweet hashtags
            data->'entities'->'hashtags',  -- Check regular tweet hashtags
            '[]'  -- Default to empty array if none found
        )
    ) AS hashtag
    WHERE
        data->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'  -- Filter tweets with the #coronavirus hashtag
        OR
        data->'extended_tweet'->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'  -- Include extended tweet hashtags
) t

GROUP BY tag
ORDER BY count DESC, tag
LIMIT 1000;
