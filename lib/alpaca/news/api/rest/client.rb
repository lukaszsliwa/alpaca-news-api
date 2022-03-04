# frozen_string_literal: true

module Alpaca
  module News
    module Api
      module Rest
        class Client < Base
          # Send GET request to the specific endpoint
          #
          # @param [String] endpoint      API request endpoint
          # @param [Hash] params          API request parameters
          # @param [Hash] custom_headers  API request custom headers
          #
          # @return [Hash]  API response
          #
          # @raise [Alpaca::News::Api::Error]
          #
          def get(endpoint, params = {}, custom_headers = {})
            args = {
              method: :get,
              url: url_for(endpoint, params),
              headers: custom_headers.merge(headers)
            }
            body = RestClient::Request.execute(args).body
            JSON.parse(body).deep_transform_keys { |key| key.to_s.underscore.to_sym }
          rescue RestClient::Exception => e
            raise Alpaca::News::Api::Error, e.message
          end

          def url_for(endpoint, params = {})
            URI::HTTPS.build(
              host: Alpaca::News::Api.configure.host,
              query: URI.encode_www_form(params || {}),
              path: endpoint
            ).to_s
          end

          # API headers Apca-Api-Key-Id, Apca-Api-Secret-Key, User-Agent
          #
          # @return [Hash]
          #
          def headers
            {
              'Apca-Api-Key-Id': Alpaca::News::Api.configure.key_id,
              'Apca-Api-Secret-Key': Alpaca::News::Api.configure.secret_key,
              'User-Agent': Alpaca::News::Api.configure.user_agent
            }
          end
        end
      end
    end
  end
end
