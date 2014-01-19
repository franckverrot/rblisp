require 'rubygems'
require 'treetop'
require "minitest/autorun"
require 'pp'
require 'pry'

module ParserTestHelper
  def assert_evals_to_self(input)
    assert_evals_to(input, input)
  end

  def parse(input)
    result = @parser.parse(input)
    if !result
      puts @parser.terminal_failures.join("\n")
      pp @parser
    end

    #assert_instance_of RbLisp::Expression, result, "Eval'ed: #{input}"
    #clean_tree(result)
    result
  end

  def clean_tree(root_node)
    return if(root_node.elements.nil?)
    root_node.elements.delete_if{|node| node.class.name == "Treetop::Runtime::SyntaxNode" }
    root_node.elements.each {|node| self.clean_tree(node) }
  end

end
