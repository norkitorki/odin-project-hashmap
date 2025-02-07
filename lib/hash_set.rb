# frozen_string_literal: true

require_relative 'hash_map'

class HashSet < HashMap
  undef_method :values, :entries

  def set(key)
    insert_item(key, nil)
    resize_buckets('append')
  end

  def get(key)
    find_list(key)&.find(key)&.key
  end

  def remove(key)
    remove_item(key, :key)
  end
end
