# frozen_string_literal: true

RSpec.describe Alpaca::News::Api::Rest::Collection do
  subject(:collection) { described_class.new }

  let(:params) { { symbols: 'GOLD,SVM', limit: 10 } }
  let(:headers) { collection.client.headers }

  describe '#get' do
    it 'should make GET request to the /v1beta1/news endpoint' do
      VCR.use_cassette('get_collection_v1beta1_news_GOLD_SVM_1') do
        collection.get('/v1beta1/news', params, headers, Alpaca::News::Api::Models::News)
      end
    end
  end

  describe '.get' do
    it 'should make GET request to the /v1beta1/news endpoint' do
      VCR.use_cassette('get_collection_v1beta1_news_GOLD_SVM_2') do
        described_class.get('/v1beta1/news', params, {}, Alpaca::News::Api::Models::News)
      end
    end
  end

  describe '#next_page' do
    let(:iterator) do
      collection.get('/v1beta1/news', params, headers, Alpaca::News::Api::Models::News)
    end

    it 'should call for the next page' do
      VCR.use_cassette('get_collection_v1beta1_news_GOLD_SVM_next_page') do
        iterator.objects.each { |object| expect(object).to be_a(Alpaca::News::Api::Models::News) }
        expect(iterator.objects.size).to eq(10)
        result = iterator.next_page
        result.objects.each { |object| expect(object).to be_a(Alpaca::News::Api::Models::News) }
        expect(result.objects.size).to eq(10)
      end
    end
  end

  describe '#find_each' do
    let(:result1) do
      collection.get('/v1beta1/news', params, headers, Alpaca::News::Api::Models::News)
    end

    let(:result2) do
      described_class.get('/v1beta1/news', params.merge(limit: 30), headers, Alpaca::News::Api::Models::News)
    end

    it 'should iterate through all results' do
      VCR.use_cassette('get_collection_v1beta1_news_GOLD_SVM_find_each') do
        cached_objects = {}
        # Get 30 objects in one request
        result2.each { |object| cached_objects[object.id] = object }
        # Get 30 objects in 3 requests (10 objects per request)
        number_of_results = 0
        result1.find_each do |object|
          number_of_results += 1
          expect(object).to be_a(Alpaca::News::Api::Models::News)
          expect(cached_objects[object.id]).to be_present
          break if number_of_results == 30
        end
        expect(number_of_results).to eq(30)
      end
    end
  end

  describe '#find_in_batches' do
    let(:result1) do
      collection.get('/v1beta1/news', params, headers, Alpaca::News::Api::Models::News)
    end

    let(:result2) do
      described_class.get('/v1beta1/news', params.merge(limit: 30), headers, Alpaca::News::Api::Models::News)
    end

    it 'should iterate through all results' do
      VCR.use_cassette('get_collection_v1beta1_news_GOLD_SVM_find_in_batches') do
        cached_objects = {}
        # Get 30 objects in one request
        result2.each { |object| cached_objects[object.id] = object }
        # Get 30 objects in 3 requests (10 objects per request)
        number_of_results = 0
        page = 1
        result1.find_in_batches do |objects|
          break if page == 4
          objects.each do |object|
            number_of_results += 1
            expect(object).to be_a(Alpaca::News::Api::Models::News)
            expect(cached_objects[object.id]).to be_present
          end
          page += 1
        end
        expect(number_of_results).to eq(30)
      end
    end
  end
end
