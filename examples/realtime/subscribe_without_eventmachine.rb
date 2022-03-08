require 'dotenv'
require 'alpaca-news-api'

Dotenv.load('./.env')

Alpaca::News::Api.configure do |config|
  config.key_id = ENV.fetch('ALPACA_API_KEY_ID')
  config.secret_key = ENV.fetch('ALPACA_API_SECRET_KEY')
  config.client_options = { tls: { verify_peer: false } }
end

Alpaca::News::Api::RealtimeNews.subscribe do |object|
  puts "#{object.id} #{object.headline}"
end
