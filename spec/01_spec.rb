require "./01"
RSpec.describe Day01 do
  describe "Mobius" do
    describe "#right" do
      it "returns the final number when no block given" do
        mobius = Day01::Mobius.new(range: 0..9, pointer: 5)

        expect(mobius.right(1)).to eq 6
        expect(mobius.right(4)).to eq 0
        expect(mobius.right(11)).to eq 1
      end

      it "yields each number passed when a block is given" do
        mobius = Day01::Mobius.new(range: 0..9, pointer: 5)
        passed_numbers = []

        mobius.right(7) do |num|
          passed_numbers << num
        end

        expect(passed_numbers).to eq [6, 7, 8, 9, 0, 1, 2]
      end
    end
    describe "#left" do
      it "returns the final number when no block given" do
        mobius = Day01::Mobius.new(range: 0..9, pointer: 5)

        expect(mobius.left(1)).to eq 4
        expect(mobius.left(5)).to eq 9
        expect(mobius.left(9)).to eq 0
      end

      it "yields each number passed when a block is given" do
        mobius = Day01::Mobius.new(range: 0..9, pointer: 5)
        passed_numbers = []

        mobius.left(7) do |num|
          passed_numbers << num
        end

        expect(passed_numbers).to eq [4, 3, 2, 1, 0, 9, 8]
      end
    end
  end

  describe "Lock" do
    it "can be created with a list of instructions" do
      instructions = ["L5", "R10"]

      lock = Day01::Lock.new(instructions: instructions)

      expect(lock).to be_a Day01::Lock
    end

    describe "#password" do
      it "returns the 0 if the dial never ends on 0" do
        instructions = ["R5"]

        lock = Day01::Lock.new(instructions: instructions)

        expect(lock.password).to eq 0
      end

      it "returns the correct password for a series of instructions" do
        instructions = [
          "L50", # 0
          "R5", # 5
          "L5", # 0
          "R100" # 0
        ]

        lock = Day01::Lock.new(instructions: instructions)

        expect(lock.password).to eq 3
      end
    end
  end

  context "part 1" do
    it "returns the correct answer for the example input" do
      input = File.readlines("spec/test_inputs/01.txt", chomp: true)
      expect(Day01.part_one(input)).to eq 3
    end
  end

  context "part 2" do
    it "returns the correct answer for the example input" do
      input = File.readlines("spec/test_inputs/01.txt", chomp: true)
      expect(Day01.part_two(input)).to eq 6
    end
  end
end
