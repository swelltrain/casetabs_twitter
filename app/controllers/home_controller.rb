
class HomeController < ApplicationController
  def index
    @user = 'casetabs'
    @tweets = client.user_timeline(@user)
  end

  def user
    @user = params[:user].gsub(/\A\@/,'')
    @tweets = client.user_timeline(@user)
  end

  private

  def client
    Twitter::Client.client
  end
end
