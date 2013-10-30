require 'rubygems'
require 'csspool'

require_relative 'lib/adjustment_bureau'

Scale = 4

doc = CSSPool.CSS open('./css/overrides.css')

doc.rule_sets.collect do |rule|
  puts rule.selectors.join(', ') + ' {'
  
  rule.declarations.each do |decl|
    puts AdjustmentBureau.new(decl, Scale).adjust
  end
  
  puts '}'
end
