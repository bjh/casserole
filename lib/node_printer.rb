class NodePrinter
  def initialize(node)
    @node = node
  end
  
  def execute
    raise 'override me you lazy bastard!'
  end
  
  def self.build(node)
    case node[:node]
      when :property;     return PropertyNodePrinter.new(node)
      when :style_rule;   return StyleRuleNodePrinter.new(node)
      else;               return NullNodePrinter.new(node)
    end      
  end
end

class NullNodePrinter < NodePrinter
  def execute
    ""
  end
end

class PropertyNodePrinter < NodePrinter
  def execute
    puts "\t#{@node[:name]} : #{@node[:value]}"
  end
end

class StyleRuleNodePrinter < NodePrinter
  def execute
    puts 
    puts "#{@node[:selector][:value]}"
  end
end
