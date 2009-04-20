class Treetop::Runtime::SyntaxNode
  def instructions(inst_set)
    elements.each do |node|
      node.instructions(inst_set) if !node.kind_of?(SpacesNode)
    end if elements
  end
end

class ProgramNode < Treetop::Runtime::SyntaxNode
  def instructions(inst_set = InstructionsBuilder.new)
    commands.instructions(inst_set)
    inst_set
  end
end

class DeclarationNode < Treetop::Runtime::SyntaxNode
  # FIXME: not needed through the dynamic vm
end

class IdentifierSequenceNode < Treetop::Runtime::SyntaxNode
  # FIXME: not needed through the dynamic vm
end

class CommandSequenceNode < Treetop::Runtime::SyntaxNode
end

class AssignmentNode < Treetop::Runtime::SyntaxNode
  def instructions(inst_set)
    math_expression.instructions(inst_set)
    inst_set << [:STORE, identifier.text_value]
  end
end

class IfThenConditionNode < Treetop::Runtime::SyntaxNode
  def instructions(inst_set)
    expression.instructions(inst_set)
    inst_set.jmp_false do 
      commands.instructions(inst_set)
    end
  end
end

class IfThenElseConditionNode < Treetop::Runtime::SyntaxNode
  def instructions(inst_set)
    expression.instructions(inst_set)
    end_pos = [:GOTO, -1]
    inst_set.jmp_false do
      then_commands.instructions(inst_set)
      inst_set << end_pos
    end
    else_commands.instructions(inst_set)
    end_pos[1] = inst_set.icounter
  end
end

class WhileNode < Treetop::Runtime::SyntaxNode
  def instructions(inst_set)
    goto_position = inst_set.icounter
    expression.instructions(inst_set)
    inst_set.jmp_false do
      commands.instructions(inst_set)
      inst_set << [:GOTO, goto_position]
    end
  end
end

class ReadCommandNode < Treetop::Runtime::SyntaxNode
  def instructions(inst_set)
    inst_set << [:READ_INT, identifier.text_value.to_sym]
  end
end

class WriteCommandNode < Treetop::Runtime::SyntaxNode
  def instructions(inst_set)
    math_expression.instructions(inst_set)
    inst_set << [:WRITE_INT]
  end
end

class SkipCommandNode < Treetop::Runtime::SyntaxNode
  def instructions(inst_set)
    inst_set << [:SKIP]
  end
end

class SpacesNode < Treetop::Runtime::SyntaxNode
end

class MathExpressionNode < Treetop::Runtime::SyntaxNode
  def instructions(inst_set)
    elements[0].instructions(inst_set)
    elements[1].instructions(inst_set)
  end
end

class TermNode < Treetop::Runtime::SyntaxNode
  def instructions(inst_set)
    elements[0].instructions(inst_set)
    pp elements
    puts "====== END TERM ======"
    if respond_to? :additive
      case additive.text_value
      when "+"
        inst_set << [:ADD]
      when "-"
        inst_set << [:SUB]
      end
    end
  end
end

class FactorNode < Treetop::Runtime::SyntaxNode
  def instructions(inst_set)
    pp elements
    puts "====== END FACTOR ======"
  end
end

class NumberNode < Treetop::Runtime::SyntaxNode
  def instructions(inst_set)
    inst_set << [:LD_INT, text_value.to_i]
  end
end

class IdentifierNode < Treetop::Runtime::SyntaxNode
  def instructions(inst_set)
    inst_set << [:LD_VAR, text_value.to_sym]
  end
end 

class ExpressionNode < Treetop::Runtime::SyntaxNode
  def instructions(inst_set)
    first_expression.instructions(inst_set)
    second_expression.instructions(inst_set)
    case elements[2].text_value
      when "<"
        inst_set << [:LT]
      when "="
        inst_set << [:EQ]
      when ">"
        inst_set << [:GT]
    end
  end
end
