require 'rubygems'
require 'crass'
require 'bruce-banner'

require_relative 'lib/node_printer'
require_relative 'lib/property_adjuster'
require_relative 'lib/tree_walker'
require_relative 'lib/tree_editor'

tree = Crass.parse(open('./small.css').read, preserve_comments: false)
# tree2 = Crass.parse(open('./overrides.css').read, preserve_comments: false)
# TreeWalker.new(tree, NodePrinter).walk
# bb Crass::Parser.stringify(tree)
# puts tree.to_s

editor = TreeEditor.new(tree, PropertyAdjuster)
editor.walk
# puts editor.tree.to_s
TreeWalker.new(editor.tree, NodePrinter).walk

editor2 = TreeEditor.new(editor.tree, PropertyAdjuster)
editor2.walk
TreeWalker.new(editor2.tree, NodePrinter).walk

# bb "AFTER: #{editor.tree}"
# puts Crass::Parser.stringify(editor.tree)
