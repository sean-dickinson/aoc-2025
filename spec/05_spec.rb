require "./05"
RSpec.describe Day05 do
  describe "RangeMerger" do
    it "merges 2 ranges that can be merged" do
      merger = Day05::RangeMerger.new([1..3, 2..4])

      merger.merge!

      expect(merger.ranges).to contain_exactly(1..4)
    end

    it "does not merge 2 ranges that are not mergeable" do
      merger = Day05::RangeMerger.new([1..3, 5..6])

      merger.merge!

      expect(merger.ranges).to contain_exactly (1..3), (5..6)
    end

    it "merges multiple ranges" do
      merger = Day05::RangeMerger.new([1..3, 2..3, 2..4])

      merger.merge!

      expect(merger.ranges).to contain_exactly(1..4)
    end
    it "handles complex merges" do
      merger = Day05::RangeMerger.new([1..6, 2..3, 3..8, 8..12, 8..13, 15..16, 17..20])

      merger.merge!

      expect(merger.ranges).to contain_exactly (1..13), (15..16), (17..20)
    end
  end
  describe "Inventory" do
    it "can be created from input" do
      input = [
        "3-5",
        "",
        "1"
      ]
      inventory = Day05::Inventory.from(input)

      expect(inventory).to be_a Day05::Inventory
      expect(inventory.ranges.size).to eq 1
      expect(inventory.ingredients.size).to eq 1
    end

    describe "#fresh_count" do
      it "returns 0 if no ingredients are fresh" do
        input = [
          "3-5",
          "",
          "1"
        ]
        inventory = Day05::Inventory.from(input)

        expect(inventory.fresh_count).to eq 0
      end

      it "returns 1 if 1 ingredient falls in a range" do
        input = [
          "3-5",
          "",
          "1",
          "5"
        ]

        inventory = Day05::Inventory.from(input)

        expect(inventory.fresh_count).to eq 1
      end

      it "returns 1 if a single ingredient falls in 2 ranges" do
        input = [
          "16-20",
          "12-18",
          "",
          "1",
          "17"
        ]

        inventory = Day05::Inventory.from(input)

        expect(inventory.fresh_count).to eq 1
      end
    end

    describe "#fresh_ids_count" do
      it "returns a count of all fresh ids based only on the range only" do
        input = [
          "3-5",
          "",
          "1"
        ]

        inventory = Day05::Inventory.from(input)

        expect(inventory.fresh_ids_count).to eq 3
      end

      it "handles overlapping ranges correctly" do
        input = [
          "3-5",
          "4-6",
          "8-10",
          "",
          "1"
        ]

        inventory = Day05::Inventory.from(input)

        expect(inventory.fresh_ids_count).to eq([3, 4, 5, 6, 8, 9, 10].size)
      end
    end
  end

  context "part 1" do
    it "returns the correct answer for the example input" do
      input = File.readlines("spec/test_inputs/05.txt", chomp: true)
      expect(Day05.part_one(input)).to eq 3
    end
  end

  context "part 2" do
    it "returns the correct answer for the example input" do
      input = File.readlines("spec/test_inputs/05.txt", chomp: true)
      expect(Day05.part_two(input)).to eq 14
    end
  end
end
