require File.dirname(__FILE__) + '/spec_helper'

describe SimpleCompiler do
  it "should compile the ast of the sample program to instructions" do
    instructions = SimpleCompiler.compile(SAMPLE_CODE)
    instructions.to_a.should == [
      [:DATA, 2],
      [:READ_INT],
      [:STORE, 1],
      [:LD_VAR, 1],
      [:LD_INT, 0],
      [:LT],
      [:JMP_FALSE, 10],
      [:LD_INT, 0],
      [:WRITE_INT],
      [:GOTO, 25],
      [:LD_INT, 1],
      [:STORE, 2],
      [:LD_VAR, 1],
      [:LD_INT, 0],
      [:GT],
      [:JMP_FALSE, 25],
      [:LD_VAR, 2],
      [:LD_VAR, 1],
      [:MULT],
      [:STORE, 2],
      [:LD_VAR, 1],
      [:LD_INT, 1],
      [:SUB],
      [:STORE, 1],
      [:GOTO, 12],
      [:LD_VAR, 2],
      [:WRITE_INT],
      [:HALT, 0]
    ]
  end
end
