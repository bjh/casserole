class PropertyShrinker
  def initialize(node)
    @scale = 2.5
    @node = node
    @operands = [
      :height, 
      :width,
      :padding,
      :'padding-top',
      :'padding-right',
      :'padding-bottom',
      :'padding-left',
      :margin,
      :'margin-top',
      :'margin-right',
      :'margin-bottom',
      :'margin-left',
      :'background-position',
      :'line-height',
      :'font-size'
    ]
  end
  
  def execute
    raise 'override me you lazy bastard!'
  end
  
  def self.build(node)
    case node[:node]
      when :property;     return NumericPropertyShrinker.new(node)
      else;               return NullPropertyShrinker.new(node)
    end
  end
end

class NullPropertyShrinker < PropertyShrinker
  def execute
    @node
  end
end

class NumericPropertyShrinker < PropertyShrinker
  def execute
    return @node if not @operands.include? @node[:name].to_sym    
    
    @node[:value] = scale_values(@node[:value].strip)
    @node
  end
  
  private
  
  def parse(value)
    value = value.strip
    
    return [
      # NOTE: .to_i handles negative numbers...
      value.to_i,
      /[^0-9]*$/.match(value)[0]
    ]
  end
  
  def scale_values(values)
    values.split(' ').collect do |value|
      n, unit = parse(value)
      "#{n*@scale}#{unit}"
    end.join(' ')
  end
end
