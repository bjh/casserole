class TreeEditor
  attr_accessor :tree
  
  def initialize(tree, node_editor)
    @tree = tree
    @node_editor = node_editor
  end
  
  def walk
    @tree = walk_helper(@tree)
  end
  
private
  def walk_helper(tree)
    return tree.map do |node|
      if children? node
        what = node[:children].map do |child|
          @node_editor.build(child).execute
        end
      end
      
      node
    end
  end
  
  def children?(node)
    node.include? :children
  end
end
