module Day03
  Bank = Data.define(:batteries) do
    class << self
      def from(string)
        new(string.chars.map(&:to_i))
      end
    end

    def max_joltage
      tens = max_tens
      ones = maximize_ones(tens)
      [tens, ones].join.to_i
    end

    private

    def max_tens
      batteries[0...-1].max
    end

    def maximize_ones(tens)
      start = batteries.find_index(tens) + 1
      batteries[start..].max
    end
  end

  class << self
    def part_one(input)
      input.sum do |line|
        Bank.from(line).max_joltage
      end
    end

    def part_two(input)
      raise NotImplementedError
    end
  end
end
