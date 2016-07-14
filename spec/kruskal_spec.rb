require "rspec"
require "kruskal"

describe "Kruskal Minimum Spanning Tree" do 
  let(:kv0){ Vertex.new(0) }
  let(:kv1){ Vertex.new(1) }
  let(:kv2){ Vertex.new(2) }
  let(:kv3){ Vertex.new(3) }
  let(:ke1){ Edge.new(kv0, kv1, 10) }
  let(:ke2){ Edge.new(kv0, kv2, 6) }
  let(:ke3){ Edge.new(kv0, kv3, 5) }
  let(:ke4){ Edge.new(kv1, kv3, 15) }
  let(:ke5){ Edge.new(kv2, kv3, 4) }
  let(:graph1) { Graph.new([ke1, ke2, ke3, ke4, ke5], [kv0, kv1, kv2, kv3]) }
  SUBSET = Struct.new(:parent, :rank)
  context "#find" do 
    it "returns the root of a connection" do

      subsets = { 
        "a" => SUBSET.new("b", 0), 
        "b" => SUBSET.new("b", 1)
      }
      vertex_a = "a"
      vertex_b = "b"
      expect(graph1.find(subsets, vertex_a)).to eq("b")
      expect(graph1.find(subsets, vertex_b)).to eq("b")
    end
  end

  context "#MST" do
    it "returns a minimum spanning tree" do 
      result1 = graph1.kruskal_mst
      expect(result1).to eq([ke5, ke3, ke1])
    end
  end
end