# frozen_string_literal: true

RSpec.describe Alpaca::News::Api::Configuration do
  let(:options) do
    { key_id: 'validkey', secret_key: 'secretkey', host: 'host.dev' }
  end
  subject(:configuration) { described_class.new(options) }

  describe '#key_id' do
    it 'should return key_id' do
      expect(configuration.key_id).to eq('validkey')
    end
  end

  describe '#secret_key' do
    it 'should return secret_key' do
      expect(configuration.secret_key).to eq('secretkey')
    end
  end

  describe '#host' do
    it 'should return host' do
      expect(configuration.host).to eq('host.dev')
    end
  end

  describe '#user_agent' do
    it 'should contain Alpaca::News::Api::VERSION' do
      expect(configuration.user_agent.split('/')).to include("alpaca-news-api-#{Alpaca::News::Api::VERSION}")
    end

    it 'should contain RUBY_VERSION' do
      expect(configuration.user_agent.split('/')).to include("ruby-#{RUBY_VERSION}")
    end
  end
end
