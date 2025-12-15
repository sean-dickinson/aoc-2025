require "./04"
RSpec.describe Day04 do
  describe "Cell" do
    it "can be constructed from a value, row index, and column index" do
      cell = Day04::Cell.new(".", 0, 1)

      expect(cell).to be_a Day04::Cell
      expect(cell).to have_attributes(value: ".", row: 0, column: 1)
    end
    it "can be compared to another cell" do
      cell = Day04::Cell.new(".", 0, 1)
      same_cell = Day04::Cell.new(".", 0, 1)

      expect(cell).to eq same_cell
    end
  end
  describe "Grid" do
    it "can be created from an enumerable of strings" do
      grid = Day04::Grid.from([
        "..",
        "@."
      ])

      expect(grid).to be_a Day04::Grid
      expect(grid.row_count).to eq 2
      expect(grid.column_count).to eq 2
    end

    describe "#each_cell" do
      it "yields each cell" do
        grid = Day04::Grid.from([
          "..",
          "@."
        ])

        expected_cells = [
          Day04::Cell.new(value: ".", row: 0, column: 0),
          Day04::Cell.new(value: ".", row: 0, column: 1),
          Day04::Cell.new(value: "@", row: 1, column: 0),
          Day04::Cell.new(value: ".", row: 1, column: 1)
        ]

        cells = grid.enum_for(:each_cell).to_a
        expect(cells).to contain_exactly(*expected_cells)
      end
    end

    describe "#at" do
      it "returns a cell at a given position" do
        grid = Day04::Grid.from([
          "..",
          "@."
        ])

        expect(grid.at(0, 0)).to eq Day04::Cell.new(".", 0, 0)
        expect(grid.at(0, 1)).to eq Day04::Cell.new(".", 0, 1)
        expect(grid.at(1, 0)).to eq Day04::Cell.new("@", 1, 0)
        expect(grid.at(1, 1)).to eq Day04::Cell.new(".", 1, 1)
      end
    end

    describe "#neighbors_for" do
      it "returns the correct values for the top left of the grid" do
        grid = Day04::Grid.from([
          ".@.",
          "@..",
          "..."
        ])

        expect(grid.neighbors_for(0, 0)).to contain_exactly grid.at(0, 1), grid.at(1, 0), grid.at(1, 1)
      end

      it "returns the correct values for the top center of the grid" do
        grid = Day04::Grid.from([
          ".@.",
          "@..",
          "..."
        ])

        expect(grid.neighbors_for(0, 1)).to contain_exactly(
          grid.at(0, 0), grid.at(0, 2),
          grid.at(1, 0), grid.at(1, 1), grid.at(1, 2)
        )
      end

      it "returns the correct values for the top right of the grid" do
        grid = Day04::Grid.from([
          ".@.",
          "@..",
          "..."
        ])

        expect(grid.neighbors_for(0, 2)).to contain_exactly(
          grid.at(0, 1),
          grid.at(1, 1), grid.at(1, 2)
        )
      end

      it "returns the correct values for the center of the grid" do
        grid = Day04::Grid.from([
          ".@.",
          "@..",
          "..."
        ])

        expect(grid.neighbors_for(1, 1))
          .to contain_exactly(
            grid.at(0, 0), grid.at(0, 1), grid.at(0, 2),
            grid.at(1, 0), grid.at(1, 2),
            grid.at(2, 0), grid.at(2, 1), grid.at(2, 2)
          )
      end

      it "returns the correct values for the center right of the grid" do
        grid = Day04::Grid.from([
          ".@.",
          "@..",
          "..."
        ])

        expect(grid.neighbors_for(1, 2))
          .to contain_exactly(
            grid.at(0, 1), grid.at(0, 2),
            grid.at(1, 1),
            grid.at(2, 1), grid.at(2, 2)
          )
      end
    end

    describe "remove!" do
      it "returns a new Grid with the papers that can be removed, removed" do
        grid = Day04::Grid.from([
          ".@.",
          "@..",
          "..."
        ])

        new_grid = grid.remove!
        expected_grid = Day04::Grid.from([
          "...",
          "...",
          "..."
        ])

        expect(new_grid).to eq expected_grid
      end
    end

    describe "removable_count" do
      it "returns the number of removable paper rolls if there are any" do
        grid = Day04::Grid.from([
          ".@.",
          "@..",
          "..."
        ])

        expect(grid.removable_count).to eq 2
      end

      it "returns 0 when no rolls are removeable" do
        grid = Day04::Grid.from([
          "...",
          "...",
          "..."
        ])

        expect(grid.removable_count).to be_zero
      end
    end
  end

  context "part 1" do
    it "returns the correct answer for the example input" do
      input = File.readlines("spec/test_inputs/04.txt", chomp: true)
      expect(Day04.part_one(input)).to eq 13
    end
  end

  context "part 2" do
    it "returns the correct answer for the example input" do
      input = File.readlines("spec/test_inputs/04.txt", chomp: true)
      expect(Day04.part_two(input)).to eq 43
    end
  end
end
