class TreeWalker
  def initialize(tree, printer)
    @tree = tree
    @printer = printer
    @depth = 0
  end
  
  def walk
    walk_helper(@tree, @depth)
  end
  
private
  def walk_helper(tree, depth)
    tree.each do |node|
      @printer.build(node).execute
      
      if children? node
        walk_helper(node[:children], depth+1)
      end      
    end
  end
  
  def children(node)
    node[:children]
  end
  
  def children?(node)
    node.include? :children
  end
end
