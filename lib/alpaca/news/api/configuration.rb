# frozen_string_literal: true

module Alpaca
  module News
    module Api
      class Configuration
        # Alpaca API Key ID
        #
        # @return [String]
        #
        attr_accessor :key_id

        # Alpaca API Secret Key
        #
        # @return [String]
        #
        attr_accessor :secret_key

        # Alpaca API host
        # @return [String]
        attr_accessor :host

        # Alpaca API stream host
        # @return [String]
        attr_accessor :stream

        # Alpaca News API client options
        # @return [String]
        attr_accessor :client_options

        # Create new configuration
        #
        # @param [Hash] options
        # @option options [String] :key_id          Alpaca Key ID
        # @option options [String] :secret_key      Alpaca Secret Key
        # @option options [String] :host            Alpaca host
        # @option options [String] :stream          Alpaca stream
        # @option options [Hash]   :client_options  Websocket client options
        #
        def initialize(options = {})
          options = ActiveSupport::HashWithIndifferentAccess.new(options)
          self.key_id = options[:key_id]
          self.secret_key = options[:secret_key]
          self.host = options[:host]
          self.stream = options[:stream]
          self.client_options = options[:client_options]
        end

        # User agent base on the alpaca-news-api version and ruby version
        #
        # @return [String]
        #
        def user_agent
          "alpaca-news-api-#{Alpaca::News::Api::VERSION}/ruby-#{RUBY_VERSION}"
        end
      end
    end
  end
end
