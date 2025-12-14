module Day04
  Cell = Data.define(:value, :row, :column) do
    def paper?
      value == "@"
    end
  end
  Grid = Data.define(:array) do
    class << self
      def from(input)
        array = input.map do |row|
          row.chars.to_a
        end
        new(array)
      end
    end
    def row_count = array.size

    def column_count = array.first.size

    def each_cell
      row_count.times do |row|
        column_count.times do |column|
          yield at(row, column)
        end
      end
    end

    def at(row, column)
      value = array.fetch(row).fetch(column)
      Cell.new(value, row, column)
    end

    def neighbors_for(row, column)
      neighbor_range_for(row, :row).flat_map do |row_index|
        neighbor_range_for(column, :column).map do |column_index|
          at(row_index, column_index) unless row_index == row && column_index == column
        end
      end.compact
    end

    private

    def neighbor_range_for(index, type)
      min = [index - 1, 0].max
      max = [index + 1, send(:"#{type}_count") - 1].min
      min..max
    end
  end

  class << self
    def part_one(input)
      grid = Grid.from(input)
      grid.enum_for(:each_cell).select(&:paper?).count do |cell|
        grid.neighbors_for(cell.row, cell.column).count(&:paper?) < 4
      end
    end

    def part_two(input)
      raise NotImplementedError
    end
  end
end
