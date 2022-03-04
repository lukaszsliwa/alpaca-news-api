require 'dotenv'
require 'alpaca-news-api'

Dotenv.load('./.env')

Alpaca::News::Api.configure do |config|
  config.key_id = ENV.fetch('ALPACA_API_KEY_ID')
  config.secret_key = ENV.fetch('ALPACA_API_SECRET_KEY')
end

page = 0
Alpaca::News::Api::HistoricalNews.where(symbols: 'SVM,GOLD,NEM').find_in_batches do |objects|
  page += 1
  objects.each do |object|
    puts "[#{object.id}] #{object.headline}"
  end
  break if page >= 4
end
