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

    it 'converts key to string' do
      arr = [1, 2, 3]
      node = described_class::Node.new(arr, %w[a b c])
      expect(node.key).to eq(arr.to_s)
    end

    it 'has a next property' do
      successor = LinkedList::Node.new('num_2', 200)
      node = described_class::Node.new('num_1', 100, successor)
      expect(node.next).to eq(successor)
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

    context 'when a node already exists' do
      it 'replaces an existing node' do
        list.add('str', 'hello')
        list.add('str', 'world')
        expect(list.head.value).to eq('world')
      end
    end
  end

  describe '#remove' do
    it 'removes a node' do
      list.add('num_1', 1)
      list.remove('num_1')
      expect(list.find('num_1')).to be_nil
    end

    it 'returns the removed node' do
      list.add('num_2', 2)
      node = list.remove('num_2')
      expect([node.key, node.value]).to eq(['num_2', 2])
    end

    it 'returns nil if node does not exist' do
      expect(list.remove('123')).to be_nil
    end
  end

  describe '#find' do
    it 'returns a node by key' do
      5.times { |i| list.add("num_#{i}", i) }
      expect(list.find('num_1').value).to eq(1)
    end

    it 'returns nil if node with key does not exist' do
      10.times { |i| list.add("num_#{i}", i) }
      expect(list.find('num_200')).to be_nil
    end
  end

  describe '#to_a' do
    it 'returns an array containing key/value pairs of every node' do
      3.times { |i| list.add("num#{i}", i) }
      expect(list.to_a).to eq([{ key: 'num0', value: 0 }, { key: 'num1', value: 1 }, { key: 'num2', value: 2 }])
    end
  end
end
