require_relative 'graph'
require_relative 'topological_sort'
# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to



def install_order(arr)
  vertices = []
  max_id = 0
  arr.flatten.each {|val| max_id = val if val > max_id}
  (1..max_id).each {|i| vertices << Vertex.new(i)}
  arr.each do |tup|
    Edge.new(vertices[tup[1]-1], vertices[tup[0]-1])
  end

  sorted = topological_sort(vertices)
  order = []
  sorted.each  {|v| order << v.value}
  order
end
