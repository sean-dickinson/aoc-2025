module Day03
  class Maximizer
    def maximize(digits, size)
      remaining_digits = size - 1
      return [digits.max] if remaining_digits.zero?

      maximize_remaining(digits, remaining_digits)
    end

    private

    def maximize_remaining(digits, remaining_digits)
      slice_to_consider = digits[...-remaining_digits]
      max_digit, new_start = find_max_and_new_start(slice_to_consider)
      [max_digit] + maximize(digits[new_start..], remaining_digits)
    end

    def find_max_and_new_start(slice_to_consider)
      max_digit = slice_to_consider.max
      new_start = slice_to_consider.find_index(max_digit) + 1
      [max_digit, new_start]
    end
  end

  class Bank
    class << self
      def from(string)
        new(string.chars.map(&:to_i))
      end
    end

    def initialize(batteries)
      @batteries = batteries
      @maximizer = Maximizer.new
    end

    def max_joltage(target = 2)
      @maximizer.maximize(@batteries, target).join.to_i
    end
  end

  class << self
    def part_one(input)
      input.sum do |line|
        Bank.from(line).max_joltage
      end
    end

    def part_two(input)
      input.sum do |line|
        Bank.from(line).max_joltage(12)
      end
    end
  end
end
