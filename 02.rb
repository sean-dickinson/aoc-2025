module Day02
  ID = Data.define(:sequence) do
    def invalid?(strict = false)
      if strict
        strictly_invalid?
      else
        loosely_invalid?
      end
    end

    def to_i
      sequence.to_i
    end

    private

    def loosely_invalid?
      return false if sequence.size.odd?

      first_half, second_half = split_halves
      first_half == second_half
    end

    def strictly_invalid?
      (1..pivot) # we only need to check for repeats up to the halfway point at most
        .any?(&method(:repeats?))
    end

    def repeats?(slice)
      sequence
        .chars
        .each_slice(slice)
        .to_set
        .size == 1
    end

    def split_halves
      [
        sequence[...pivot],
        sequence[pivot..]
      ]
    end

    def pivot = sequence.size / 2
  end

  Range = Data.define(:begin, :end) do
    class << self
      def from(string)
        parts = string.split("-").map(&:to_i)
        new(*parts)
      end
    end

    def ids
      range.map do |id|
        ID.new id.to_s
      end.to_enum
    end

    private

    def range
      (self.begin..self.end)
    end
  end

  Checker = Data.define(:ranges) do
    class << self
      def from(raw_ranges)
        new raw_ranges.map { |range| Range.from(range) }
      end
    end

    def invalid_ids(strict = false)
      ranges.flat_map do |range|
        range.ids
          .select { |id| id.invalid?(strict) }
          .map(&:to_i)
      end
    end
  end

  class << self
    def part_one(input)
      checker(input).invalid_ids.sum
    end

    def part_two(input)
      checker(input).invalid_ids(true).sum
    end

    private

    def checker(input)
      Checker.from(input.first.split(","))
    end
  end
end
