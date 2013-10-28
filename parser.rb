require 'rubygems'
require 'crass'
require 'bruce-banner'

require_relative 'lib/node_printer'
require_relative 'lib/property_shrinker'
require_relative 'lib/tree_walker'
require_relative 'lib/tree_editor'

tree = Crass.parse(open('./overrides.css').read, preserve_comments: false)
# TreeWalker.new(tree, PropertyShrinker).walk
# bb "BEFORE: #{tree}"
editor = TreeEditor.new(tree, PropertyShrinker)
editor.walk
# bb "AFTER: #{editor.tree}"
