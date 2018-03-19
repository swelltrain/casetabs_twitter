
class HomeController < ApplicationController
  def index
    client = Twitter::Client.client
    @casetab_tweets = client.user_timeline('casetabs')
  end
end
