# frozen_string_literal: true

RSpec.describe Alpaca::News::Api::Models::Event do
  let(:object) { double('Object') }
  let(:objects) { [double('Object1'), double('Object2'), double('Object3')] }
  let(:attributes) { { object: object, objects: objects, type: :message } }

  subject(:event) { described_class.new(attributes) }

  describe '#object' do
    it 'should return object' do
      expect(event.object).to eq(object)
    end
  end

  describe '#objects' do
    it 'should return objects' do
      expect(event.objects).to eq(objects)
    end
  end

  describe '#type' do
    it 'should return type' do
      expect(event.type).to eq(:message)
    end
  end

  describe '#created_at' do
    it 'should return created_at timestamp' do
      expect(event.created_at).to be_present
    end
  end
end
