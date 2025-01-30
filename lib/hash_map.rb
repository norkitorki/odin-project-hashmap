# frozen_string_literal: true

class HashMap
  def initialize
    @load_factor = 0.8
    @capacity    = 16
    @buckets     = Array.new(@capacity)
  end
end
