require 'test_helper'
require 'nodes'
Treetop.load 'grammar'

class RbLispTest < MiniTest::Test
  include ParserTestHelper

  def setup
    @parser = RbLispParser.new
  end

  def test_parse_expr_1
    assert_equal 1, parse("(1)").eval
  end

  def test_parse_define
    assert_equal 1, parse("(define x 1)").eval
  end

  def parse_expr_plus
    assert_equal 2, parse("(+ 1 1)").eval
  end
end
