# frozen_string_literal: true

RSpec.describe Alpaca::News::Api::HistoricalNews do
  subject(:historical_news) { described_class }

  it 'should be kind of Alpaca::News::Api::Rest::News' do
    expect(historical_news).to be < Alpaca::News::Api::Rest::News
  end
end
