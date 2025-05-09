/*
 * Count the number of tweets that use #coronavirus in the denormalized schema
 */
SELECT count(distinct data->>'id')  -- Count distinct tweet IDs to ensure each tweet is only counted once
FROM tweets_jsonb
WHERE (
    -- Check if the tweet's regular hashtags contain 'coronavirus'
    data->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'  
    OR
    -- Check if the tweet's extended tweet (if it exists) contains 'coronavirus' in its hashtags
    data->'extended_tweet'->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'
);

