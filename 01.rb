module Day01
  class Dial
    attr_reader :current, :passes

    def initialize(range:, start:)
      @range = range.to_a
      @current = start
      @passes = 0
    end

    def turn(value)
      # puts "rotating dial from #{@current} by #{value}"
      update_passes! @current, value
      update_current! @current + value
      # puts "dial is now at #{@current} (passes: #{@passes})"
      @current
    end

    private

    def update_current!(value)
      normalized_value = value % @range.size
      @current = @range[normalized_value]
    end

    def update_passes!(old_current, value)
      if value.positive?
        update_passes_right(old_current, value)
      else
        update_passes_left(old_current, value)
      end
    end

    def update_passes_left(old_current, value)
      full_rotations = (old_current + value).abs / @range.size
      @passes += full_rotations
      return if old_current.zero?
      sign_changed = old_current * (old_current + value) <= 0
      @passes += 1 if sign_changed
    end

    def update_passes_right(old_current, value)
      full_rotations = (old_current + value) / @range.size
      @passes += full_rotations
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

    def secure_password
      @instructions.each(&method(:execute_instruction))
      @dial.passes
    end

    private

    def execute_instruction(instruction)
      @dial.turn parse_instruction(instruction)
    end

    # @param instruction [String]
    def parse_instruction(instruction)
      instruction.sub('L', '-')
                 .sub('R', '')
                 .to_i
    end
  end

  class << self
    def part_one(input)
      dial = Dial.new(range: 0..99, start: 50)
      lock = Lock.new(dial: dial, instructions: input)
      lock.password
    end

    def part_two(input)
      dial = Dial.new(range: 0..99, start: 50)
      lock = Lock.new(dial: dial, instructions: input)
      lock.secure_password
    end
  end
end
