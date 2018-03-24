class TweetsController < ApplicationController
  require 'twitter'
  def index
    @tweets = client.user_timeline('casetabs', count: 20)
  end

  def search
    @tweets = client.user_timeline(params[:search], count: 20)
    render action: "index"
  end

  private

  def client
    client = Twitter::REST::Client.new do |config|
      config.consumer_key         = ENV["CONSUMER_KEY"]
      config.consumer_secret      = ENV["CONSUMER_SECRET"]
      config.access_token         = ENV['TW_ACCESS_TOKEN']
      config.access_token_secret  = ENV['TW_ACCESS_TOKEN_SECRET']
    end
  end
end
