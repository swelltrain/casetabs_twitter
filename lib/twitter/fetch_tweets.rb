module Twitter
  class FetchTweets
    def initialize(user)
      @user = user
    end

    def call
      cached = request_from_cache
      return cached unless cached.nil?

      tweets = client.user_timeline(user)
      persist_to_cache(tweets)
      tweets
    end

    private
    attr_reader :user

    def client
      Twitter::Client.client
    end

    def cache_key
      "user_timeline/#{user}"
    end

    def request_from_cache
      Rails.cache.cleanup
      raw = Rails.cache.read(cache_key)
      return nil if raw.nil?
      tweets = []
      JSON.parse(raw).reduce(tweets) { |accum, tweet_hash| accum << Twitter::Tweet.new(tweet_hash.deep_symbolize_keys) }
      tweets
    end

    def persist_to_cache(tweets)
      Rails.cache.write(cache_key, serialize(tweets), expires_in: 5.minutes)
    end

    def serialize(tweets)
      JSON.generate(tweets.map(&:to_h))
    end
  end
end
