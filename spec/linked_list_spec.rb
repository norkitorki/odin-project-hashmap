# frozen_string_literal: true

require_relative '../lib/linked_list'

describe LinkedList do
  let(:list) { described_class.new }

  describe 'Node' do
    it 'has a key' do
      node = described_class::Node.new('num', 100)
      expect(node.key).to eq('num')
    end

    it 'has a value' do
      node = described_class::Node.new('num', 100)
      expect(node.value).to eq(100)
    end

    it 'has a next property' do
      next_node = LinkedList::Node.new('num_2', 200)
      node = described_class::Node.new('num_1', 100, next_node)
      expect(node.next).to eq(next_node)
    end
  end

  it 'initializes with a size of 0' do
    expect(list.size).to eq(0)
  end

  it 'has a head property' do
    expect(list.respond_to?(:head)).to be true
  end

  describe '#add' do
    it 'adds a node' do
      list.add('str', 'hello')
      expect(list.head.class).to eq(LinkedList::Node)
    end

    it 'increases size by 1' do
      expect { list.add('number', 200) }.to change(list, :size).by(1)
    end

    it 'works with non string keys' do
      hash = { my_key: 'secret' }
      list.add(hash, '35423')
      expect(list.find(hash).value).to eq('35423')
    end

    context 'when a node already exists' do
      it 'replaces node value' do
        list.add('str', 'hello')
        list.add('str', 'world')
        expect(list.head.value).to eq('world')
      end

      it 'does not update size' do
        list.add('abc', 'A')
        expect { list.add('abc', 'B') }.not_to change(list, :size)
      end

      it 'does not update node if node value and new value are both nil' do
        list.add(:my_key, nil)
        allow(list.head).to receive(:value=)
        list.add(:my_key, nil)
        expect(list.head).not_to have_received(:value=)
      end

      it 'returns true' do
        list.add(:secret, 'password')
        expect(list.add(:secret, 'secret')).to be true
      end
    end
  end

  describe '#remove' do
    it 'removes a node' do
      list.add('num_1', 1)
      list.remove('num_1')
      expect(list.find('num_1')).to be_nil
    end

    it 'decreases size by 1' do
      list.add('10', 10)
      expect { list.remove('10') }.to change(list, :size).by(-1)
    end

    it 'works with non string keys' do
      arr = [1, 2, 3]
      list.add(arr, '35423')
      list.remove(arr)
      expect(list.find(arr)).to be_nil
    end

    it 'returns the removed node' do
      list.add('num_2', 2)
      node = list.remove('num_2')
      expect([node.key, node.value]).to eq(['num_2', 2])
    end

    context 'when node doest not exist' do
      it 'returns nil' do
        expect(list.remove('123')).to be_nil
      end

      it 'does not update size' do
        expect { list.remove('key') }.not_to change(list, :size)
      end
    end
  end

  describe '#find' do
    it 'returns a node by key' do
      5.times { |i| list.add("num_#{i}", i) }
      expect(list.find('num_1').value).to eq(1)
    end

    it 'works with non string keys' do
      time = Time.now
      list.add(time, 'time')
      expect(list.find(time).value).to eq('time')
    end

    it 'returns nil if node with key does not exist' do
      10.times { |i| list.add("num_#{i}", i) }
      expect(list.find('num_200')).to be_nil
    end

    context 'when return_previous is true' do
      it 'returns both node and its predecessor' do
        10.times { |i| list.add(:"key#{i}", i) }
        node = list.find(:key4)
        previous_node = list.find(:key5)
        expect(list.find(:key4, return_previous: true)).to eq([node, previous_node])
      end
    end
  end

  describe '#to_a' do
    it 'returns an array containing node properties' do
      3.times { |i| list.add("num#{i}", i) }
      expect(list.to_a).to include(['num0', 0], ['num1', 1], ['num2', 2])
    end
  end
end
