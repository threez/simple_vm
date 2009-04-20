module SimpleLanguage
  include Treetop::Runtime

  def root
    @root || :program
  end

  module Program0
    def spaces
      elements[0]
    end

    def spaces
      elements[2]
    end

    def spaces
      elements[4]
    end

    def spaces
      elements[6]
    end

    def commands
      elements[7]
    end

    def spaces
      elements[8]
    end

    def spaces
      elements[10]
    end
  end

  def _nt_program
    start_index = index
    if node_cache[:program].has_key?(index)
      cached = node_cache[:program][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_spaces
    s0 << r1
    if r1
      if input.index('declarations', index) == index
        r2 = instantiate_node(SyntaxNode,input, index...(index + 12))
        @index += 12
      else
        terminal_parse_failure('declarations')
        r2 = nil
      end
      s0 << r2
      if r2
        r3 = _nt_spaces
        s0 << r3
        if r3
          s4, i4 = [], index
          loop do
            r5 = _nt_declarations
            if r5
              s4 << r5
            else
              break
            end
          end
          r4 = instantiate_node(SyntaxNode,input, i4...index, s4)
          s0 << r4
          if r4
            r6 = _nt_spaces
            s0 << r6
            if r6
              if input.index('begin', index) == index
                r7 = instantiate_node(SyntaxNode,input, index...(index + 5))
                @index += 5
              else
                terminal_parse_failure('begin')
                r7 = nil
              end
              s0 << r7
              if r7
                r8 = _nt_spaces
                s0 << r8
                if r8
                  r9 = _nt_commands
                  s0 << r9
                  if r9
                    r10 = _nt_spaces
                    s0 << r10
                    if r10
                      if input.index('end', index) == index
                        r11 = instantiate_node(SyntaxNode,input, index...(index + 3))
                        @index += 3
                      else
                        terminal_parse_failure('end')
                        r11 = nil
                      end
                      s0 << r11
                      if r11
                        r12 = _nt_spaces
                        s0 << r12
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(ProgramNode,input, i0...index, s0)
      r0.extend(Program0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:program][start_index] = r0

    return r0
  end

  module Declarations0
    def spaces
      elements[1]
    end

    def id_seq
      elements[2]
    end

    def spaces
      elements[3]
    end

    def identifier
      elements[4]
    end

    def spaces
      elements[5]
    end

  end

  def _nt_declarations
    start_index = index
    if node_cache[:declarations].has_key?(index)
      cached = node_cache[:declarations][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index('integer', index) == index
      r1 = instantiate_node(SyntaxNode,input, index...(index + 7))
      @index += 7
    else
      terminal_parse_failure('integer')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_spaces
      s0 << r2
      if r2
        r3 = _nt_id_seq
        s0 << r3
        if r3
          r4 = _nt_spaces
          s0 << r4
          if r4
            r5 = _nt_identifier
            s0 << r5
            if r5
              r6 = _nt_spaces
              s0 << r6
              if r6
                if input.index('.', index) == index
                  r7 = instantiate_node(SyntaxNode,input, index...(index + 1))
                  @index += 1
                else
                  terminal_parse_failure('.')
                  r7 = nil
                end
                s0 << r7
              end
            end
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(DeclarationNode,input, i0...index, s0)
      r0.extend(Declarations0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:declarations][start_index] = r0

    return r0
  end

  module IdSeq0
    def identifier
      elements[0]
    end

    def spaces
      elements[1]
    end

    def spaces
      elements[3]
    end
  end

  def _nt_id_seq
    start_index = index
    if node_cache[:id_seq].has_key?(index)
      cached = node_cache[:id_seq][index]
      @index = cached.interval.end if cached
      return cached
    end

    s0, i0 = [], index
    loop do
      i1, s1 = index, []
      r2 = _nt_identifier
      s1 << r2
      if r2
        r3 = _nt_spaces
        s1 << r3
        if r3
          if input.index(',', index) == index
            r4 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure(',')
            r4 = nil
          end
          s1 << r4
          if r4
            r5 = _nt_spaces
            s1 << r5
          end
        end
      end
      if s1.last
        r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
        r1.extend(IdSeq0)
      else
        self.index = i1
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    if s0.empty?
      self.index = i0
      r0 = nil
    else
      r0 = instantiate_node(IdentifierSequenceNode,input, i0...index, s0)
    end

    node_cache[:id_seq][start_index] = r0

    return r0
  end

  module Commands0
    def command
      elements[0]
    end

    def spaces
      elements[1]
    end

    def spaces
      elements[3]
    end
  end

  def _nt_commands
    start_index = index
    if node_cache[:commands].has_key?(index)
      cached = node_cache[:commands][index]
      @index = cached.interval.end if cached
      return cached
    end

    s0, i0 = [], index
    loop do
      i1, s1 = index, []
      r2 = _nt_command
      s1 << r2
      if r2
        r3 = _nt_spaces
        s1 << r3
        if r3
          if input.index(';', index) == index
            r4 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure(';')
            r4 = nil
          end
          s1 << r4
          if r4
            r5 = _nt_spaces
            s1 << r5
          end
        end
      end
      if s1.last
        r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
        r1.extend(Commands0)
      else
        self.index = i1
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    if s0.empty?
      self.index = i0
      r0 = nil
    else
      r0 = instantiate_node(CommandSequenceNode,input, i0...index, s0)
    end

    node_cache[:commands][start_index] = r0

    return r0
  end

  module Assignment0
    def identifier
      elements[0]
    end

    def spaces
      elements[1]
    end

    def spaces
      elements[3]
    end

    def math_expression
      elements[4]
    end
  end

  def _nt_assignment
    start_index = index
    if node_cache[:assignment].has_key?(index)
      cached = node_cache[:assignment][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_identifier
    s0 << r1
    if r1
      r2 = _nt_spaces
      s0 << r2
      if r2
        if input.index(':=', index) == index
          r3 = instantiate_node(SyntaxNode,input, index...(index + 2))
          @index += 2
        else
          terminal_parse_failure(':=')
          r3 = nil
        end
        s0 << r3
        if r3
          r4 = _nt_spaces
          s0 << r4
          if r4
            r5 = _nt_math_expression
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(AssignmentNode,input, i0...index, s0)
      r0.extend(Assignment0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:assignment][start_index] = r0

    return r0
  end

  module IfThenElseCondition0
    def spaces
      elements[1]
    end

    def expression
      elements[2]
    end

    def spaces
      elements[3]
    end

    def spaces
      elements[5]
    end

    def then_commands
      elements[6]
    end

    def spaces
      elements[7]
    end

    def spaces
      elements[9]
    end

    def else_commands
      elements[10]
    end

    def spaces
      elements[11]
    end

  end

  def _nt_if_then_else_condition
    start_index = index
    if node_cache[:if_then_else_condition].has_key?(index)
      cached = node_cache[:if_then_else_condition][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index('if', index) == index
      r1 = instantiate_node(SyntaxNode,input, index...(index + 2))
      @index += 2
    else
      terminal_parse_failure('if')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_spaces
      s0 << r2
      if r2
        r3 = _nt_expression
        s0 << r3
        if r3
          r4 = _nt_spaces
          s0 << r4
          if r4
            if input.index('then', index) == index
              r5 = instantiate_node(SyntaxNode,input, index...(index + 4))
              @index += 4
            else
              terminal_parse_failure('then')
              r5 = nil
            end
            s0 << r5
            if r5
              r6 = _nt_spaces
              s0 << r6
              if r6
                r7 = _nt_commands
                s0 << r7
                if r7
                  r8 = _nt_spaces
                  s0 << r8
                  if r8
                    if input.index('else', index) == index
                      r9 = instantiate_node(SyntaxNode,input, index...(index + 4))
                      @index += 4
                    else
                      terminal_parse_failure('else')
                      r9 = nil
                    end
                    s0 << r9
                    if r9
                      r10 = _nt_spaces
                      s0 << r10
                      if r10
                        r11 = _nt_commands
                        s0 << r11
                        if r11
                          r12 = _nt_spaces
                          s0 << r12
                          if r12
                            if input.index('fi', index) == index
                              r13 = instantiate_node(SyntaxNode,input, index...(index + 2))
                              @index += 2
                            else
                              terminal_parse_failure('fi')
                              r13 = nil
                            end
                            s0 << r13
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(IfThenElseConditionNode,input, i0...index, s0)
      r0.extend(IfThenElseCondition0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:if_then_else_condition][start_index] = r0

    return r0
  end

  module IfThenCondition0
    def spaces
      elements[1]
    end

    def expression
      elements[2]
    end

    def spaces
      elements[3]
    end

    def spaces
      elements[5]
    end

    def commands
      elements[6]
    end

    def spaces
      elements[7]
    end

  end

  def _nt_if_then_condition
    start_index = index
    if node_cache[:if_then_condition].has_key?(index)
      cached = node_cache[:if_then_condition][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index('if', index) == index
      r1 = instantiate_node(SyntaxNode,input, index...(index + 2))
      @index += 2
    else
      terminal_parse_failure('if')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_spaces
      s0 << r2
      if r2
        r3 = _nt_expression
        s0 << r3
        if r3
          r4 = _nt_spaces
          s0 << r4
          if r4
            if input.index('then', index) == index
              r5 = instantiate_node(SyntaxNode,input, index...(index + 4))
              @index += 4
            else
              terminal_parse_failure('then')
              r5 = nil
            end
            s0 << r5
            if r5
              r6 = _nt_spaces
              s0 << r6
              if r6
                r7 = _nt_commands
                s0 << r7
                if r7
                  r8 = _nt_spaces
                  s0 << r8
                  if r8
                    if input.index('fi', index) == index
                      r9 = instantiate_node(SyntaxNode,input, index...(index + 2))
                      @index += 2
                    else
                      terminal_parse_failure('fi')
                      r9 = nil
                    end
                    s0 << r9
                  end
                end
              end
            end
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(IfThenConditionNode,input, i0...index, s0)
      r0.extend(IfThenCondition0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:if_then_condition][start_index] = r0

    return r0
  end

  def _nt_condition
    start_index = index
    if node_cache[:condition].has_key?(index)
      cached = node_cache[:condition][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_if_then_else_condition
    if r1
      r0 = r1
    else
      r2 = _nt_if_then_condition
      if r2
        r0 = r2
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:condition][start_index] = r0

    return r0
  end

  module WhileLoop0
    def spaces
      elements[1]
    end

    def expression
      elements[2]
    end

    def spaces
      elements[3]
    end

    def spaces
      elements[5]
    end

    def commands
      elements[6]
    end

    def spaces
      elements[7]
    end

  end

  def _nt_while_loop
    start_index = index
    if node_cache[:while_loop].has_key?(index)
      cached = node_cache[:while_loop][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index('while', index) == index
      r1 = instantiate_node(SyntaxNode,input, index...(index + 5))
      @index += 5
    else
      terminal_parse_failure('while')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_spaces
      s0 << r2
      if r2
        r3 = _nt_expression
        s0 << r3
        if r3
          r4 = _nt_spaces
          s0 << r4
          if r4
            if input.index('do', index) == index
              r5 = instantiate_node(SyntaxNode,input, index...(index + 2))
              @index += 2
            else
              terminal_parse_failure('do')
              r5 = nil
            end
            s0 << r5
            if r5
              r6 = _nt_spaces
              s0 << r6
              if r6
                r7 = _nt_commands
                s0 << r7
                if r7
                  r8 = _nt_spaces
                  s0 << r8
                  if r8
                    if input.index('od', index) == index
                      r9 = instantiate_node(SyntaxNode,input, index...(index + 2))
                      @index += 2
                    else
                      terminal_parse_failure('od')
                      r9 = nil
                    end
                    s0 << r9
                  end
                end
              end
            end
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(WhileNode,input, i0...index, s0)
      r0.extend(WhileLoop0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:while_loop][start_index] = r0

    return r0
  end

  module Command0
    def spaces
      elements[1]
    end

    def identifier
      elements[2]
    end
  end

  module Command1
    def spaces
      elements[1]
    end

    def math_expression
      elements[2]
    end
  end

  def _nt_command
    start_index = index
    if node_cache[:command].has_key?(index)
      cached = node_cache[:command][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    if input.index('skip', index) == index
      r1 = instantiate_node(ReadCommandNode,input, index...(index + 4))
      @index += 4
    else
      terminal_parse_failure('skip')
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i2, s2 = index, []
      if input.index('read', index) == index
        r3 = instantiate_node(SyntaxNode,input, index...(index + 4))
        @index += 4
      else
        terminal_parse_failure('read')
        r3 = nil
      end
      s2 << r3
      if r3
        r4 = _nt_spaces
        s2 << r4
        if r4
          r5 = _nt_identifier
          s2 << r5
        end
      end
      if s2.last
        r2 = instantiate_node(ReadCommandNode,input, i2...index, s2)
        r2.extend(Command0)
      else
        self.index = i2
        r2 = nil
      end
      if r2
        r0 = r2
      else
        i6, s6 = index, []
        if input.index('write', index) == index
          r7 = instantiate_node(SyntaxNode,input, index...(index + 5))
          @index += 5
        else
          terminal_parse_failure('write')
          r7 = nil
        end
        s6 << r7
        if r7
          r8 = _nt_spaces
          s6 << r8
          if r8
            r9 = _nt_math_expression
            s6 << r9
          end
        end
        if s6.last
          r6 = instantiate_node(WriteCommandNode,input, i6...index, s6)
          r6.extend(Command1)
        else
          self.index = i6
          r6 = nil
        end
        if r6
          r0 = r6
        else
          r10 = _nt_assignment
          if r10
            r0 = r10
          else
            r11 = _nt_condition
            if r11
              r0 = r11
            else
              r12 = _nt_while_loop
              if r12
                r0 = r12
              else
                self.index = i0
                r0 = nil
              end
            end
          end
        end
      end
    end

    node_cache[:command][start_index] = r0

    return r0
  end

  def _nt_spaces
    start_index = index
    if node_cache[:spaces].has_key?(index)
      cached = node_cache[:spaces][index]
      @index = cached.interval.end if cached
      return cached
    end

    s0, i0 = [], index
    loop do
      if input.index(Regexp.new('[\\s]'), index) == index
        r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    r0 = instantiate_node(SpacesNode,input, i0...index, s0)

    node_cache[:spaces][start_index] = r0

    return r0
  end

  module Number0
  end

  def _nt_number
    start_index = index
    if node_cache[:number].has_key?(index)
      cached = node_cache[:number][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    if input.index('0', index) == index
      r1 = instantiate_node(NumberNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('0')
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i2, s2 = index, []
      if input.index(Regexp.new('[1-9]'), index) == index
        r3 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        r3 = nil
      end
      s2 << r3
      if r3
        s4, i4 = [], index
        loop do
          if input.index(Regexp.new('[0-9]'), index) == index
            r5 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            r5 = nil
          end
          if r5
            s4 << r5
          else
            break
          end
        end
        r4 = instantiate_node(SyntaxNode,input, i4...index, s4)
        s2 << r4
      end
      if s2.last
        r2 = instantiate_node(NumberNode,input, i2...index, s2)
        r2.extend(Number0)
      else
        self.index = i2
        r2 = nil
      end
      if r2
        r0 = r2
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:number][start_index] = r0

    return r0
  end

  module Identifier0
  end

  def _nt_identifier
    start_index = index
    if node_cache[:identifier].has_key?(index)
      cached = node_cache[:identifier][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index(Regexp.new('[a-zA-Z]'), index) == index
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        if input.index(Regexp.new('[a-zA-Z_]'), index) == index
          r3 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(IdentifierNode,input, i0...index, s0)
      r0.extend(Identifier0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:identifier][start_index] = r0

    return r0
  end

  module MathExpression0
    def spaces
      elements[0]
    end

    def additive
      elements[1]
    end

    def spaces
      elements[2]
    end

    def term
      elements[3]
    end
  end

  module MathExpression1
    def term
      elements[0]
    end

  end

  def _nt_math_expression
    start_index = index
    if node_cache[:math_expression].has_key?(index)
      cached = node_cache[:math_expression][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_term
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        i3, s3 = index, []
        r4 = _nt_spaces
        s3 << r4
        if r4
          if input.index(Regexp.new('[+-]'), index) == index
            r5 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            r5 = nil
          end
          s3 << r5
          if r5
            r6 = _nt_spaces
            s3 << r6
            if r6
              r7 = _nt_term
              s3 << r7
            end
          end
        end
        if s3.last
          r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
          r3.extend(MathExpression0)
        else
          self.index = i3
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(MathExpressionNode,input, i0...index, s0)
      r0.extend(MathExpression1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:math_expression][start_index] = r0

    return r0
  end

  module Term0
    def spaces
      elements[0]
    end

    def multitive
      elements[1]
    end

    def spaces
      elements[2]
    end

    def factor
      elements[3]
    end
  end

  module Term1
    def factor
      elements[0]
    end

  end

  def _nt_term
    start_index = index
    if node_cache[:term].has_key?(index)
      cached = node_cache[:term][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_factor
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        i3, s3 = index, []
        r4 = _nt_spaces
        s3 << r4
        if r4
          if input.index(Regexp.new('[*/]'), index) == index
            r5 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            r5 = nil
          end
          s3 << r5
          if r5
            r6 = _nt_spaces
            s3 << r6
            if r6
              r7 = _nt_factor
              s3 << r7
            end
          end
        end
        if s3.last
          r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
          r3.extend(Term0)
        else
          self.index = i3
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(TermNode,input, i0...index, s0)
      r0.extend(Term1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:term][start_index] = r0

    return r0
  end

  module Factor0
    def spaces
      elements[1]
    end

    def math_expression
      elements[2]
    end

    def spaces
      elements[3]
    end

  end

  def _nt_factor
    start_index = index
    if node_cache[:factor].has_key?(index)
      cached = node_cache[:factor][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_number
    if r1
      r0 = r1
    else
      r2 = _nt_identifier
      if r2
        r0 = r2
      else
        i3, s3 = index, []
        if input.index('(', index) == index
          r4 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure('(')
          r4 = nil
        end
        s3 << r4
        if r4
          r5 = _nt_spaces
          s3 << r5
          if r5
            r6 = _nt_math_expression
            s3 << r6
            if r6
              r7 = _nt_spaces
              s3 << r7
              if r7
                if input.index(')', index) == index
                  r8 = instantiate_node(SyntaxNode,input, index...(index + 1))
                  @index += 1
                else
                  terminal_parse_failure(')')
                  r8 = nil
                end
                s3 << r8
              end
            end
          end
        end
        if s3.last
          r3 = instantiate_node(FactorNode,input, i3...index, s3)
          r3.extend(Factor0)
        else
          self.index = i3
          r3 = nil
        end
        if r3
          r0 = r3
        else
          self.index = i0
          r0 = nil
        end
      end
    end

    node_cache[:factor][start_index] = r0

    return r0
  end

  module Expression0
    def first_expression
      elements[0]
    end

    def spaces
      elements[1]
    end

    def spaces
      elements[3]
    end

    def second_expression
      elements[4]
    end
  end

  def _nt_expression
    start_index = index
    if node_cache[:expression].has_key?(index)
      cached = node_cache[:expression][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_math_expression
    s0 << r1
    if r1
      r2 = _nt_spaces
      s0 << r2
      if r2
        if input.index(Regexp.new('[<=>]'), index) == index
          r3 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          r3 = nil
        end
        s0 << r3
        if r3
          r4 = _nt_spaces
          s0 << r4
          if r4
            r5 = _nt_math_expression
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(ExpressionNode,input, i0...index, s0)
      r0.extend(Expression0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:expression][start_index] = r0

    return r0
  end

end

class SimpleLanguageParser < Treetop::Runtime::CompiledParser
  include SimpleLanguage
end

