# frozen_string_literal: true

module Alpaca
  module News
    module Api
      module Rest
        class Collection < Base
          # News objects
          #
          # @return [Array]
          #
          attr_accessor :objects

          # Endpoint
          #
          # @return [String]
          #
          attr_accessor :endpoint

          # Parameters
          #
          # @return [Hash]
          #
          attr_accessor :params

          # API headers
          #
          # @return [Hash]
          #
          attr_accessor :headers

          # Response model class
          #
          # @return [Class]
          #
          attr_accessor :model_class

          # Page token
          #
          # @return [String]
          #
          attr_accessor :page_token

          # Current page
          #
          # @return [Integer]
          #
          attr_accessor :page

          delegate :each, :map, :each_with_index, :[], to: :objects

          class << self
            # Send GET request to the specific endpoint with parameters and headers
            #
            # @param [String] endpoint      API endpoint
            # @param [Hash]   params        API url parameters
            # @param [Hash]   headers       API headers
            # @param [Class]  model_class   Response model class
            #
            # @return [Alpaca::News::Api::Rest::Collection]
            #
            def get(endpoint, params, headers, model_class)
              new.get(endpoint, params, headers, model_class)
            end
          end

          # Send GET request to the specific endpoint with parameters and headers
          #
          # @param [String] endpoint      API endpoint
          # @param [Hash]   params        API url parameters
          # @param [Hash]   headers       API headers
          # @param [Class]  model_class   Response model class
          #
          # @return [Alpaca::News::Api::Rest::Collection]
          #
          def get(endpoint, params, headers, model_class)
            @page ||= 0
            @endpoint = endpoint
            @params = params
            @headers = headers
            @model_class = model_class
            result = client.get(endpoint, params, headers)
            @page += 1
            @page_token = result[:next_page_token]
            @objects = result[:news].map do |attributes|
              model_class.new(attributes)
            end
            self
          end

          # Request for the next page if the page token is not nil
          #
          # @return [Alpaca::News::Api::Rest::Collection]
          #
          def next_page
            return nil if @page_token.nil?

            get(@endpoint, @params.merge(page_token: @page_token), @headers, @model_class)
          end

          # Iterate for all objects and call for the next page (all pages)
          #
          # @yield [Alpaca::News::Api::Models::News]        News object
          #
          def find_each
            result = self
            loop do
              result.objects.each do |object|
                yield(object)
              end
              break unless result = result.next_page
            end
          end

          # Iterate for all objects and call for the next page in batches (all pages)
          #
          # @yield [Array<Alpaca::News::Api::Models::News>] News objects
          #
          def find_in_batches
            result = self
            loop do
              yield(result.objects)
              break unless result = result.next_page
            end
          end
        end
      end
    end
  end
end
