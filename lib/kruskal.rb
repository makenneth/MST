require 'byebug'
class Graph
  SUBSET = Struct.new(:parent, :rank)

  attr_reader :edges, :vertices
  def initialize(edges, vertices)
    @edges = edges
    @vertices = vertices
  end

  def find(subsets, vertex)
    if subsets[vertex].parent != vertex
      subsets[vertex].parent = find(subsets, subsets[vertex].parent)
    end

    subsets[vertex].parent
  end

  def union(subsets, v1, v2)
    if subsets[v2].rank > subsets[v1].rank
      subsets[v1].parent = v2
    elsif  subsets[v1].rank > subsets[v2].rank
      subsets[v2].parent = v1
    else
      subsets[v1].rank += 1
      subsets[v2].parent = v1
    end
  end

  def kruskal_mst
    result, subsets = [], {} 
    sorted_edges = @edges.sort {|e1, e2| e1.weight <=> e2.weight }

    vertices.each do |vertex|
      subsets[vertex] = SUBSET.new(vertex, 0)
    end

    num_of_edges, idx = 0, 0
    until num_of_edges >= vertices.length - 1
      cur_edge = sorted_edges[idx]
      idx += 1
      src, dest = find(subsets, cur_edge.src), find(subsets, cur_edge.dest)

      if src != dest
        union(subsets, src, dest)
        result << cur_edge
        num_of_edges += 1
      end
    end

    result
  end
end

class Edge
  attr_reader :src, :dest, :weight
  def initialize(src, dest, weight)
    @src = src
    @dest = dest
    @weight = weight
    src.to_edges << self
    dest.from_edges << self
  end

  def inspect
    "#{src.value} -- #{dest.value} (weight: #{weight})"
  end
end

class Vertex
  attr_reader :to_edges, :from_edges, :value
  def initialize(value)
    @value = value
    @to_edges = []
    @from_edges = []
  end

  def inspect
    @value
  end
end

if __FILE__ == $PROGRAM_NAME
  v0 = Vertex.new(0)
  v1 = Vertex.new(1)
  v2 = Vertex.new(2)
  v3 = Vertex.new(3)
  e1 = Edge.new(v0, v1, 10)
  e2 = Edge.new(v0, v2, 6)
  e3 = Edge.new(v0, v3, 5)
  e4 = Edge.new(v1, v3, 15)
  e5 = Edge.new(v2, v3, 4)
  g = Graph.new([e1, e2, e3, e4, e5], [v0, v1, v2, v3])
  result = g.kruskal_mst

  p result
end