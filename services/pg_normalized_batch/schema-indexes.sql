CREATE INDEX idx_tweet_tags_idtag ON public.tweet_tags USING btree (id_tweets, tag);

CREATE INDEX idx_lang_tweets ON public.tweets USING btree (id_tweets, lang);

CREATE INDEX idx_tweet_tags_tag ON public.tweet_tags USING btree (tag);

CREATE INDEX idx_tweet_tags_tag_id ON public.tweet_tags USING btree (tag, id_tweets);

CREATE INDEX idx_tweets_id ON public.tweets USING btree (id_tweets);

CREATE INDEX idx_tweets_lang_id ON public.tweets USING btree (lang, id_tweets);

CREATE INDEX idx_tweets_lang ON public.tweets USING btree (lang);

CREATE INDEX idx_tweets_fts_en ON public.tweets USING gin (to_tsvector('english', text));

