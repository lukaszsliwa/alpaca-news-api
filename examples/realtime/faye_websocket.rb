require 'faye/websocket'
require 'eventmachine'
require 'alpaca-news-api'
require 'dotenv'

Dotenv.load('./.env')

EM.run do
  ws = Faye::WebSocket::Client.new('wss://stream.data.alpaca.markets/v1beta1/news', [], tls: { verify_peer: false })
  ws.send({ action: 'auth', key: ENV.fetch('ALPACA_API_KEY_ID'), secret: ENV.fetch('ALPACA_API_SECRET_KEY') }.to_json)
  ws.send({ action: 'subscribe', news: ['*'] }.to_json)

  ws.on :error do |event|
    p [:error, event.message]
  end

  ws.on :open do |event|
    p [:open]
  end

  ws.on :message do |event|
    p [:message, JSON.parse(event.data).map { |it| it['id'] }]
  end

  ws.on :close do |event|
    p [:close, event.code, event.reason]
  end
end