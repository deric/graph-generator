#!/usr/bin/env ruby

$LOAD_PATH << './'
require 'graph_export'

class Graph
  include GraphExport
  
  attr_reader :num_nodes, :filename, :queries
  
  def initialize(params)
    @params = params
    unless @params[:file][0] == '/'
     @filename = "#{File.dirname(__FILE__)}/../#{@params[:file]}"
    else
      @filename = @params[:file]
    end
    
    @num_nodes = @params[:nodes]
  end
  
  def generate
    create_vertices(@num_nodes)
    generate_edges()
    generate_queries()
  end
  
  def vertices
    @vert
  end
  
  private
  
  def create_vertices(num_nodes)
    @vert = Array.new(num_nodes)
    i = 0
    #generate specified given number of nodes
    while i < num_nodes
      @vert[i] = Vertex.new(i)
      i += 1
    end
  end
  
  def generate_edges
    num_edges = @params[:edges_mult] * @params[:nodes]
    r = Random.new
    range = 0...@num_nodes
    rand_num = r.method(:rand)
    
    j = 0
    while (j < num_edges && j < @num_nodes)
      a = j
      b = rand_num.call(range).to_i
      
      if (a != b && !@vert[a].has_neighbour?(b))
        add_edge(a,b)
        j += 1
      end
    end
  end
  
  def add_edge(node1_id, node2_id)
    @vert[node1_id].add_neighbour(node2_id)
    @vert[node2_id].add_neighbour(node1_id)
  end
  
  def generate_queries
    @queries = {}
    r = Random.new
    num_queries = r.rand(1...@num_nodes)
    
    range = 0...@num_nodes
    rand_num = r.method(:rand)
    i = 0
    while(i < num_queries)
      node = rand_num.call(range).to_i
      unless @queries.has_key?(node) # no need to assign search from same node
        alg = rand_num.call(0..1).to_i # zero means DFS, number one BFS
        @queries[node] = alg
        i += 1
      end
    end
  end
  
end