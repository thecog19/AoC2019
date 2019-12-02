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
        if inst[0] == 1
            add(inst)
            return true
        elsif inst[0] == 2
            multipy(inst)
            return true
        elsif inst[0] == 99
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
        first_val = @memory[inst[1]]
        second_val = @memory[inst[2]]
        pos = inst[3]
        @memory[pos] = (first_val + second_val)
    end

    def multipy(inst)
        first_val = @memory[inst[1]]
        second_val = @memory[inst[2]]
        pos = inst[3]
        @memory[pos] = (first_val*second_val)
    end

    def main_loop
        #we have one main loop, where we traverse memory, writing to it as we go
        # we shift the register 4 every time we execute an instruction
        # unless we get a halt order
        while true
            inst = @memory[@position..(@position+3)]
            ran = run_optcode(inst)
            if(!ran)
                break
            end
            @position += 4
        end
        return @memory[0]
    end
end

answer = 19690720
memory = [1,12,2,3,1,1,2,3,1,3,4,3,1,5,0,3,2,1,10,19,1,6,19,23,2,23,6,27,2,6,27,31,2,13,31,35,1,10,35,39,2,39,13,43,1,43,13,47,1,6,47,51,1,10,51,55,2,55,6,59,1,5,59,63,2,9,63,67,1,6,67,71,2,9,71,75,1,6,75,79,2,79,13,83,1,83,10,87,1,13,87,91,1,91,10,95,2,9,95,99,1,5,99,103,2,10,103,107,1,107,2,111,1,111,5,0,99,2,14,0,0]

def brute_force(answer, memory)
    curr = 0
    x = 0
    y = 0
    while x < 100
        while y < 100
            mem = memory.dup
            mem[1] = x
            mem[2] = y
            p "x: #{x}, y: #{y}"
            curr = Computer.new(mem).return_val
            if curr == answer
                p "x: #{x}, y: #{y}"
                raise "ERROR"
            end
            y += 1
        end
        y = 0
        x += 1
    end
    p mem
end

brute_force(answer, memory)
