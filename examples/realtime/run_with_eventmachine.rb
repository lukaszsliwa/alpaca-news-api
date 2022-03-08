require 'dotenv'
require 'alpaca-news-api'

Dotenv.load('./.env')

Alpaca::News::Api.configure do |config|
  config.key_id = ENV.fetch('ALPACA_API_KEY_ID')
  config.secret_key = ENV.fetch('ALPACA_API_SECRET_KEY')
  config.client_options = { tls: { verify_peer: false } }
end

EM.run do
  Alpaca::News::Api::RealtimeNews.new.auth.subscribe do |event|
    puts "[#{event.object.symbols.join(',')}][#{event.object.id}][#{event.object.source}] #{event.object.headline}"
  end.on_error do |event|
    puts "Error: #{event.object.message}"
  end
end
