# frozen_string_literal: true

RSpec.describe Alpaca::News::Api::Models::News do
  let(:attributes) do
    {
      id: '1',
      headline: 'This is example headline',
      author: 'Jack Strong',
      created_at: Time.now.to_formatted_s(:rfc3339),
      updated_at: Time.now.to_formatted_s(:rfc3339),
      summary: 'This is summary',
      url: 'https://host.external/link-to-article',
      content: 'Article Content',
      images: ['https://host.external/image1.jpeg'],
      symbols: ['GOLD', 'SVM', 'AAPL'],
      source: 'host.external'
    }
  end
  subject(:news) { described_class.new(attributes) }

  describe '#id' do
    it 'should return id' do
      expect(news.id).to eq('1')
    end
  end

  describe '#headline' do
    it 'should return headline' do
      expect(news.headline).to eq('This is example headline')
    end
  end

  describe '#author' do
    it 'should return author' do
      expect(news.author).to eq('Jack Strong')
    end
  end

  describe '#created_at' do
    it 'should return created_at' do
      expect(news.created_at).to be_a(Time)
    end
  end

  describe '#updated_at' do
    it 'should return updated_at' do
      expect(news.updated_at).to be_a(Time)
    end
  end

  describe '#summary' do
    it 'should return summary' do
      expect(news.summary).to eq('This is summary')
    end
  end

  describe '#url' do
    it 'should return url' do
      expect(news.url).to eq('https://host.external/link-to-article')
    end
  end

  describe '#content' do
    it 'should return content' do
      expect(news.content).to eq('Article Content')
    end
  end

  describe '#images' do
    it 'should return images' do
      expect(news.images).to eq(['https://host.external/image1.jpeg'])
    end
  end

  describe '#symbols' do
    it 'should return symbols' do
      expect(news.symbols).to eq(['GOLD', 'SVM', 'AAPL'])
    end
  end

  describe '#source' do
    it 'should return source' do
      expect(news.source).to eq('host.external')
    end
  end
end
