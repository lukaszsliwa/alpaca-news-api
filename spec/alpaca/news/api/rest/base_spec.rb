# frozen_string_literal: true

RSpec.describe Alpaca::News::Api::Rest::Base do
  subject(:base) { described_class.new }

  describe '#client' do
    it 'should return Alpaca::News::Api::Rest::Client object' do
      expect(base.client).to be_a(Alpaca::News::Api::Rest::Client)
    end
  end
end
