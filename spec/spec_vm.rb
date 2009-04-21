require File.dirname(__FILE__) + "/spec_helper"

describe VirtualMachine do
  before do
    @vm = MockVirtualMachine.new()
  end
  
  it "should compute a simple multipication" do
    @vm.in "12\n", "23\n"
    @vm.compute([
      [:DATA, 2],
      [:READ_INT],
      [:STORE, 1],
      [:READ_INT],
      [:STORE, 2],
      [:LD_VAR, 1],
      [:LD_VAR, 2],
      [:MULT],
      [:LD_INT, 12],
      [:DIV],
      [:WRITE_INT],
      [:HALT, 0]
    ]).should == 0
    @vm.out.should == 23
  end
  
  it "should compute basic math operations" do
    @vm.in "12\n", "20\n"
    @vm.compute([
      [:DATA, 2],
      [:READ_INT],
      [:STORE, 1],
      [:READ_INT],
      [:STORE, 2],
      [:LD_VAR, 1],
      [:LD_VAR, 2],
      [:SUB],
      [:LD_INT, 10],
      [:ADD],
      [:WRITE_INT],
      [:HALT, 1]
    ]).should == 1
    @vm.out.should == 2
  end
  
  it "should compute advanced math operations" do
    @vm.compute [
      [:LD_INT, 3],
      [:LD_INT, 2],
      [:PWR],
      [:LD_INT, 3],
      [:PWR],
      [:WRITE_INT],
      [:HALT, 0]
    ]
    @vm.out.should == 729
  end
  
  it "should have a correct program flow using GOTO" do
    @vm.in "12\n", "20\n"
    @vm.compute [
      [:DATA, 2],
      [:READ_INT],
      [:STORE, 1],
      [:READ_INT],
      [:STORE, 2],
      [:LD_VAR, 1],
      [:LD_VAR, 2],
      [:GOTO, 9], # skip mult
      [:MULT],
      [:SUB],
      [:WRITE_INT],
      [:HALT, 0]
    ]
    @vm.out.should == -8
  end
  
  it "should have a correct program flow using JMP_FALSE" do
    @vm.in "12\n", "20\n"
    @vm.compute [
      [:LD_INT, 10], # first multipier
      [:LD_INT, 2],
      [:LD_INT, 3],
      [:LT],
      [:JMP_FALSE, 7],
      [:LD_INT, 30], # second multipier
      [:MULT],
      [:WRITE_INT],
      [:HALT, 0]
    ]
    @vm.out.should == 300
  end

  it "should compute a whole program" do
    @vm.in "10"
    @vm.compute [
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

    # same alg. in ruby:
    n = 10 
    f = 1
    while n > 0
      f = f * n 
      n = n - 1 
    end

    @vm.out.should == f
  end
end
