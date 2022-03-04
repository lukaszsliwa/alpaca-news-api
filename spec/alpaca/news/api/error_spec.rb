# frozen_string_literal: true

RSpec.describe Alpaca::News::Api::Error do
  subject(:error) { described_class }

  it 'should be kind of StandardError' do
    expect(error).to be < StandardError
  end
end
