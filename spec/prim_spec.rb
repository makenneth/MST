require 'rspec'
require 'prim'

describe "Prim Minimum Spanning Tree" do
  let(:v0) { Vertex.new(0)}
  let(:v1) { Vertex.new(1)}
  let(:v2) { Vertex.new(2)}
  let(:v3) { Vertex.new(3)}
  let(:v4) { Vertex.new(4)}
  let(:vertices) { [v0, v1, v2, v3, v4] }
  let(:e1) { Edge.new(v0, v1, 2) }
  let(:e2) { Edge.new(v0, v3, 6) }
  let(:e3) { Edge.new(v1, v2, 3) }
  let(:e4) { Edge.new(v1, v3, 8) }
  let(:e5) { Edge.new(v1, v4, 5) }
  let(:e6) { Edge.new(v2, v4, 7) }
  let(:e7) { Edge.new(v3, v4, 9) }
  let(:edges) { [e1, e2, e3, e4, e5, e6, e7] }
  let(:graph) { Graph.new(edges, vertices) }
  context "#find_min" do
    it "returns the edge with the current minimum cost" do
      costs = {
        a: {
          edge: 2,
          cost: 3
        },
        b: {
          edge: 3,
          cost: 5
        }
      }
      visited = {}
      expect(graph.find_min(visited, costs)[0]).to eq(:a)
    end

    it "does not return an edge that creates a cyclical tree" do
      costs = {
        a: {
          edge: 2,
          cost: 3
        },
        b: {
          edge: 3,
          cost: 5
        }
      }
      visited = { a: true }
      expect(graph.find_min(visited, costs)[0]).to eq(:b)
    end
  end
  context "#mst" do
    it "returns a result that has a length of num of vertices - 1" do
      expect(graph.prim_mst.length).to eq(4)
    end
    it "returns a mst" do
      result = graph.prim_mst
      expect(result[0]).to eq(e1)
      expect(result[1]).to eq(e3)
      expect(result[2]).to eq(e5)
      expect(result[3]).to eq(e2)
    end
  end
end