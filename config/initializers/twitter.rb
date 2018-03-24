Twitter::Rest::Client.new do |client|
  config.consumer_key = ENV['CONSUMER_KEY']
  config.consumer_secret = ENV['CONSUMER_SECRET']
  config.access_token = ENV['TW_ACCESS_TOKEN']
  config.access_token_secret = ENV['TW_ACCESS_TOKEN_SECRET']
end
