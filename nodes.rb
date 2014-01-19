module RbLisp
  class IntegerLiteral < Treetop::Runtime::SyntaxNode
    def eval(env={})
      value
    end

    def +(operand)
      value + operand.value
    end

    def value(env={})
      self.text_value.to_i
    end
  end

  class StringLiteral < Treetop::Runtime::SyntaxNode
    def value(env={})
      self.text_value[1..-2]
    end
  end

  class FloatLiteral < Treetop::Runtime::SyntaxNode
    def eval(env={})
      binding.pry
    end

    def value(env={})
      self.text_value.to_f
    end
  end

  class Function < Treetop::Runtime::SyntaxNode
    def eval(env={})
      self.expression
    end
  end

  class Identifier < Treetop::Runtime::SyntaxNode
    def eval(env={})
      env[self.text_value]
    end

    def value(env={})
      env[self.text_value]
    end
  end


  class Expression < Treetop::Runtime::SyntaxNode
    def eval(env={})
      self.body.eval(env)
    end
  end

  class Add < Treetop::Runtime::SyntaxNode
    def eval(env={})
      self.car.value(env) + self.cdr.value(env)
    end
  end

  class Mul < Treetop::Runtime::SyntaxNode
    def eval(env={})
      self.car.value(env) * self.cdr.value(env)
    end
  end

  class Body < Treetop::Runtime::SyntaxNode
    def eval(env={})
      last = nil
      self.elements.map {|e| last = e.eval(env) }
      last
    end
  end

  class Define < Treetop::Runtime::SyntaxNode
    def eval(env={})
      env[identifier.text_value] = self.definition.value(env)
    end
  end

  class Program < Treetop::Runtime::SyntaxNode
    def eval(env={})
      env = env.clone
      last_eval = nil
      expressions.each do |exp|
        last_eval = exp.eval(env)
      end
      [last_eval, env]
    end

    def expressions
      [expression] + more_expressions.elements.map {|elt| elt.expression}
    end
  end
end
