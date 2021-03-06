class VirtualMachineException < StandardError
  attr_accessor :vm, :code, :instuction_pointer
  
  def message
    "#{super}\n" \
    "  Stack: #{@vm.stack.inspect}\n" \
    "  Variables: #{@vm.variables.inspect}\n" \
    "  InstuctionPointer: #{@instuction_pointer} [#{@code[@instuction_pointer].inspect}]\n" \
  end
end

class VirtualMachine
  attr_reader :stack, :variables
  
  def initialize(options = {})
    @debug = options[:debug] || false
    @stack = []
    @variables = {}
    @halt = false
    @exit_value = nil
  end
  
  def compute(code)
    instuction_pointer = 0
    while instuction_pointer < code.size and @halt == false
      if new_instruction_pointer = compute_operation(*code[instuction_pointer])
        instuction_pointer = new_instruction_pointer
      else 
        instuction_pointer += 1
      end
    end
    
    @exit_value
  rescue => ex
    if ex.respond_to? :code
      ex.code = code
      ex.vm = self
      ex.instuction_pointer = instuction_pointer
    end
    raise ex
  end
  
  def compute_operation(operation, argument = nil)
    new_instruction_pointer = nil
    
    if @debug
      puts "== OP: #{operation}(#{argument}):"
      puts " * BEFORE: "
      puts info
    end
    
    case operation
      when :DATA
        # this operation don't affect this vm,
        # because variabels are stored in a hash
      when :HALT
        @halt = true
        @exit_value = argument
      when :READ_INT
        @stack << input()
      when :WRITE_INT
        output(stack_last)
      when :STORE
        @variables[argument] = stack_last
      when :JMP_FALSE
        if stack_last == 0
          new_instruction_pointer = argument
        end
      when :GOTO
        new_instruction_pointer = argument
      when :LD_INT
        @stack << argument
      when :LD_VAR
        @stack << @variables[argument]
      when :LT
        b, a = stack_last, stack_last
        @stack << (a < b ? 1 : 0)
      when :EQ
        b, a = stack_last, stack_last
        @stack << (a == b ? 1 : 0)
      when :GT
        b, a = stack_last, stack_last
        @stack << (a > b ? 1 : 0)
      when :ADD
        b, a = stack_last, stack_last
        @stack << a + b
      when :SUB
        b, a = stack_last, stack_last
        @stack << a - b
      when :MULT
        b, a = stack_last, stack_last
        @stack << a * b
      when :DIV
        b, a = stack_last, stack_last
        @stack << a / b
      when :PWR
        b, a = stack_last, stack_last
        @stack << a ** b
      else
        raise VirtualMachineException.new("Unknown operation #{operation}!")
    end
    
    if @debug
      puts " * AFTER: "
      puts info
      puts "== END"
    end
    
    return new_instruction_pointer
  end
  
private

  # outputs a integer to output device
  def output(int)
    puts int
  end
  
  # returns a integer from input device
  def input()
    gets.to_i
  end
  
  def stack_last
    item = @stack.pop
    raise VirtualMachineException.new("Stack is empty!") unless item
    item
  end
end
