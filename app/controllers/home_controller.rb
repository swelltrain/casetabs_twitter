require Rails.root.join('lib/twitter/fetch_tweets')

class HomeController < ApplicationController
  def index
    @user = 'casetabs'
    @tweets = Twitter::FetchTweets.new(@user).call
  end

  def user
    @user = params[:user].gsub(/\A\@/,'')
    @tweets = Twitter::FetchTweets.new(@user).call
  end

  private

  def client
    Twitter::Client.client
  end
end
