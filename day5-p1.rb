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
          input(inst, 1)
          return true
        elsif inst[0] % 100 ==  4
          output(inst)
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
      elsif(opt == 99)
        return 0
      end
    end

    def main_loop
        #we have one main loop, where we traverse memory, writing to it as we go
        while true

            offset = get_code_offset(@memory[@position])
            inst = @memory[@position..(@position+offset)]
            ran = run_optcode(inst)
            if(!ran)
                break
            end
            @position += offset + 1
        end
        return @memory[0]
    end
end

Computer.new([3,225,1,225,6,6,1100,1,238,225,104,0,1102,67,92,225,1101,14,84,225,1002,217,69,224,101,-5175,224,224,4,224,102,8,223,223,101,2,224,224,1,224,223,223,1,214,95,224,101,-127,224,224,4,224,102,8,223,223,101,3,224,224,1,223,224,223,1101,8,41,225,2,17,91,224,1001,224,-518,224,4,224,1002,223,8,223,101,2,224,224,1,223,224,223,1101,37,27,225,1101,61,11,225,101,44,66,224,101,-85,224,224,4,224,1002,223,8,223,101,6,224,224,1,224,223,223,1102,7,32,224,101,-224,224,224,4,224,102,8,223,223,1001,224,6,224,1,224,223,223,1001,14,82,224,101,-174,224,224,4,224,102,8,223,223,101,7,224,224,1,223,224,223,102,65,210,224,101,-5525,224,224,4,224,102,8,223,223,101,3,224,224,1,224,223,223,1101,81,9,224,101,-90,224,224,4,224,102,8,223,223,1001,224,3,224,1,224,223,223,1101,71,85,225,1102,61,66,225,1102,75,53,225,4,223,99,0,0,0,677,0,0,0,0,0,0,0,0,0,0,0,1105,0,99999,1105,227,247,1105,1,99999,1005,227,99999,1005,0,256,1105,1,99999,1106,227,99999,1106,0,265,1105,1,99999,1006,0,99999,1006,227,274,1105,1,99999,1105,1,280,1105,1,99999,1,225,225,225,1101,294,0,0,105,1,0,1105,1,99999,1106,0,300,1105,1,99999,1,225,225,225,1101,314,0,0,106,0,0,1105,1,99999,8,226,226,224,102,2,223,223,1005,224,329,1001,223,1,223,1108,677,677,224,1002,223,2,223,1006,224,344,101,1,223,223,1007,226,677,224,102,2,223,223,1005,224,359,101,1,223,223,1007,677,677,224,1002,223,2,223,1006,224,374,101,1,223,223,1108,677,226,224,1002,223,2,223,1005,224,389,1001,223,1,223,108,226,677,224,102,2,223,223,1006,224,404,101,1,223,223,1108,226,677,224,102,2,223,223,1005,224,419,101,1,223,223,1008,677,677,224,102,2,223,223,1005,224,434,101,1,223,223,7,677,226,224,1002,223,2,223,1005,224,449,101,1,223,223,1008,226,226,224,102,2,223,223,1005,224,464,1001,223,1,223,107,226,677,224,1002,223,2,223,1006,224,479,1001,223,1,223,107,677,677,224,102,2,223,223,1005,224,494,1001,223,1,223,1008,226,677,224,102,2,223,223,1006,224,509,1001,223,1,223,1107,677,226,224,102,2,223,223,1005,224,524,101,1,223,223,1007,226,226,224,1002,223,2,223,1006,224,539,1001,223,1,223,107,226,226,224,102,2,223,223,1006,224,554,101,1,223,223,108,677,677,224,1002,223,2,223,1006,224,569,1001,223,1,223,7,226,677,224,102,2,223,223,1006,224,584,1001,223,1,223,8,677,226,224,102,2,223,223,1005,224,599,101,1,223,223,1107,677,677,224,1002,223,2,223,1005,224,614,101,1,223,223,8,226,677,224,102,2,223,223,1005,224,629,1001,223,1,223,7,226,226,224,1002,223,2,223,1006,224,644,1001,223,1,223,108,226,226,224,1002,223,2,223,1006,224,659,101,1,223,223,1107,226,677,224,1002,223,2,223,1006,224,674,101,1,223,223,4,223,99,226])
