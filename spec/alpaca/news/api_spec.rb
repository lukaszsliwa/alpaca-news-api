# frozen_string_literal: true

RSpec.describe Alpaca::News::Api do
  subject(:api) { described_class }

  describe '.configure' do
    it 'should return current configuration' do
      expect(api.configure).to be_a(Alpaca::News::Api::Configuration)
      expect(api.configure.host).to eq('data.alpaca.markets')
      expect(api.configure.stream).to eq('stream.data.alpaca.markets')
      expect(api.configure.client_options).to eq({})
    end
  end

  describe '.default_options' do
    it 'should return a hash with host' do
      default_options = {
        host: 'data.alpaca.markets',
        stream: 'stream.data.alpaca.markets',
        client_options: {}
      }
      expect(api.default_options).to eq(default_options)
    end
  end
end
