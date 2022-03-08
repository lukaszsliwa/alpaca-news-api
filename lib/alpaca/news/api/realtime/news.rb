# frozen_string_literal: true

module Alpaca
  module News
    module Api
      module Realtime
        # Alpaca Realtime API News class
        #
        class News
          # Create Realtime news object
          #
          def initialize
            @client = Client.new(Alpaca::News::Api.configure.stream, Alpaca::News::Api.configure.client_options)
          end

          # Send auth action with key and secret to the websocket server
          #
          # @param [Hash] options               Client auth options
          # @option options [String] :key       Client key
          # @option options [String] :secret    Client secret
          #
          # @return [Alpaca::News::Api::Realtime::News]
          #
          def auth(options = {})
            key = options[:key] || Alpaca::News::Api.configure.key_id
            secret = options[:secret] || Alpaca::News::Api.configure.secret_key
            @client.send(action: 'auth', key: key, secret: secret)
            self
          end

          # Send subscribe command
          #
          # @param [String, Symbol, Array<String>] news     List of tickers or :all
          #
          # @yield [Alpaca::News::Api::Models::News]
          #
          # @return [Alpaca::News::Api::Realtime::News]
          #
          def subscribe(news = :all, &block)
            news = '*' if news == :all
            news = news.split(',') if news.is_a?(String)
            @client.send(action: 'subscribe', news: Array(news))
            @client.message do |data|
              objects = JSON.parse(data).map do |item|
                Alpaca::News::Api::Models::News.new(item) if item.delete('T') == 'n'
              end.select { |x| !x.nil? }
              next if objects.empty?
              block.call(Alpaca::News::Api::Models::Event.new(object: objects.first, objects: objects, type: :message))
            end
            self
          end

          # Send unsubscribe command
          #
          # @param [String, Symbol, Array<String>] news     List of tickers or :all
          #
          # @return [Alpaca::News::Api::Realtime::News]
          #
          def unsubscribe(news = :all)
            news = '*' if news == :all
            @client.send(action: 'unsubscribe', news: Array(news))
            self
          end

          # On error callback
          #
          # @yield [Faye::WebSocket::API::ErrorEvent]   Error event object
          #
          # @return [Alpaca::News::Api::Realtime::News]
          #
          def error(&block)
            @client.error(&block)
            self
          end
          alias on_error error

          # On close callback
          #
          # @yield []   Error event object
          #
          # @return [Alpaca::News::Api::Realtime::News]
          #
          def close(&block)
            @client.close(&block)
            self
          end
          alias on_close close

          class << self
            # Start auth, subscribe with block and unsubscribe within EM block
            #
            # @param [String, Symbol, Array<String>] news     List of tickers or :all
            # @param [Hash] options                           Client auth options
            # @option options [String] :key                   Client key
            # @option options [String] :secret                Client secret
            #
            def run(news = :all, options = {}, &block)
              run_with_eventmachine(news, options, &block)
            end
            alias stream run
            alias subscribe run
            alias watch run

            # Auth, subscribe with block and unsubscribe within EM block
            #
            # @param [String, Symbol, Array<String>] news     List of tickers or :all
            # @param [Hash] options                           Client auth options
            # @option options [String] :key                   Client key
            # @option options [String] :secret                Client secret
            #
            def run_with_eventmachine(news = :all, options = {}, &block)
              EventMachine.run { run_without_eventmachine(news, options, &block) }
            end

            # Auth, subscribe with block and unsubscribe without EM
            #
            # @param [String, Symbol, Array<String>] news     List of tickers or :all
            # @param [Hash] options                           Client auth options
            # @option options [String] :key                   Client key
            # @option options [String] :secret                Client secret
            #
            def run_without_eventmachine(news = :all, options = {}, &block)
              (realtime = new).auth(options)
              realtime.subscribe(news, &block)
              realtime.unsubscribe(news)
            end
          end
        end
      end
    end
  end
end
