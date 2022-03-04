# frozen_string_literal: true

module Alpaca
  module News
    module Api
      module Rest
        # Alpaca REST API News class
        #
        class News
          # It should store read only parameters
          # @return [Hash]
          attr_reader :params

          # Create new News object
          #
          # @params [Hash] headers    Alpaca API headers
          # @option headers [String,Symbol] Apca-Api-Key-Id         Alpaca API Key ID
          # @option headers [String,Symbol] Apca-Api-Secret-Key     Alpaca API Secret Key
          # @option headers [String,Symbol] User-Agent              User agent
          #
          def initialize(headers = {})
            @headers = headers
          end

          # Set the request params
          #
          # @param [Hash] params    API request params
          # @option params [String] symbols               List of symbols to obtain news
          # @option params [String] start                 (Default: 01-01-2015) Start date to obtain news
          # @option params [String] end                   (Default: now) End date to obtain news
          # @option params [String] limit                 (Default: 10, Max: 50) Limit of news items to be returned for given page
          # @option params [String] sort                  (Default: DESC) Sort articles by updated date. Options: DESC, ASC
          # @option params [Boolean] include_content      (Default: false) Boolean whether to include content for news articles
          # @option params [Boolean] exclude_contentless  (Default: false) Exclude news articles that do not contain content (just headline and summary)
          # @option params [String] page_token            Pagination token to continue to next page
          #
          def where(params = {})
            @params = params
            self
          end

          # Send GET request to the host
          #
          # @return [Alpaca::News::Api::Rest::Collection]
          #
          def all
            Alpaca::News::Api::Rest::Collection.get('/v1beta1/news', @params, @headers, Alpaca::News::Api::Models::News)
          end
          alias recent all

          # Iterate for all objects and call for the next page (all pages)
          #
          # @yield [Alpaca::News::Api::Models::News]        News object
          #
          def find_each
            result = all
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
            result = all
            loop do
              yield(result.objects)
              break unless result result.next_page
            end
          end

          class << self
            # Query all with parameters
            #
            # @return [Alpaca::News::Api::Rest::Collection]
            #
            def query(params = {})
              new.where(params).all
            end
            alias search query
            alias lookup query
            alias get query
            alias find_all query

            # Set params
            #
            # @return [Alpaca::News::Api::Rest::News]
            #
            def where(params = {})
              new.where(params)
            end

            # Calls for the most recent news
            #
            # @return [Alpaca::News::Api::Rest::Collection]
            #
            def all
              new.all
            end
            alias recent all
          end
        end
      end
    end
  end
end
