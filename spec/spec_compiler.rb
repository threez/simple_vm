require File.dirname(__FILE__) + '/spec_helper'

describe SimpleCompiler do
  it "should compile the ast of the sample program to instructions" do
    parser = SimpleLanguageParser.new()
    ast = parser.parse(SAMPLE_CODE)
    
    compiler = SimpleCompiler.new
    instructions = compiler.compile(ast)
    instructions.should == [
      [:READ_INT, :n],  # 0
      [:LD_VAR, :n],    # 1
      [:LD_INT, 0],     # 2
      [:LT],            # 3
      [:JMP_FALSE, 6],  # 4
      [:LD_INT, 0],     # 5
      [:WRITE_INT],     # 6
      [:LD_INT, 1],     # 7
      [:STORE, :f],     # 8
      [:LD_VAR, :n],    # 9
      [:LD_INT, 0],     # 10
      [:GT],            # 11
      [:JMP_FALSE, 21], # 12
      [:LD_VAR, :f],    # 13
      [:LD_VAR, :n],    # 14
      [:MULT],          # 15
      [:STORE, :f],     # 16
      [:LD_VAR, :n],    # 17
      [:LD_INT, 1],     # 18
      [:SUB],           # 19
      [:STORE, :n],     # 20
      [:GOTO, 8],       # 21
      [:LD_VAR, :f],    # 22
      [:WRITE_INT]      # 23
    ]
  end
end