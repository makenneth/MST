require 'byebug'
class Graph
  attr_reader :edges, :vertices

  def initialize(edges, vertices)
    @edges = edges
    @vertices = vertices
  end

  def prim_mst
    result, visited, costs = [], {}, Hash.new(Float::INFINITY)
    first_vertex, cur_edge = edges.first.src, cur_edge

    costs[vertices.first] = {
      cost: -1,
      edge: nil
    }  
  
    vertices_added = 0
    while vertices_added < vertices.length
      cur_vertex, hash = find_min(visited, costs)
      visited[cur_vertex] = true
      result.push << hash[:edge]
      cur_vertex.out_edges.each do |edge|
        cost, dest = edge.cost, edge.dest
        if !visited[dest] && (costs[dest] == Float::INFINITY || cost < costs[dest][:cost])
          costs[dest] = {
            cost: cost,
            edge: edge 
          }
        end
      end

      vertices_added += 1
    end

    result.drop(1)
  end

  def find_min(visited, costs)
    min = Float::INFINITY 
    min_vertex, min_hash = nil, nil 

    costs.each do |vertex, hash|
      if hash[:cost] < min && !visited[vertex]
        min = hash[:cost]
        min_vertex = vertex
        min_hash = hash
      end
    end

    [min_vertex, min_hash]
  end
end


class Edge
  attr_reader :src, :dest, :cost
  def initialize(src, dest, cost)
    @src = src
    @dest = dest
    @cost = cost
    src.out_edges << self
    dest.in_edges << self 
  end

  def inspect
    "#{src.value} -- #{dest.value} (weight: #{cost})"
  end
end

class Vertex
  attr_reader :out_edges, :in_edges, :value
  def initialize(value)
    @value = value
    @out_edges = []
    @in_edges = []
  end

  def inspect
    value
  end
end