require "./05"
RSpec.describe Day05 do
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
  end

  context "part 1" do
    it "returns the correct answer for the example input" do
      input = File.readlines("spec/test_inputs/05.txt", chomp: true)
      expect(Day05.part_one(input)).to eq 3
    end
  end

  context "part 2" do
    it "returns the correct answer for the example input" do
      pending
      input = File.readlines("spec/test_inputs/05.txt", chomp: true)
      expect(Day05.part_two(input)).to eq 0 # TODO: replace with correct answer
    end
  end
end
