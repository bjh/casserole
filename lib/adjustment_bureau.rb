class AdjustmentBureau
  def initialize(property, scale)
    @scale = scale
    # @original_property = property
    @property = parse(property.to_s)
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
  
  def adjust
    if @operands.include? @property[:name]
      @property = scale(@property)
    end
    
    stringify(@property)
  end
  
  def stringify(property)
    "  #{@property[:name]}: #{@property[:value]};"
  end
  
  private

  def parse(property)
    p = property.split(':')
    
    return {
      name:  p[0].strip.to_sym,
      value: p[1].strip.gsub(/\;/, ''),
    }
  end
  
  def scale(property)
    property[:value] = property[:value].split(' ').collect do |value|
      n, unit = parse_value(value)
      
      if numeric? n
        "#{(n*@scale).to_i}#{unit}"
      else
        "#{n}"
      end
    end.join(' ')
    
    property
  end
  
  def numeric?(value)
    /^[0-9]/.match(value.to_s)
  end
  
  # returns the integer value and the unit type in a an array
  def parse_value(field)
    n = field.strip

    # usually 'auto' when not a number
    if numeric? n
      n = n.to_i
    end
      
    return [
      # NOTE: .to_i handles negative numbers...
      n,
      /[^0-9]*$/.match(field.strip)[0]
    ]
  end
end