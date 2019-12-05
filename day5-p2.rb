class Computer


    def initialize(memory = [])
        @memory = memory
        @position = 0
        main_loop()
    end

    def return_val
        @memory[0]
    end

    def run_optcode(inst)
        if inst[0] % 100 == 1
            add(inst)
            return true
        elsif inst[0] % 100 == 2
            multipy(inst)
            return true
        elsif inst[0] % 100 == 3
          input(inst, 5)
          return true
        elsif inst[0] % 100 ==  4
          output(inst)
          return true
        elsif inst[0] % 100 ==  5
          jump_if_true(inst)
          return true
        elsif inst[0] % 100 ==  6
          jump_if_false(inst)
          return true
        elsif inst[0] % 100 ==  7
          less_than(inst)
          return true
        elsif inst[0] % 100 ==  8
          equals(inst)
          return true
        elsif inst[0] % 100 == 99
            #this is the halt instruction
            p "HALTING"
            return false
        else
            p "Invalid OPT CODE"
            p inst
            p @memory
            p @position
            return false
        end
    end

    def add(inst)
        reversed_opt = inst[0].to_s[0..-3].reverse
        if(reversed_opt[0] == "1")
          first_val = inst[1]
        else
          first_val = @memory[inst[1]]
        end
        if(reversed_opt[1] == "1")
          second_val = inst[2]
        else
          second_val = @memory[inst[2]]
        end
        pos = inst[3]
        @memory[pos] = (first_val + second_val)
    end

    def multipy(inst)
        reversed_opt = inst[0].to_s[0..-3].reverse
        if(reversed_opt[0] == "1")
           first_val = inst[1]
        else
          first_val = @memory[inst[1]]
        end
        if(reversed_opt[1] == "1")
          second_val = inst[2]
        else
          second_val = @memory[inst[2]]
        end
        pos = inst[3]
        @memory[pos] = (first_val*second_val)
    end

    def jump_if_true(inst)
        reversed_opt = inst[0].to_s[0..-3].reverse
        if(reversed_opt[0] == "1")
          first_val = inst[1]
        else
          first_val = @memory[inst[1]]
        end
        if(reversed_opt[1] == "1")
          second_val = inst[2]
        else
          second_val = @memory[inst[2]]
        end
        if(first_val != 0)
          @position = second_val
        else
          @position += 3
        end
    end

    def jump_if_false(inst)
        reversed_opt = inst[0].to_s[0..-3].reverse
        if(reversed_opt[0] == "1")
          first_val = inst[1]
        else
          first_val = @memory[inst[1]]
        end
        if(reversed_opt[1] == "1")
          second_val = inst[2]
        else
          second_val = @memory[inst[2]]
        end
        if(first_val == 0)
          @position = second_val
        else
          @position += 3
        end
    end
    def input(inst, input)
      pos = inst[1]
      @memory[pos] = input
    end

    def output(inst)
      reversed_opt = inst[0].to_s[0..-3].reverse
      if(reversed_opt[0] == "1")
        val = inst[1]
      else
        val = @memory[inst[1]]
      end
      p val
      if val != 0
        p @position 
        p @memory
        raise "error"
      end
    end

    def less_than(inst)
      reversed_opt = inst[0].to_s[0..-3].reverse
      if(reversed_opt[0] == "1")
        first_val = inst[1]
      else
        first_val = @memory[inst[1]]
      end
      if(reversed_opt[1] == "1")
        second_val = inst[2]
      else
        second_val = @memory[inst[2]]
      end
      if(first_val < second_val)
        @memory[inst[3]] = 1
      else
        @memory[inst[3]] = 0
      end

    end

    def equals(inst)
      reversed_opt = inst[0].to_s[0..-3].reverse
      if(reversed_opt[0] == "1")
        first_val = inst[1]
      else
        first_val = @memory[inst[1]]
      end
      if(reversed_opt[1] == "1")
        second_val = inst[2]
      else
        second_val = @memory[inst[2]]
      end
      if(first_val == second_val)
        @memory[inst[3]] = 1
      else
        @memory[inst[3]] = 0
      end

    end

    def get_code_offset(code)
      opt = code % 100
      if(opt == 1)
        return 3
      elsif(opt == 2)
        return 3 
      elsif(opt == 3)
        return 1
      elsif(opt == 4)
        return 1
      elsif(opt == 5 || opt == 6)
        return "JUMP"
      elsif(opt == 7 || opt == 8)
        return 3
      elsif(opt == 99)
        return 0
      end
    end

    def main_loop
        #we have one main loop, where we traverse memory, writing to it as we go
        while true

            offset = get_code_offset(@memory[@position])
            if(offset == "JUMP")
              shift = 2
            else 
              shift = offset
            end

            inst = @memory[@position..(@position+shift)]
            ran = run_optcode(inst)
            if(!ran)
                break
            end
            if(offset != "JUMP")
              @position += offset + 1
            end
        end
        return @memory[0]
    end
end
