module Twitter
  class FetchUser
    def initialize(name)
      @name = name
    end

    def call
      cached = request_from_cache
      return cached unless cached.nil?

      user = client.user(name)
      persist_to_cache(user)
      user
    end

    private
    attr_reader :name

    def client
      Twitter::Client.client
    end

    def cache_key
      "user/#{name}"
    end

    def request_from_cache
      Rails.cache.cleanup
      raw = Rails.cache.read(cache_key)
      return nil if raw.nil?
      Twitter::User.new(JSON.parse(raw).deep_symbolize_keys)
    end

    def persist_to_cache(user)
      Rails.cache.write(cache_key, serialize(user), expires_in: 5.minutes)
    end

    def serialize(user)
      JSON.generate(user.to_h)
    end
  end
end
