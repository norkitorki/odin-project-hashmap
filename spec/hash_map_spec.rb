# frozen_string_literal: true

require_relative '../lib/hash_map'

describe HashMap do
  let(:hash_map) { described_class.new }

  describe '#hash' do
    it 'returns a hash from a string' do
      expect(hash_map.hash('Clementine')).to eq(1_866_445_425_426_758)
    end
  end

  describe '#set' do
    it 'stores an object' do
      person_data = { name: 'Alfred', age: 52 }
      hash_map.set('Alfred', person_data)
      expect(hash_map.get('Alfred')).to eq(person_data)
    end

    context 'when key exists' do
      it 'overrides the object' do
        hash_map.set('arr', [1, 2])
        hash_map.set('arr', [4, 5])
        expect(hash_map.get('arr')).to eq([4, 5])
      end
    end
  end

  describe '#get' do
    context 'when key exists' do
      it 'returns the object' do
        string = 'Stored string'
        hash_map.set('str', string)
        expect(hash_map.get('str')).to eq(string)
      end
    end

    context 'when key does not exist' do
      it 'returns nil' do
        expect(hash_map.get('abc')).to be_nil
      end
    end
  end

  describe '#has?' do
    context 'when key exists' do
      it 'returns true' do
        hash_map.set('something', '')
        expect(hash_map.has?('something')).to be true
      end
    end

    context 'when key does not exist' do
      it 'returns false' do
        expect(hash_map.has?('marble')).to be false
      end
    end
  end

  describe '#remove' do
    context 'when key exists' do
      it 'removes the object associated with the key' do
        date = '2024-08-02'
        hash_map.set('date', date)
        hash_map.remove('date')
        expect(hash_map.has?('date')).to be false
      end

      it 'returns the object' do
        arr = %w[a b]
        hash_map.set('arr', arr)
        expect(hash_map.remove('arr')).to eq(arr)
      end
    end

    context 'when key does not exist' do
      it 'returns nil' do
        expect(hash_map.remove('abc')).to be_nil
      end
    end
  end

  describe '#length' do
    it 'returns the number of stored keys' do
      7.times { |i| hash_map.set("key_#{i}", []) }
      2.times { |i| hash_map.remove("key_#{i}") }

      expect(hash_map.length).to eq(5)
    end
  end

  describe '#clear' do
    it 'clears the entire hash map' do
      10.times { |i| hash_map.set("key_#{i}", []) }
      hash_map.clear
      expect(hash_map.length).to eq(0)
    end
  end

  describe '#keys' do
    it 'returns an array' do
      expect(hash_map.keys).to be_a(Array)
    end

    it 'collects every key' do
      4.times { |i| hash_map.set("key_#{i}", []) }
      expect(hash_map.keys).to include('key_0', 'key_1', 'key_2', 'key_3')
    end
  end

  describe '#values' do
    it 'returns an array' do
      expect(hash_map.values).to be_a(Array)
    end

    it 'collects every value' do
      5.times { |i| hash_map.set("key_#{i}", "str_#{i}") }
      expect(hash_map.values).to include('str_0', 'str_1', 'str_2', 'str_3', 'str_4')
    end
  end

  describe '#entries' do
    it 'returns an array' do
      expect(hash_map.entries).to be_a(Array)
    end

    it 'collects every key/value pair' do
      3.times { |i| hash_map.set("key_#{i}", "str_#{i}") }
      expect(hash_map.entries).to include(%w[key_0 str_0], %w[key_1 str_1], %w[key_2 str_2])
    end
  end
end
