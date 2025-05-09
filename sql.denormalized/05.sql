/*
 * Calculates the hashtags that are commonly used for English tweets containing the word "coronavirus"
 */
SELECT
    tag,
    COUNT(*) AS count
FROM (
    SELECT DISTINCT
        data->>'id' AS tweet_id,  -- Get unique tweet ID to prevent double-counting
        '#' || (hashtags->>'text') AS tag  -- Extract hashtag text and prepend a '#' symbol
    FROM tweets_jsonb,
    LATERAL jsonb_array_elements(
        COALESCE(data->'entities'->'hashtags', '[]') ||  -- Grab regular hashtags (if any)
        COALESCE(data->'extended_tweet'->'entities'->'hashtags', '[]')  -- Combine with extended tweet hashtags (if any)
    ) AS hashtags  -- This creates a row for each hashtag in a tweet
    WHERE to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text', data->>'text')) 
          @@ to_tsquery('english','coronavirus')  -- Search for tweets containing 'coronavirus'
      AND data->>'lang' = 'en'  -- Restrict to English tweets
) AS t
GROUP BY tag
ORDER BY count DESC, tag
LIMIT 1000;
