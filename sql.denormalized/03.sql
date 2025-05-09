/*
 * Calculates the languages that use the hashtag #coronavirus
 */
SELECT
    data->>'lang' AS lang,
    count(DISTINCT data->>'id') AS count
FROM tweets_jsonb
-- Extract the hashtags from both the standard and extended tweet entities
JOIN LATERAL jsonb_array_elements(
    COALESCE(data->'entities'->'hashtags', '[]') ||
    COALESCE(data->'extended_tweet'->'entities'->'hashtags', '[]')
) AS hashtags ON true
WHERE
    data->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'
    OR data->'extended_tweet'->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'
GROUP BY lang
ORDER BY count DESC, lang;

