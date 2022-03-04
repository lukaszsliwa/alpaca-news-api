require 'dotenv'
require 'alpaca-news-api'

Dotenv.load('./.env')

Alpaca::News::Api.configure do |config|
  config.key_id = ENV.fetch('ALPACA_API_KEY_ID')
  config.secret_key = ENV.fetch('ALPACA_API_SECRET_KEY')
end

iterator = Alpaca::News::Api::HistoricalNews.where(symbols: 'SVM,GOLD,NEM').all
while iterator.page <= 3
  puts "PAGE #{iterator.page}"
  iterator.objects.each do |news|
    puts "[#{news.id}] #{news.headline}"
  end
  iterator.next_page
end
