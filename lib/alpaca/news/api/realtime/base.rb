# frozen_string_literal: true

module Alpaca
  module News
    module Api
      module Realtime
        class Base < Alpaca::News::Api::Base
          # Current client instance
          #
          # @return [Alpaca::News::Api::Realtime::Client]
          #
          def client
            @client ||= Client.new
          end
        end
      end
    end
  end
end
