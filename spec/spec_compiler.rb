require File.dirname(__FILE__) + '/spec_helper'

describe SimpleCompiler do
  it "should compile the ast of the sample program to instructions and return the same results" do
    instructions = SimpleCompiler.compile(SAMPLE_CODE)
    vm = MockVirtualMachine.new()
    vm.in "10"
    vm.compute(instructions.to_a)
    
    # same alg. in ruby:
    n = 10 
    f = 1
    while n > 0
      f = f * n 
      n = n - 1 
    end

    vm.out.should == f
  end
  
  it "shoult raise an exception if an undeclared variable is used" do
    lambda do
      instructions = SimpleCompiler.compile(
      "
        declarations
        begin
          read n;
        end
      ")
    end.should raise_error(SimpleLanguage::VariableError)
  end
  
  it "shoult compute the fibonacci numbers with correct results" do
    instructions = SimpleCompiler.compile(FIB_CODE)
    vm = MockVirtualMachine.new()
    vm.in "19"
    vm.compute(instructions.to_a)
    vm.out.should == 4181
  end
  
  it "shoult compute the math operations with correct results" do
    instructions = SimpleCompiler.compile(MATH_CODE)
    vm = MockVirtualMachine.new()
    vm.in "2", "3"
    vm.compute(instructions.to_a)
    vm.out.should == 22
    vm.out.should == 49
  end
  
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
      [:GOTO, 27],
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
