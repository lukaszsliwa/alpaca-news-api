# frozen_string_literal: true

RSpec.describe Alpaca::News::Api::Realtime::Base do
  subject(:base) { described_class.new }

  describe '#client' do
    it 'should return Alpaca::News::Api::Realtime::Client' do
      expect(base.client).to be_a(Alpaca::News::Api::Realtime::Client)
    end
  end
end
