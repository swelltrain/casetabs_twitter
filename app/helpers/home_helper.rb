module HomeHelper
  def formatted_tweet_text(text)
    mentioned_user_regex = /(\@\w+)/
    url_regex = /(https*:\/\/\S+)/
    t = text.gsub(mentioned_user_regex) { |user| "#{link_to user, user_path(user)}" }
    t.gsub!(url_regex) { |url| "#{link_to url, url}" }
    t
  end
end
