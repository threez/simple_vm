class Treetop::Runtime::SyntaxNode
  def instructions(inst_set)
    elements.each do |node|
      node.instructions(inst_set)
    end if elements
  end
end

class ProgramNode < Treetop::Runtime::SyntaxNode
  def instructions(inst_set = InstructionsBuilder.new)
    if declarations
      declarations.instructions(inst_set)
      inst_set << inst_set.data_instruction
    end
    commands.instructions(inst_set)
    inst_set << [:HALT, 0]
    inst_set
  end
end

class DeclarationNode < Treetop::Runtime::SyntaxNode
  def instructions(inst_set)
    id_seq.all_identifiers.each do |identifier|
      inst_set.declare_variable(type.text_value, identifier.text_value)
    end if id_seq.all_identifiers
  end
end

class IdentifierSequenceNode < Treetop::Runtime::SyntaxNode
  def all_identifiers(list = [])
    list << identifier
    if id_seq and id_seq.kind_of? IdentifierSequenceNode
      id_seq.all_identifiers(list)
    elsif id_seq
      list << id_seq # last identifier
    end
    list
  end
end

class AssignmentNode < Treetop::Runtime::SyntaxNode
  def instructions(inst_set)
    additive.instructions(inst_set)
    inst_set << [:STORE, inst_set.variable_register(identifier.text_value)]
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
      end_pos[1] = inst_set.icounter # set correct goto position (behind else)
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
    inst_set << [:READ_INT]
    inst_set << [:STORE, inst_set.variable_register(identifier.text_value)]
  end
end

class WriteCommandNode < Treetop::Runtime::SyntaxNode
  def instructions(inst_set)
    additive.instructions(inst_set)
    inst_set << [:WRITE_INT]
  end
end

class SkipCommandNode < Treetop::Runtime::SyntaxNode
  def instructions(inst_set)
    inst_set << [:SKIP]
  end
end

class ExitCommandNode < Treetop::Runtime::SyntaxNode
  def instructions(inst_set)
    inst_set << [:HALT, number.to_i]
  end
end

class AdditiveNode < Treetop::Runtime::SyntaxNode
  def instructions(inst_set)
    multitive.instructions(inst_set)
    if additive
      additive.instructions(inst_set)
      case operator.text_value
      when "+"
        inst_set << [:ADD]
      when "-"
        inst_set << [:SUB]
      end
    end
  end
end

class MultitiveNode < Treetop::Runtime::SyntaxNode
  def instructions(inst_set)
    primary.instructions(inst_set)
    if multitive
      multitive.instructions(inst_set)
      case operator.text_value
      when "*"
        inst_set << [:MULT]
      when "/"
        inst_set << [:DIV]
      when "^"
        inst_set << [:PWR]
      end
    end
  end
end

class NumberNode < Treetop::Runtime::SyntaxNode
  def instructions(inst_set)
    inst_set << [:LD_INT, text_value.to_i]
  end
end

class IdentifierNode < Treetop::Runtime::SyntaxNode
  def instructions(inst_set)
    inst_set << [:LD_VAR, inst_set.variable_register(text_value)]
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
