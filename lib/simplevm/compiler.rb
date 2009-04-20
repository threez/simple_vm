class InstructionsBuilder
  def initialize
    @instructions = []
  end
  
  def << instruction
    @instructions << instruction
  end
  
  def jmp_false(&block)
    jump_to = [:JMP_FALSE, 0]
    self << jump_to
    yield
    jump_to[1] = icounter
  end
  
  def icounter
     @instructions.size
  end
end

class SimpleCompiler
  def self.compile(code)
    parser = SimpleLanguageParser.new()
    ast = parser.parse(code);
    ast.instructions
  end
end