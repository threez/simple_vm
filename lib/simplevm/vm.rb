class VirtualMachine
  
  def initialize(options = {})
    @debug = options[:debug] || false
    @stack = []
    @varstore = {}
    @halt = false
  end
  
  def compute(operations)
    @code = operations
    @instuction_pointer = 0
    while @instuction_pointer < @code.size and @halt == false
      operation, argument = @code[@instuction_pointer]
      compute_operation(operation, argument)
      @instuction_pointer += 1
    end
  end
  
  def compute_operation(operation, argument)
    if @debug
      puts "== OP: #{operation}(#{argument}):"
      puts " * BEFORE: "
      puts info
    end
    
    case operation
      when :HALT # Stop execution
        @halt = true
      when :READ_INT # Read an integer from the keyboard and store it at the address var
        @varstore[argument] = self.input()
      when :WRITE_INT # Output the top of the stack and decrement SP
        self.output(stack_last)
      when :STORE # Store the top of the stack at the address var and decrement SP 
        @varstore[argument] = stack_last
      when :JMP_FALSE # If the top of the stack is 0 then jump to label ; decrement SP anyway 
        if stack_last == 0
          @instuction_pointer = argument
        end
      when :GOTO # Jump to label
        @instuction_pointer = argument
      when :LD_INT # Put integer on the stack 
        @stack << argument
      when :LD_VAR # Put the value at the address var on the stack
        @stack << @varstore[argument]
        
      # Operators <, =, >, +, -, ×, ÷, ˆ. Perform 
      # the operation on the two top elements 
      # of the stack, remove them, and put the 
      # result on the stack 
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
        raise "Unknown operation #{operation}"
    end
    
    if @debug
      puts " * AFTER: "
      puts info
      puts "== END"
    end
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
  
  # prints information about the vm
  def info
    "    Stack: #{@stack.inspect}\n" \
    "    VarStore: #{@varstore.inspect}\n" \
    "    InstuctionPointer: #{@instuction_pointer} [#{@code[@instuction_pointer].inspect}]\n" \
    "    Labels: #{@labels.inspect}"
  end
  
  def stack_last
    last_element = @stack.pop
    raise "Stack is empty\n#{info}" if last_element.nil?
    last_element
  end
end
