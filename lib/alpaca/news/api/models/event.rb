# frozen_string_literal: true

module Alpaca
  module News
    module Api
      module Models
        class Event
          # News object
          #
          # @return [Alpaca::News::Api::Models::News]
          #
          attr_accessor :object

          # News objects
          #
          # @return [Array<Alpaca::News::Api::Models::News>]
          #
          attr_accessor :objects

          # Event type
          #
          # @return [String, Symbol, nil]
          #
          attr_accessor :type

          # Created timestamp
          #
          # @return [Time]
          #
          attr_accessor :created_at

          def initialize(attributes = {})
            @attributes = ActiveSupport::HashWithIndifferentAccess.new(attributes)
            self.object = @attributes[:object]
            self.objects = @attributes[:objects]
            self.type = @attributes[:type]
            self.created_at = Time.now.utc
          end
        end
      end
    end
  end
end
