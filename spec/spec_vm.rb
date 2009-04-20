require File.dirname(__FILE__) + "/spec_helper"

describe VirtualMachine do
  before do
    @vm = MockVirtualMachine.new()
  end
  
  it "should compute a simple multipication" do
    @vm.in "12\n", "23\n"
    @vm.compute [
      [:READ_INT, :m1],
      [:READ_INT, :m2],
      [:LD_VAR, :m1],
      [:LD_VAR, :m2],
      [:MULT],
      [:WRITE_INT]
    ]
    @vm.out.should == 276
  end
  
  it "should compute basic math operations" do
    @vm.in "12\n", "20\n"
    @vm.compute [
      [:READ_INT, :m1],
      [:READ_INT, :m2],
      [:LD_VAR, :m1],
      [:LD_VAR, :m2],
      [:SUB],
      [:WRITE_INT]
    ]
    @vm.out.should == -8
  end

  it "should compute a whole program" do
    @vm.in "10"
    @vm.compute [
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
