class MaxIntSet
  def initialize(max)
    @set = Array.new(max)
  end

  def insert(num)
    if num > @set.size || num < 0
     raise 'Out of bounds'
   else
       @set[num] = num
   end
  end

  def remove(num)
    @set[num] = nil
  end

  def include?(num)
     @set.include?(num)
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    unless self.include?(num)
      @store[num % @store.size] << num
    end
  end

  def remove(num)
    bucket = num % @store.size
    if @store[bucket].include?(num)
      @store[bucket].delete(num)
    end
  end

  def include?(num)
    @store[num % @store.size].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return if self.include?(num)
    resize! if @count >= @store.size
    self[num] << num
    @count += 1

  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % @store.size]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old = @store.dup
    @count = 0
    new_set = Array.new(@store.size*2) {Array.new}
    @store = new_set
    old.each do |bucket|
      bucket.each do |el|
        self.insert(el)
      end
    end
  end
end
