class InstructionsBuilder
  def initialize
    @instructions = []
    @variable_register = {}
  end
  
  def variable_register(index)
    if @variable_register[index]
      @variable_register[index]
    else  
      @variable_register[index] = @variable_register.size + 1
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
end

class SimpleCompiler
  def self.compile(code)
    parser = SimpleLanguageParser.new()
    ast = parser.parse(code)
    ast.instructions
  end
end