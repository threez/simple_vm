class MockVirtualMachine < VirtualMachine
  attr_accessor :input_mock, :output_mock
  
  def initialize(options = {})
    super(options)
    @input_mock = []
    @output_mock = []
  end
  
  def output(int)
    @output_mock << int
  end
  
  def input
    @input_mock.shift.to_i
  end
  
  def in(*items)
    items.each { |item| @input_mock << item }
  end
  
  def out
    @output_mock.shift
  end
end
