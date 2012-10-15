#!/usr/bin/env ruby

$LOAD_PATH << './lib'
require 'trollop'
require 'vertex'
require 'graph'

opts = Trollop::options do
  version "graph-generator 0.1 (c) 2012 deric"
  banner <<-EOS
This is a simple non-oriented graph generator

Usage:
       graph-generator [options] <filename>+
where [options] are:
  EOS

  opt :file, "File to write output (without extension)", :type => String, :default => "graph", :short => '-f'
  opt :nodes, "Number of nodes (vertices)", :short => "-n", :default => 10
  opt :edges_mult, "Multiplication factor * num_nodes = num_edges", :default => 1.5, :short => "-e"
  opt :min_edges, "Minimal number of edges for each node", :default => 1, :short => "-m"
end
Trollop::die :nodes, "must be non-negative" if opts[:nodes] < 0


g = Graph.new(opts)
g.generate

g.to_dot
g.to_sphere