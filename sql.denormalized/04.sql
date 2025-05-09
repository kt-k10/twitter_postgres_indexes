/*
 * Count the number of English tweets containing the word "coronavirus"
 */
SELECT
    count(*)
FROM tweets_jsonb
WHERE
    to_tsvector(
        'english',
        COALESCE(data->'extended_tweet'->>'full_text',
                 data->>'text'  -- Regular tweet text
        )
    ) @@ to_tsquery('english', 'coronavirus')  -- Match tweets that mention 'coronavirus'
    AND data->>'lang' = 'en';  -- Filter to only include tweets in English
