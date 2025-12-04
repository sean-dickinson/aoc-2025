module Day01
  class Mobius
    def initialize(range:, pointer:)
      @range = range
      @pointer = pointer
    end

    def right(steps)
      walk(steps) do |next_pointer|
        next_pointer = increment(next_pointer)
        yield next_pointer if block_given?
        @pointer = next_pointer
      end
    end

    def left(steps)
      walk(steps) do |next_pointer|
        next_pointer = decrement(next_pointer)
        yield next_pointer if block_given?
        @pointer = next_pointer
      end
    end

    private

    def walk(steps)
      steps.times.inject(@pointer) do |next_pointer, _step|
        yield next_pointer
      end
    end

    def increment(value)
      value += 1
      if value > @range.last
        @range.first
      else
        value
      end
    end

    def decrement(value)
      value -= 1
      if value < @range.first
        @range.last
      else
        value
      end
    end
  end

  class Lock
    def initialize(instructions:)
      @mobius = Mobius.new(range: 0..99, pointer: 50)
      @instructions = instructions
    end

    def password
      @instructions.count do |instruction|
        execute_instruction(instruction).zero?
      end
    end

    def secure_password
      @instructions.flat_map do |instruction|
        numbers = []
        execute_instruction(instruction) do |num|
          numbers << num
        end
        numbers
      end.count(0)
    end

    private

    def execute_instruction(instruction, &block)
      method, steps = parse_instruction(instruction)
      @mobius.send(method, steps, &block)
    end

    # @param instruction [String]
    def parse_instruction(instruction)
      [
        parse_method(instruction),
        parse_steps(instruction)
      ]
    end

    def parse_method(instruction)
      {
        "R" => :right,
        "L" => :left
      }[instruction[0]]
    end

    def parse_steps(instruction)
      instruction[1..].to_i
    end
  end

  class << self
    def part_one(input)
      lock = Lock.new(instructions: input)
      lock.password
    end

    def part_two(input)
      lock = Lock.new(instructions: input)
      lock.secure_password
    end
  end
end
