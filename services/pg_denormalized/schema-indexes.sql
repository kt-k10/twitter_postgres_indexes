
 -- (Indexes for denormalized for problems1-5(I think some of these are redundant)


CREATE INDEX idx_tweets_jsonb_hashtags_entities ON tweets_jsonb USING gin (
    COALESCE(data->'entities'->'hashtags', '[]') 
);

CREATE INDEX idx_tweets_jsonb_hashtags_extended_tweet ON tweets_jsonb USING gin (
    COALESCE(data->'extended_tweet'->'entities'->'hashtags', '[]') 
);



CREATE INDEX idx_tweets_jsonb_id_tweets ON tweets_jsonb ((data->>'id'));



CREATE INDEX idx_tweets_jsonb_hashtags ON tweets_jsonb USING gin ((data->'entities'->'hashtags'));



CREATE INDEX idx_tweets_jsonb_extended_hashtags ON tweets_jsonb USING gin ((data->'extended_tweet'->'entities'->'hashtags'));




CREATE INDEX idx_tweet_tags_tag ON tweet_tags (tag);



CREATE INDEX idx_tweets_lang ON tweets_jsonb USING btree (data->>'lang');




CREATE INDEX tweets_jsonb_to_tsvector_data_extended_tweet_full_text ON tweets_jsonb USING GIN(to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text', data->>'text')));


CREATE INDEX idx_tweets_hashtags ON tweets_jsonb USING gin (
    (COALESCE(data->'entities'->'hashtags', '[]') || COALESCE(data->'extended_tweet'->'entities'->'hashtags', '[]'))


CREATE INDEX idx_tweets_id ON tweets_jsonb USING btree (data->>'id');




-- Index for full-text search on the 'text' field in the tweets_jsonb table
CREATE INDEX idx_tweets_jsonb_fts_en ON tweets_jsonb USING gin (to_tsvector('english', data->>'text'));

-- Index for lang field in the tweets_jsonb table (for filtering by language)
CREATE INDEX idx_tweets_jsonb_lang ON tweets_jsonb (data->>'lang');


CREATE INDEX idx_tweet_tags_id_tweets ON tweet_tags(id_tweets);


CREATE INDEX idx_tweets_fts_en ON tweets USING gin(to_tsvector('english', text));


CREATE INDEX idx_tweets_lang ON tweets(lang);


CREATE INDEX idx_tweet_tags_tag ON tweet_tags(tag);


CREATE INDEX idx_tweets_jsonb_data_lang ON tweets_jsonb ((data->>'lang'));

CREATE INDEX idx_tweets_jsonb_data_extended_tweet_ent_hashtag ON tweets_jsonb USING GIN((data->'extended_tweet'->'entities'->'hashtags'));




