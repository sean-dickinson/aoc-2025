module Day05
  Inventory = Data.define(:ranges, :ingredients) do
    class << self
      def from(input)
        ranges, ingredients = input.slice_before(&:empty?).map { |a| a.reject(&:empty?) }
        new(ranges: parse_ranges(ranges), ingredients: parse_ingredients(ingredients))
      end

      private

      def parse_ranges(ranges)
        ranges.map do |raw_range|
          raw_range.split("-").map(&:to_i)
        end.map do |endpoints|
          Range.new(*endpoints)
        end
      end

      def parse_ingredients(ingredients)
        ingredients.map(&:to_i)
      end
    end

    def fresh_count
      ingredients.count do |id|
        is_fresh? id
      end
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
      raise NotImplementedError
    end
  end
end
