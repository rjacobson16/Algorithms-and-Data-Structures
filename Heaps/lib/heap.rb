require 'byebug'

class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @count = count


    @prc = prc

    # ||= Proc.new {|x, y| x <=> y}
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    out = @store.pop
    BinaryMinHeap.heapify_down(@store, 0)
    out
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    new_node_idx = @store.length-1

    BinaryMinHeap.heapify_up(@store, new_node_idx)
    @store
  end

  public
  def self.child_indices(len, parent_index)
    left = (2*parent_index + 1)
    right = (2*parent_index + 2)

    indices = []

    indices << left if left < len
    indices << right if right < len
    indices
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0

    child_index.odd? ? (child_index-1)/2 : (child_index-2)/2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new {|x,y| x <=> y}
    return array if child_indices(len, parent_idx).empty?

    if child_indices(len, parent_idx).length == 2
      if prc.call(array[child_indices(len, parent_idx)[0]], array[child_indices(len, parent_idx)[1]]) == -1
        smaller_child_idx = child_indices(len, parent_idx)[0]
      else
        smaller_child_idx = child_indices(len, parent_idx)[1]
      end
    else
      smaller_child_idx = child_indices(len, parent_idx)[0]
    end


    if prc.call(array[parent_idx], array[smaller_child_idx]) == 1

      array[parent_idx], array[smaller_child_idx] = array[smaller_child_idx], array[parent_idx]
      heapify_down(array, smaller_child_idx, len, &prc)

    end

    array


  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new {|x,y| x<=>y}
    return array if child_idx == 0
    parent_idx = self.parent_index(child_idx)
    if prc.call(array[parent_idx], array[child_idx]) == 1
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
    end

    if (parent_idx != 0)
      if prc.call(array[self.parent_index(parent_idx)], array[parent_idx]) == 1
        heapify_up(array, parent_idx, &prc)
      end
    end
    return array

  end
end
