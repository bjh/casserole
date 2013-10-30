require 'rubygems'
require 'csspool'

require_relative 'lib/adjustment_bureau'

doc = CSSPool.CSS open('./small.css')

doc.rule_sets.collect do |rule|
  puts rule.selectors.join(', ') + ' {'
  
  rule.declarations.each do |decl|
    puts AdjustmentBureau.new(decl).adjust
  end
  
  puts '}'
end
