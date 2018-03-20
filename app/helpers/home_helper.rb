require Rails.root.join('lib/twitter/fetch_user')


module HomeHelper
  def formatted_tweet_text(text)
    mentioned_user_regex = /(\@\w+)/
    url_regex = /(https*:\/\/\S+)/
    t = text.gsub(mentioned_user_regex) { |user| "#{link_to user, user_path(user), {'data-toggle'=>'tooltip', title: format_user_metadata(Twitter::FetchUser.new(user).call)}}" }
    t.gsub!(url_regex) { |url| "#{link_to url, url}" }
    t
  end

  def format_user_metadata(user)
    "Followers: #{user.followers_count} | Tweets: #{user.statuses_count}"
  end
end
