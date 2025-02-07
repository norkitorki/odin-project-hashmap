# frozen_string_literal: true

require_relative 'linked_list'

class HashMap
  def initialize
    @capacity    = 16
    @buckets     = Array.new(@capacity)
    @node_count  = 0
    assign_load_factor
  end

  def hash(key)
    key.to_s.chars.reduce(0) { |h, c| (31 * h) + c.ord }
  end

  def set(key, value)
    insert_item(key, value)
    resize_buckets('append')
  end

  def get(key)
    find_list(key)&.find(key)&.value
  end

  def has?(key)
    !get(key).nil?
  end

  def remove(key)
    remove_item(key, :value)
  end

  def length
    @node_count
  end

  def clear
    initialize && true
  end

  def keys
    collect_node_properties([0])
  end

  def values
    collect_node_properties([1])
  end

  def entries
    collect_node_properties([0, 1])
  end

  private

  def assign_load_factor
    @load_factor = @capacity * 0.75
  end

  def check_buckets_in_bounds(index)
    raise IndexError unless index.between?(0, @capacity - 1)
  end

  def find_index(key)
    index = hash(key) % @capacity
    check_buckets_in_bounds(index)
    index
  end

  def find_list(key)
    index = find_index(key)
    @buckets[index]
  end

  def collect_node_properties(indices = [])
    arr = []
    @buckets.each { |list| list.to_a.each { |node| arr << (indices.length < 2 ? node[indices.first] : node) } }
    arr
  end

  def insert_item(key, value)
    index = find_index(key)
    @buckets[index] = LinkedList.new unless @buckets[index].instance_of?(LinkedList)
    updated = @buckets[index].add(key, value)
    @node_count += 1 unless updated == true
  end

  def remove_item(key, return_property)
    property = find_list(key)&.remove(key)&.send(return_property)
    return nil unless property

    @node_count -= 1
    resize_buckets('remove')
    property
  end

  def update_capacity(operation)
    operation == 'append' ? @capacity *= 2 : (@capacity /= 2 unless @capacity / 2 < 16)
  end

  def resize_buckets(operation)
    return unless operation == 'append' ? @node_count > @load_factor : @node_count > 16 && @node_count < @load_factor

    update_capacity(operation)
    old_buckets = @buckets
    @buckets = Array.new(@capacity)
    @node_count = 0
    assign_load_factor
    old_buckets.each { |l| l.to_a.each { |n| n.instance_of?(Array) ? insert_item(n.first, n.last) : insert_item(n) } }
  end
end
