require 'byebug'
class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    if @prev.nil? && @next != nil
      @next.prev = nil
    elsif @next.nil? && @prev != nil
      @prev.next = nil
    elsif @next == nil && @prev == nil
      return
    else
      @prev.next = @next
      @next.prev = @prev
    end
  end
end

class LinkedList
  include Enumerable
  def initialize
    @list = []
    @list << Node.new
    @list << Node.new
  end

  def [](i)
    @list.each_with_index { |link, j| return link if i+1 == j }
    nil
  end

  def first
    unless @list.count <=2
      return @list[1]
    end
    nil
  end

  def last
    unless @list.count <=2
      return @list[-2]
    end
    nil
  end

  def empty?
    @list.count <= 2
  end

  def get(key)
    @list.each do |node|
      return node.val if node.key == key
    end
    nil
  end

  def include?(key)
    return true if get(key) != nil
    false
  end

  def append(key, val)
    # debugger
    node = Node.new(key,val)
    if self.empty?
      sent = @list.pop
      @list << node
      @list << sent
    elsif self.get(key) != nil
      update(key, val)
    else

      last_node = @list[-2]
      node.prev = last_node
      last_node.next = node
      sent = @list.pop
      @list << node
      @list << sent
    end
  end

  def update(key, val)
    node = @list.select {|x| x.key == key}.first
    return if node.nil?
    node.val = val
  end

  def remove(key)
    node = @list.select {|x| x.key == key }.first
    node.remove if node != nil
    @list.delete_if { |x| x.key == key }
  end

  def each(&prc)

    i = 1
    (1..@list.length-2).each do |i|
      prc.call(@list[i])
    end

    #
    # result = []
    # @list.each do |node|
    #   result << node
    # end
    # result
  end

  def to_s
    @list.map { |node| node.key }
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end

# hash =   { first: 1, second: 2, third: 3 }
# list = LinkedList.new
# hash.each do |key, val|
#   list.append(key, val)
# end
# list
