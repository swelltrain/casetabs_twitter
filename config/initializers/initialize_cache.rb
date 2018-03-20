CasetabsTwitter::Application.config.cache_store = :file_store, Rails.root.join('tmp', 'cache'), { expires_in: 5.minutes }
