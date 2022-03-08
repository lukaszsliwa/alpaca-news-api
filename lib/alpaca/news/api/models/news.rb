# frozen_string_literal: true

module Alpaca
  module News
    module Api
      module Models
        class News
          # News object ID
          #
          # @return [String]
          #
          attr_accessor :id

          # News headline
          #
          # @return [String]
          #
          attr_accessor :headline

          # News author
          #
          # @return [String]
          #
          attr_accessor :author

          # News created_at timestamp (RFC 3339)
          #
          # @return [String]
          #
          attr_accessor :created_at

          # News updated_at timestamp (RFC 3339)
          #
          # @return [String]
          #
          attr_accessor :updated_at

          # News summary
          #
          # @return [String]
          #
          attr_accessor :summary

          # News URL
          #
          # @return [String]
          #
          attr_accessor :url

          # News content
          #
          # @return [String]
          #
          attr_accessor :content

          # News images
          #
          # @return [Array]
          #
          attr_accessor :images

          # News symbols
          #
          # @return [Array]
          #
          attr_accessor :symbols

          # News source
          #
          # @return [String]
          #
          attr_accessor :source

          # Create new News object
          #
          # @param [Hash] attributes
          #
          def initialize(attributes = {})
            @attributes = ActiveSupport::HashWithIndifferentAccess.new(attributes)
            @attributes.each do |key, value|
              method(:"#{key}=").call(value)
            end
            @created_at = Time.parse(@created_at) if @created_at.is_a?(String)
            @updated_at = Time.parse(@updated_at) if @updated_at.is_a?(String)
          end
        end
      end
    end
  end
end
