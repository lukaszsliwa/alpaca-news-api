# frozen_string_literal: true

module Alpaca
  module News
    module Api
      class << self
        # Current API configuration
        #
        # @yield [Alpaca::News::Api::Configuration]
        # @return [Alpaca::News::Api::Configuration]
        #
        def configure
          @configuration ||= Configuration.new(default_options)
          yield(@configuration) if block_given?
          @configuration
        end

        # Default options hash with :host
        #
        # @return [Hash]
        #
        def default_options
          {
            host: 'data.alpaca.markets',
            stream: 'stream.data.alpaca.markets',
            client_options: {}
          }
        end
      end
    end
  end
end
