#!/usr/bin/env ruby

class Vertex
  attr_reader :id
  attr_accessor :status
  
  def initialize(id)
    @list = []
    @id = id
  end
  
  def add_neighbour(node)
    @list << node
  end
  
  def has_neighbour?(id)
    @list.include?(id)
  end
  
  def num_neighbours
    @list.size
  end
  
  def expand 
    return @list
  end
end