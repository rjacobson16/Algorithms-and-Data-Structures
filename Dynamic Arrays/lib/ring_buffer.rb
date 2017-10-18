require_relative "static_array"
require 'byebug'

class RingBuffer
  attr_reader :length

  def initialize
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @length = 0
    @start_idx = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[(start_idx + index) % capacity]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    @length += 1 if @store[index].nil?
    @store[(start_idx + index) % capacity] = val

  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length == 0
    item = @store[(start_idx + (@length-1)) % capacity]
    @length -=1
    item
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity
    @store[(start_idx + @length) % capacity] = val
    @length +=1
  end

  # O(1)
  def shift
    raise 'index out of bounds' if @length == 0
    item = @store[@start_idx]
    @store[@start_idx] = nil

    @start_idx = (@start_idx + 1) % @capacity

    @length -=1
    item
  end

  # O(1) ammortized
  def unshift(val)
    if @length == @capacity
      resize!
    end

    @start_idx  = (@start_idx -1) % @capacity

    @length +=1
    @store[@start_idx] = val

  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    unless index >= 0 && index < length
     raise "index out of bounds"
    end
  end

  def resize!
    new_store = StaticArray.new(2*@capacity)
    new_store_length = 0

    while new_store_length < @length
      new_store[new_store_length] = self[new_store_length]
      new_store_length +=1

    end
    @capacity *=2
    @start_idx = 0
    @store = new_store
  end
end
