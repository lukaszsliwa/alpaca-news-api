# frozen_string_literal: true

RSpec.describe Alpaca::News::Api do
  let(:version) { Alpaca::News::Api::VERSION }

  it 'should return current version' do
    expect(version).to be_present
  end
end
