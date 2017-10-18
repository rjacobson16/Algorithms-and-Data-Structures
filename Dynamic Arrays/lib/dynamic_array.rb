require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @length = 0
    @start_idx = 0;
  end

  # O(1)
  def [](index)
    raise 'index out of bounds' if index >= @length
    return @store[index]
  end

  # O(1)
  def []=(index, value)
    @length += 1 if @store[index].nil?
    @store[index] = value

  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length == 0
    item = @store[length-1]
    @store[length-1] = nil
    @length -=1
    return item
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity

    @store[@length] = val
    @length +=1
  end

  # O(n): has to shift over all the elements.
  def shift
     raise 'index out of bounds' if @length == 0
    # item = @store[0]
    # new_store = StaticArray.new(@capacity)
    # @length -=1
    # counter = 0
    #
    # while counter < @length
    #   new_store[counter] = @store[counter+1]
    #   counter +=1
    # end
    #
    # @store = new_store
    @length -=1
    item = @store[@start_idx]
    @store[@start_idx] = nil
    @start_idx += 1
    item
    # return item
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == @capacity

    new_store = StaticArray.new(@capacity)

    new_store[0] = val
    counter = 0

    while counter < @length
      new_store[counter+1] = @store[counter]
      counter +=1
    end

    @store = new_store

    @length +=1

  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
      @capacity *=2
      new_store = StaticArray.new(@capacity)
      new_store_length = 0

      while new_store_length < @length
        new_store[new_store_length] = @store[new_store_length]
        new_store_length +=1

      end

      @store = new_store

  end
end
