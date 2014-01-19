require 'test_helper'
require 'nodes'
Treetop.load 'grammar'

class RbLispTest < MiniTest::Test
  include ParserTestHelper

  def setup
    @parser = RbLispParser.new
  end

  def test_parse_expr_1
    result, env = parse("(1)").eval({})
    assert_equal 1, result
    assert_equal env, {}
  end

  def test_parse_define
    result, env = parse("(define x 1)").eval
    assert_equal 1, result
    assert_equal env, {"x" => 1}
  end

  def test_get_identifier_from_env
    result, env = parse("(x)").eval('x' => 42)
    assert_equal 42, result
    assert_equal env, {"x" => 42}
  end

  def test_add_literal
    result, env = parse("(+ 42 42)").eval
    assert_equal 84, result
    assert_equal env, {}
  end

  def test_add_identifier_to_literal
    result, env = parse("(+ x 42)").eval('x' => 42)
    assert_equal 84, result
    assert_equal env, {'x' => 42}
  end

  def test_add_identifier_to_literal
    result, env = parse("(+ x y)").eval('x' => 42, 'y' => 42)
    assert_equal 84, result
    assert_equal env, {'x' => 42, 'y' => 42}
  end
end
