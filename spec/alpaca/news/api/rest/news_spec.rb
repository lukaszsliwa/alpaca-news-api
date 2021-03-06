# frozen_string_literal: true

RSpec.describe Alpaca::News::Api::Rest::News do
  subject(:news) { described_class.new }

  let(:headers) { news.client.headers }

  describe '#where' do
    it 'should set params' do
      expect(news.where(limit: 10).params).to eq({ 'limit' => 10 })
    end
  end

  describe '#all' do
    it 'should get four news for GOLD' do
      VCR.use_cassette('get_collection_v1beta1_news_GOLD_SVM_where_all') do
        objects = news.where(limit: 4, symbols: 'GOLD').all.objects
        expect(objects.size).to eq(4)
        objects.each do |object|
          expect(object).to be_a(Alpaca::News::Api::Models::News)
        end
      end
    end
  end

  describe '#recent' do
    it 'should get four news for GOLD' do
      VCR.use_cassette('get_collection_v1beta1_news_GOLD_SVM_where_recent') do
        objects = news.where(limit: 4, symbols: 'GOLD').recent.objects
        expect(objects.size).to eq(4)
        objects.each do |object|
          expect(object).to be_a(Alpaca::News::Api::Models::News)
        end
      end
    end
  end

  describe '#find_each' do
    it 'should get four news for GOLD' do
      VCR.use_cassette('get_collection_v1beta1_news_GOLD_SVM_where_find_each') do
        objects = []
        counter = 0
        news.where(limit: 4, symbols: 'GOLD').find_each do |object|
          counter += 1
          objects << object
          expect(object).to be_a(Alpaca::News::Api::Models::News)
          break if counter == 4
        end
        expect(objects.size).to eq(4)
      end
    end
  end

  describe '#find_in_batches' do
    it 'should get four news for GOLD' do
      VCR.use_cassette('get_collection_v1beta1_news_GOLD_SVM_where_find_in_batches') do
        counter = 0
        news.where(limit: 4, symbols: 'GOLD').find_in_batches do |objects|
          objects.each do |object|
            counter += 1
            expect(object).to be_a(Alpaca::News::Api::Models::News)
          end
          expect(objects.size).to eq(4)
          break
        end
        expect(counter).to eq(4)
      end
    end
  end

  describe '.where' do
    it 'should set params' do
      expect(described_class.where(limit: 10).params).to eq({ 'limit' => 10 })
    end

    context 'with :symbols as an array' do
      let(:params) { described_class.where(symbols: %w(GOLD GDX GDXJ)).params }

      it 'should convert symbols to a string' do
        expect(params).to eq({ 'symbols' => 'GOLD,GDX,GDXJ' })
      end
    end

    context 'with :symbols as string' do
      let(:params) { described_class.where(symbols: 'GOLD,GDX,GDXJ').params }

      it 'should return a string' do
        expect(params).to eq({ 'symbols' => 'GOLD,GDX,GDXJ' })
      end
    end

    context 'with :start as a Time' do
      let(:start) { Time.now }
      let(:params) { described_class.where(start: start).params }

      it 'should convert start to RFC3339 format' do
        expect(params).to eq({ 'start' => start.utc.rfc3339 })
      end
    end

    context 'with :start as a DateTime' do
      let(:start) { DateTime.now }
      let(:params) { described_class.where(start: start).params }

      it 'should convert start to RFC3339 format' do
        expect(params).to eq({ 'start' => start.utc.rfc3339 })
      end
    end

    context 'with :start as a String' do
      let(:start) { DateTime.now.to_s }
      let(:params) { described_class.where(start: start).params }

      it 'should convert start to RFC3339 format' do
        expect(params).to eq({ 'start' => start.to_time.utc.rfc3339 })
      end
    end

    context 'with :end as a Time' do
      let(:end_time) { Time.now }
      let(:params) { described_class.where(end: end_time).params }

      it 'should convert end to RFC3339 format' do
        expect(params).to eq({ 'end' => end_time.utc.rfc3339 })
      end
    end

    context 'with :end as a DateTime' do
      let(:end_time) { DateTime.now }
      let(:params) { described_class.where(end: end_time).params }

      it 'should convert end to RFC3339 format' do
        expect(params).to eq({ 'end' => end_time.utc.rfc3339 })
      end
    end

    context 'with :end as a String' do
      let(:end_time) { DateTime.now.to_s }
      let(:params) { described_class.where(end: end_time).params }

      it 'should convert end to RFC3339 format' do
        expect(params).to eq({ 'end' => end_time.to_time.utc.rfc3339 })
      end
    end
  end

  describe '.all' do
    it 'should get all objects' do
      VCR.use_cassette('get_collection_v1beta1_news_all') do
        objects = described_class.all.objects
        expect(objects.size).to eq(10)
        objects.each do |object|
          expect(object).to be_a(Alpaca::News::Api::Models::News)
        end
      end
    end
  end

  describe '.recent' do
    it 'should get recent objects' do
      VCR.use_cassette('get_collection_v1beta1_news_recent') do
        objects = described_class.recent.objects
        expect(objects.size).to eq(10)
        objects.each do |object|
          expect(object).to be_a(Alpaca::News::Api::Models::News)
        end
      end
    end
  end

  describe '.query' do
    it 'should get query objects' do
      VCR.use_cassette('get_collection_v1beta1_news_query') do
        objects = described_class.query.objects
        expect(objects.size).to eq(10)
        objects.each do |object|
          expect(object).to be_a(Alpaca::News::Api::Models::News)
        end
      end
    end
  end

  describe '.search' do
    it 'should get search objects' do
      VCR.use_cassette('get_collection_v1beta1_news_search') do
        objects = described_class.search.objects
        expect(objects.size).to eq(10)
        objects.each do |object|
          expect(object).to be_a(Alpaca::News::Api::Models::News)
        end
      end
    end
  end

  describe '.lookup' do
    it 'should get lookup objects' do
      VCR.use_cassette('get_collection_v1beta1_news_lookup') do
        objects = described_class.lookup.objects
        expect(objects.size).to eq(10)
        objects.each do |object|
          expect(object).to be_a(Alpaca::News::Api::Models::News)
        end
      end
    end
  end

  describe '.get' do
    it 'should get lookup objects' do
      VCR.use_cassette('get_collection_v1beta1_news_get') do
        objects = described_class.get.objects
        expect(objects.size).to eq(10)
        objects.each do |object|
          expect(object).to be_a(Alpaca::News::Api::Models::News)
        end
      end
    end
  end

  describe '.find_all' do
    it 'should get find_all objects' do
      VCR.use_cassette('get_collection_v1beta1_news_find_all') do
        objects = described_class.find_all.objects
        expect(objects.size).to eq(10)
        objects.each do |object|
          expect(object).to be_a(Alpaca::News::Api::Models::News)
        end
      end
    end
  end
end
