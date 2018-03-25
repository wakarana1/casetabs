class TweetsController < ApplicationController

  require 'twitter'
  include Twitter::Extractor

  def index
    @user = 'casetabs'
    @tweets = get_recent_tweets(@user)
    tweets_and_mentions(@tweets)
  end

  def search
    @user = params[:search].blank? ? 'casetabs' : params[:search]
    @tweets = get_recent_tweets(@user)
    tweets_and_mentions(@tweets)
    render action: "index"
  end

  private

  def tweets_and_mentions(tweets)
    @tweets_and_mentions = {}
    @tweets.each do |tweet|
      @mentions = extract_mentioned_screen_names(tweet.text)
      @tweets_and_mentions[tweet.text.to_sym] = @mentions
    end
    @tweets_and_mentions
  end

  def get_recent_tweets(user)
    client.user_timeline(@user,
                        count: 20,
                        result_type: "recent" )
  end

  def client
    client = Twitter::REST::Client.new do |config|
      config.consumer_key         = Figaro.env.consumer_key
      config.consumer_secret      = Figaro.env.consumer_secret
      config.access_token         = Figaro.env.access_token
      config.access_token_secret  = Figaro.env.access_token_secret
    end
  end
end
