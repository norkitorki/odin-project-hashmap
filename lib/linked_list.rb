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
    @size = 0
  end

  def add(key, value)
    node = find(key)
    if node
      node.value = value unless node.value.nil? && value.nil?
      return true
    end

    @head = Node.new(key, value, head)
    @size += 1
  end

  def remove(key)
    (node, previous_node) = find(key, return_previous: true)
    return nil unless node

    node == head ? @head = head&.next : previous_node.next = node&.next
    @size -= 1
    node
  end

  def find(key, return_previous: false)
    iterate { |node, previous_node| (return return_previous ? [node, previous_node] : node) if node.key == key }
    nil
  end

  def to_a
    arr = []
    iterate { |node| arr << [node.key, node.value] }
    arr
  end

  private

  def iterate(index = size)
    node = head
    previous_node = nil
    i = 0
    while node && i < index
      yield node, previous_node, i if block_given?
      previous_node = node
      node = node.next
      i += 1
    end
    node
  end
end
