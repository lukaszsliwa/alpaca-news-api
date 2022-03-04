# frozen_string_literal: true

RSpec.describe Alpaca::News::Api::Rest::Client do
  subject(:client) { described_class.new }

  describe '#get' do
    context 'on success' do
      it 'should return news' do
        VCR.use_cassette('get_v1beta1_news_GOLD_SVM') do
          response = client.get('/v1beta1/news', { symbols: 'GOLD,SVM' }, client.headers)
          expect(response[:news].size).to eq(10)
          response[:news].each do |news|
            expect(news.keys).to eq([:id, :headline, :author, :created_at, :updated_at, :summary, :url, :images, :symbols, :source])
          end
          expect(response[:next_page_token]).to be_present
        end
      end
    end

    context 'on error' do
      it 'should raise an 404 Not Found when endpoint does not exist' do
        VCR.use_cassette('get_v1beta1_news1_GOLD_SVM_error') do
          client.get('/v1beta1/news1', { symbols: 'GOLD,SVM' }, client.headers)
        rescue Alpaca::News::Api::Error => e
          expect(e.message).to eq('404 Not Found')
        end
      end
    end
  end

  describe '#url_for' do
    let(:url) { client.url_for('/example-endpoint', a: 1, b: 2, c: 3) }

    it 'should return url with params' do
      expect(url).to eq('https://data.alpaca.markets/example-endpoint?a=1&b=2&c=3')
    end
  end

  describe '#headers' do
    let(:headers) do
      {
        'Apca-Api-Key-Id': ENV.fetch('ALPACA_API_KEY_ID'),
        'Apca-Api-Secret-Key': ENV.fetch('ALPACA_API_SECRET_KEY'),
        'User-Agent': "alpaca-news-api-#{Alpaca::News::Api::VERSION}/ruby-#{RUBY_VERSION}"
      }
    end

    it 'should return headers' do
      expect(client.headers).to eq(headers)
    end
  end
end
