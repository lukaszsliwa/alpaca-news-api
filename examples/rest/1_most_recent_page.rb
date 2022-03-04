require 'dotenv'
require 'alpaca-news-api'

Dotenv.load('./.env')

Alpaca::News::Api.configure do |config|
  config.key_id = ENV.fetch('ALPACA_API_KEY_ID')
  config.secret_key = ENV.fetch('ALPACA_API_SECRET_KEY')
end

Alpaca::News::Api::HistoricalNews.where(symbols: 'SVM,GOLD,NEM').recent.each do |object|
  puts "#{object.id} #{object.headline}"
end
