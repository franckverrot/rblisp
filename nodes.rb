module RbLisp
  class Node < Treetop::Runtime::SyntaxNode
  end

  class IntegerLiteral < Node
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

  class StringLiteral < Node
    def value(env={})
      self.text_value[1..-2]
    end
  end

  class FloatLiteral < Node
    def eval(env={})
      binding.pry
    end

    def value(env={})
      self.text_value.to_f
    end
  end

  class FunctionCall < Node
    def eval(env={})
      binding.pry
    end
  end

  class FunctionDefinition
    def initialize(func)
      @parameters = func.parameters
      @expression = func.expression
    end
  end

  class Function < Node
    def eval(env={})
      env[self.__id__] = FunctionDefinition.new(self)
      self.__id__
    end
  end

  class Identifier < Node
    def eval(env={})
      env[self.text_value]
    end

    def value(env={})
      env[self.text_value]
    end
  end


  class Expression < Node
    def eval(env={})
      self.body.eval(env)
    end
  end

  class Add < Node
    def eval(env={})
      self.car.value(env) + self.cdr.value(env)
    end
  end

  class Mul < Node
    def eval(env={})
      self.car.value(env) * self.cdr.value(env)
    end
  end

  class Body < Node
    def eval(env={})
      last = nil
      self.elements.map {|e| last = e.eval(env); binding.pry }
      last
    end
  end

  class Define < Node
    def eval(env={})
      env[identifier.text_value] = self.definition.value(env)
    end
  end

  class Program < Node
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
