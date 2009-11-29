module SimpleByteCode
  include InstructionSet
  
  def self.parse(path)
    program = []
    File.open(path, "r") do |file|
      while !file.eof?
        # read opcode and argument
        opcode = file.read(1).unpack("C").first
        case opcode
          when HALT
            argument = file.read(1).unpack("C").first
          when DATA, STORE, LD_INT, LD_VAR, JMP_FALSE, GOTO
            argument = file.read(4).unpack("N").first
        end
        
        # add instruction to program
        if argument
          program << [opcode_to_symbol(opcode), argument]
        else
          program << [opcode_to_symbol(opcode)]
        end
        
        # reset opcode and argument
        opcode, argument = nil, nil
      end
    end
    program
  end
  
  # convert int (opcode) to symbol
  def self.opcode_to_symbol(opcode)
    case opcode
      when DATA
        op = :DATA
      when HALT
        op = :HALT
      when READ_INT
        op = :READ_INT
      when WRITE_INT
        op = :WRITE_INT
      when ADD
        op = :ADD
      when SUB
        op = :SUB
      when MULT
        op = :MULT
      when DIV
        op = :DIV
      when PWR
        op = :PWR
      when STORE
        op = :STORE
      when LD_INT
        op = :LD_INT
      when LD_VAR
        op = :LD_VAR
      when JMP_FALSE
        op = :JMP_FALSE
      when GOTO
        op = :GOTO
      when LT
        op = :LT
      when GT
        op = :GT
      when EQ
        op = :EQ
    end
    
    op
  end
end
