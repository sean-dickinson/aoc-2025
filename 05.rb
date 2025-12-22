module Day05
  class RangeMerger
    attr_reader :ranges

    def initialize(ranges)
      @ranges = ranges.sort_by { |range| [range.begin, range.end] }
    end

    def merge!
      @ranges = @ranges.reduce([]) do |merged_ranges, range|
        merge_into(merged_ranges, range)
      end
    end

    private

    def merge_into(existing_ranges, range_to_add)
      overlapping_range = existing_ranges.find { it.overlap? range_to_add }
      if overlapping_range.nil?
        [*existing_ranges, range_to_add]
      else
        merged = merge_ranges([range_to_add, overlapping_range])
        existing_ranges - [overlapping_range] + [merged]
      end
    end

    # @param [Array<Range>] ranges
    def merge_ranges(ranges)
      min = ranges.map(&:begin).min
      max = ranges.map(&:end).max
      min..max
    end
  end

  Inventory = Data.define(:ranges, :ingredients) do
    class << self
      def from(input)
        ranges, ingredients = input.slice_before(&:empty?).map { |a| a.reject(&:empty?) }
        new(ranges: parse_ranges(ranges), ingredients: parse_ingredients(ingredients))
      end

      private

      def parse_ranges(ranges)
        ranges
          .map { it.split("-").map(&:to_i) }
          .map { |endpoints| Range.new(*endpoints) }
      end

      def parse_ingredients(ingredients)
        ingredients.map(&:to_i)
      end
    end

    def fresh_count
      ingredients.count(&method(:is_fresh?))
    end

    def fresh_ids_count
      RangeMerger.new(ranges).merge!.sum(&:size)
    end

    private

    def is_fresh?(id)
      ranges.any? do |range|
        range.cover? id
      end
    end
  end

  class << self
    def part_one(input)
      Inventory.from(input).fresh_count
    end

    def part_two(input)
      Inventory.from(input).fresh_ids_count
    end
  end
end
