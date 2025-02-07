# frozen_string_literal: true

class LinkedList
  attr_reader :head, :size

  class Node
    attr_accessor :value, :next
    attr_reader :key

    def initialize(key, value, next_node = nil)
      @key   = key
      @value = value unless value.nil?
      @next = next_node
    end
  end

  def initialize
    @head = nil
    @size = 0
  end

  def add(key, value)
    node = find(key)
    if node
      node.value = value unless node.value.nil? && value.nil?
      return true
    end

    new_node = Node.new(key, value)
    @head.nil? ? @head = new_node : iterate(size - 1).next = new_node
    @size += 1
  end

  def remove(key)
    node = find(key)
    return nil unless node

    if node == @head
      @head = head&.next
    else
      iterate { |n| break n.next = node.next if n.next == node }
    end

    @size -= 1
    node
  end

  def find(key)
    iterate { |node| return node if node.key == key }
    nil
  end

  def to_a
    arr = []
    iterate { |node| arr << (node.value.nil? ? node.key : [node.key, node.value]) }
    arr
  end

  private

  def iterate(index = size)
    node = head
    i = 0
    while node && i < index
      yield node, i if block_given?
      node = node.next
      i += 1
    end
    node
  end
end
