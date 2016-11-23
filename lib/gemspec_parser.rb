# frozen_string_literal: true
require 'parser/current'

class GemspecParser
  extend AST::Sexp

  def self.parse(gemspec)
    ast = Parser::CurrentRuby.parse(gemspec)
    spec_block = find_node(ast, [:block, s(:send, s(:const, s(:const, nil, :Gem), :Specification), :new)], :begin)

    data = {}
    spec_block.children.each do |n|
      next if n.children.length < 3
      next if n.children[0] != s(:lvar, :spec)
      next if n.children[2].type != :str
      key   = n.children[1].to_s.delete('=').to_sym
      value = n.children[2].children.first
      if data[key]
        data[key] = [data[key]] unless data[key].class == Array
        data[key] << value
      else
        data[key] = value
      end
    end
    data
  end

  private_class_method

  def self.find_node(root, *match_path)
    return unless root.respond_to?(:children)
    (type, match) = match_path.shift

    root.children.each do |child|
      next if child.type != type
      next if !match.nil? && child.children.first != match
      return child if match_path.empty?
      return find_node(child, match_path)
    end
  end
end
