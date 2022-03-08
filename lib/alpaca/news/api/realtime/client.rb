# frozen_string_literal: true

module Alpaca
  module News
    module Api
      module Realtime
        # Realtime client class
        #
        class Client < Base
          # Create new client object
          #
          # @param [String] host      Client host
          # @param [Hash] options     Client options
          #
          def initialize(host = nil, options = {})
            @websocket = Faye::WebSocket::Client.new("wss://#{host}/v1beta1/news", [], options)
          end

          # Send payload to the websocket server
          #
          def send(payload = {})
            @websocket.send(payload.to_json)
          end

          # Websocket message callback
          #
          # @yield [Hash]   Message data
          #
          def message(&block)
            @websocket.on(:message) do |event|
              block.call(event.data)
            end
          end
          alias on_message message

          # Websocket message callback
          #
          # @yield [Faye::WebSocket::API::ErrorEvent]   Error event object
          #
          def error(&block)
            @websocket.on(:error, &block)
          end
          alias on_error error

          # Websocket close callback
          #
          # @yield [Faye::WebSocket::API::Event] Event object
          #
          def close(&block)
            @websocket.on(:close, &block)
          end
          alias on_close close
        end
      end
    end
  end
end
