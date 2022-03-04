# frozen_string_literal: true

RSpec.describe Alpaca::News::Api do
  subject(:api) { described_class }

  describe '.configure' do
    it 'should return current configuration' do
      expect(api.configure).to be_a(Alpaca::News::Api::Configuration)
      expect(api.configure.host).to eq('data.alpaca.markets')
    end
  end

  describe '.default_options' do
    it 'should return a hash with host' do
      expect(api.default_options).to eq({ host: 'data.alpaca.markets' })
    end
  end
end
