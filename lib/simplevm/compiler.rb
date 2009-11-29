module SimpleLanguage
  class SyntaxError < Exception
  end
  
  class VariableError < Exception
  end
end

class InstructionsBuilder
  def initialize
    @instructions = []
    @variable_register = {}
  end
  
  def declare_variable(type, name)
    # assign a address to the variable
    @variable_register[name] = @variable_register.size + 1
  end
  
  def variable_register(name)
    if @variable_register[name]
      return @variable_register[name]
    else  
      raise SimpleLanguage::VariableError.new("The variable '#{name}' is not declared")
    end
  end
  
  def << instruction
    @instructions << instruction
  end
  
  def jmp_false()
    jump_to = [:JMP_FALSE, 0]
    self << jump_to
    yield
    jump_to[1] = icounter
  end
  
  def icounter
    @instructions.size
  end
  
  def to_a
    @instructions.dup
  end
  
  def data_instruction
    [:DATA, @variable_register.size]
  end
end

module InstructionSet
  DATA = 0
  HALT = 1
  READ_INT = 20
  WRITE_INT = 21
  ADD = 100
  SUB = 101
  MULT = 102
  DIV = 103
  PWR = 104
  STORE = 150
  LD_INT = 151
  LD_VAR = 152
  JMP_FALSE = 200
  GOTO = 201
  LT = 210
  GT = 211
  EQ = 212
end

class SimpleCompiler
  def self.compile(code)
    parser = SimpleLanguageParser.new()
    if ast = parser.parse(code)
      ast.instructions
    else
      raise SimpleLanguage::SyntaxError.new(parser.failure_reason)
    end
  end
end

class ByteCodeCompiler
  include InstructionSet
  
  def self.compile(code)
    parser = SimpleLanguageParser.new()
    if ast = parser.parse(code)
      byte_code = ""
      
      for instruction in ast.instructions.to_a do
        case instruction[0]
          when :DATA
            byte_code << [DATA, instruction[1]].pack("CN")
          when :HALT
            byte_code << [HALT, instruction[1]].pack("CC")
          when :STORE
            byte_code << [STORE, instruction[1]].pack("CN")
          when :JMP_FALSE
            byte_code << [JMP_FALSE, instruction[1]].pack("CN")
          when :GOTO
            byte_code << [GOTO, instruction[1]].pack("CN")
          when :LD_INT
            byte_code << [LD_INT, instruction[1]].pack("CN")
          when :LD_VAR
            byte_code << [LD_VAR, instruction[1]].pack("CN")
          else
            # just bytecodes without arguments
            op_code = InstructionSet.const_get(instruction[0].to_s)
            byte_code << [op_code].pack("C")
        end
      end
      
      return byte_code
    else
      raise SimpleLanguage::SyntaxError.new(parser.failure_reason)
    end
  end
end
