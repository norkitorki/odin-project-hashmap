# frozen_string_literal: true

require_relative '../lib/hash_set'

describe HashSet do
  let(:hash_set) { described_class.new }

  describe '#set' do
    it 'stores a key' do
      key = 'myKey'
      hash_set.set(key)
      expect(hash_set.get(key)).to eq(key)
    end

    context 'when key exists' do
      it 'overrides the key' do
        hash_set.set(:key1)
        hash_set.set(:key1)
        expect(hash_set.length).to eq(1)
      end
    end
  end

  describe '#get' do
    context 'when key exists' do
      it 'returns the key' do
        key = :secret
        hash_set.set(key)
        expect(hash_set.get(key)).to eq(key)
      end
    end

    context 'when key does not exist' do
      it 'returns nil' do
        expect(hash_set.get('abc')).to be_nil
      end
    end
  end

  describe '#remove' do
    context 'when key exists' do
      it 'removes the object associated with the key' do
        hash_set.set('date')
        hash_set.remove('date')
        expect(hash_set.has?('date')).to be false
      end

      it 'returns the key' do
        key = :person1
        hash_set.set(key)
        expect(hash_set.remove(key)).to eq(key)
      end
    end

    context 'when key does not exist' do
      it 'returns nil' do
        expect(hash_set.remove('abc')).to be_nil
      end
    end
  end
end
