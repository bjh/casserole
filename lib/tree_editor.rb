class TreeEditor
  attr_accessor :tree
  
  def initialize(tree, node_editor)
    @tree = tree
    @node_editor = node_editor
  end
  
  def walk
    walk_helper(@tree)
  end
  
private
  def walk_helper(tree)
    tree.each do |node|
      node = @node_editor.build(node).execute
      
      if children? node
        walk_helper(node[:children])
      end      
    end
  end
  
  def children?(node)
    node.include? :children
  end
end
