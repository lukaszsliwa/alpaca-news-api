require 'dotenv'
require 'alpaca-news-api'

Dotenv.load('./.env')

Alpaca::News::Api.configure do |config|
  config.key_id = ENV.fetch('ALPACA_API_KEY_ID')
  config.secret_key = ENV.fetch('ALPACA_API_SECRET_KEY')
end

number_of_items = 0
Alpaca::News::Api::HistoricalNews.where(symbols: 'SVM,GOLD,NEM').find_each do |news|
  number_of_items += 1
  puts "[#{news.id}] #{news.headline}"
  break if number_of_items >= 16
end
