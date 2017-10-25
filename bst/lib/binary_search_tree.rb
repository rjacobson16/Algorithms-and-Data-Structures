# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require_relative 'bst_node.rb'
require 'byebug'

class BinarySearchTree
  attr_reader :root
  def initialize
    @root = nil
  end

  def insert(value)
    n = BSTNode.new(value)
    if @root.nil?
      @root = n
      return @root
    end

    n.value <= @root.value ? add_to_left(n, @root) : add_to_right(n, @root)
  end

  def find(value, tree_node = @root)
    return nil if tree_node.nil?
    return tree_node if tree_node.value == value

    if value >= tree_node.value
      find(value, tree_node.right)
    else
      find(value, tree_node.left)
    end
  end

  def delete(value)
    node = find(value)
    return false if node.nil?

    if (has_no_children?(node)&& node == @root)
      @root = nil
      return node
    end

    if has_no_children?(node)
      parent = node.parent
      parent.left == node ? parent.left = nil : parent.right = nil
    elsif has_one_child?(node)
      child = node.left.nil? ? node.right : node.left
      parent = node.parent
      parent.left == node ? parent.left = child : parent.right = child
    end
    return node
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
  end

  def depth(tree_node = @root)
  end

  def is_balanced?(tree_node = @root)
  end

  def in_order_traversal(tree_node = @root, arr = [])
  end


  private


  # optional helper methods go here:
  def add_to_left(new_node, old_node)

    if old_node.left.nil?
      old_node.left = new_node
      new_node.parent = old_node
    elsif
      new_node.value <= old_node.left.value
      add_to_left(new_node, old_node.left)
    else
      add_to_right(new_node, old_node.left)
  end
end

  def add_to_right(new_node, old_node)

    if old_node.right.nil?
      old_node.right = new_node
      new_node.parent = old_node
    elsif
      new_node.value <= old_node.right.value
      add_to_left(new_node, old_node.right)
    else
      add_to_right(new_node, old_node.right)
    end
  end

  def has_no_children?(node)
    node.left.nil? && node.right.nil?
  end

  def has_one_child? (node)
    node.left.nil? ^ node.right.nil?
  end
end
