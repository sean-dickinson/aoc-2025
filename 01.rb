module Day01
  class Dial
    attr_reader :current

    def initialize(range:, start:)
      @range = range.to_a
      @current = start
    end

    def turn(value)
      updated_value = normalize_value(@current + value)
      @current = @range[updated_value]
    end

    private

    def normalize_value(value)
      value % @range.size
    end
  end

  class Lock
    def initialize(dial:, instructions:)
      @dial = dial
      @instructions = instructions
    end

    def password
      @instructions.count do |instruction|
        execute_instruction(instruction).zero?
      end
    end

    private

    def execute_instruction(instruction)
      direction, value = instruction[0], instruction[1..].to_i
      if direction == "L"
        @dial.turn(-value)
      else
        @dial.turn(value)
      end
    end
  end

  class << self
    def part_one(input)
      dial = Dial.new(range: 0..99, start: 50)
      lock = Lock.new(dial: dial, instructions: input)
      lock.password
    end

    def part_two(input)
      raise NotImplementedError
    end
  end
end
