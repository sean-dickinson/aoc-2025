require "./03"
RSpec.describe Day03 do
  describe "Bank" do
    it "can be created from string" do
      bank = Day03::Bank.from("987654321111111")
      expect(bank).to be_a Day03::Bank
    end

    describe "#max_joltage" do
      it "returns 98 for the first example" do
        bank = Day03::Bank.from("987654321111111")
        expect(bank.max_joltage).to eq 98
      end

      it "returns 89 for the second example" do
        bank = Day03::Bank.from("811111111111119")
        expect(bank.max_joltage).to eq 89
      end

      it "returns 78 for the third example" do
        bank = Day03::Bank.from("234234234234278")
        expect(bank.max_joltage).to eq 78
      end
      it "returns 92 for the fourth example" do
        bank = Day03::Bank.from("818181911112111")
        expect(bank.max_joltage).to eq 92
      end
    end

    describe "#max_joltage with parameter of 12" do
      fit "returns 987654321111 result for example 1" do
        bank = Day03::Bank.from("987654321111111")
        expect(bank.max_joltage(12)).to eq 987654321111
      end

      it "returns 811111111119 for the second example" do
        bank = Day03::Bank.from("811111111111119")
        expect(bank.max_joltage(12)).to eq 811111111119
      end

      it "returns 434234234278 for the third example" do
        bank = Day03::Bank.from("234234234234278")
        expect(bank.max_joltage(12)).to eq 434234234278
      end
      it "returns 888911112111 for the fourth example" do
        bank = Day03::Bank.from("818181911112111")
        expect(bank.max_joltage(12)).to eq 888911112111
      end
    end
  end

  context "part 1" do
    it "returns the correct answer for the example input" do
      input = File.readlines("spec/test_inputs/03.txt", chomp: true)
      expect(Day03.part_one(input)).to eq 357
    end
  end

  context "part 2" do
    it "returns the correct answer for the example input" do
      input = File.readlines("spec/test_inputs/03.txt", chomp: true)
      expect(Day03.part_two(input)).to eq 3121910778619
    end
  end
end
