#!/usr/bin/env ruby

module GraphExport
  # require class to have methods `num_nodes`, `vertices` and `filename`
  
  def to_sphere
    num_graphs = 1
    str = "#{num_graphs}\n#{num_nodes}\n"
    #export vertices
    for v in vertices
      str += "#{v.id+1} #{v.num_neighbours}"
      v.expand.each do |node|
        str += " #{node+1}"
      end
      str += "\n"
    end
    
    queries.each do |n, a|
      str += "#{n+1} #{a}\n"
    end
    str += "0 0\n" #end of queries

    save(filename, "txt", str)
  end
  
  def to_dot
    str = "digraph gr1 { \n"
    str += "\tedge [dir=none];\n"
    for v in vertices
      v.expand.each do |node|
	str += "\t#{v.id+1} -> #{node+1};\n" if (v.id < node)
      end
    end
    str += "}"
    ext = "dot"
    save(filename, ext, str)
    system("dot -Tpng #{filename}.#{ext} > #{filename}.png")
  end
  
  def save(name, ext, content)
    puts "writing to #{name}.#{ext}"
    File.open("#{name}.#{ext}", 'w') {|f| f.write(content) }
  end
end
