require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  sorted = []
  top  = []

  vertices.each do |v|
    if v.in_edges.empty?
      top.unshift(v)
    end
  end

  vertices_dup = vertices
  until top.empty?
    current = top.pop
    sorted << current
    vertices_dup -= [current]
    current.out_edges.each do |e|
      e.to_vertex.in_edges -= [e]
      if e.to_vertex.in_edges.empty?
        top.unshift(e.to_vertex)
      end
      current.out_edges -= [e]
    end
  end
  return sorted if vertices_dup.empty?
  []
end
