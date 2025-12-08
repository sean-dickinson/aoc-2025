require "./02"
RSpec.describe Day02 do
  describe Day02::Range do
    describe "#from" do
      it "can be created from the string format 'start-end'" do
        id_range = Day02::Range.from("100-200")
        expect(id_range).to be_a Day02::Range
        expect(id_range.begin).to eq 100
        expect(id_range.end).to eq 200
      end
    end

    describe "#ids" do
      it "returns an enumerator of all IDs" do
        id_range = Day02::Range.from("11-22")

        ids = id_range.ids
        expect(ids).to be_a Enumerator
        expect(ids).to all be_a Day02::ID
      end
    end
  end

  describe Day02::ID do
    describe "invalid?" do
      it "returns false for single digit numbers" do
        digits = (0..9).map(&:to_s)

        digits.each do |digit|
          id = Day02::ID.new digit
          expect(id).not_to be_invalid
        end
      end

      it "returns false for numbers where no digits repeat" do
        valid_ids = %w[10 12 19 21 123 12312 12123 1211]

        valid_ids.each do |sequence|
          id = Day02::ID.new sequence
          expect(id).not_to be_invalid
        end
      end

      it "returns true for numbers where digits repeat" do
        invalid_ids = %w[11 22 6464 123123]

        invalid_ids.each do |sequence|
          id = Day02::ID.new sequence
          expect(id).to be_invalid
        end
      end
    end

    describe "strict validity" do
      it "recognizes sequences that are repeated exactly 2x as invalid" do
        invalid_ids = %w[11 22 6464 123123]

        invalid_ids.each do |sequence|
          id = Day02::ID.new sequence
          expect(id).to be_invalid true
        end
      end
      it "recognizes sequences that are repeated more than 2 times as invalid" do
        invalid_ids = %w[12341234 123123123 1212121212 1111111]

        invalid_ids.each do |sequence|
          id = Day02::ID.new sequence
          expect(id).to be_invalid true
        end
      end

      it "recognizes single digit numbers are valid" do
        digits = (0..9).map(&:to_s)

        digits.each do |digit|
          id = Day02::ID.new digit
          expect(id).not_to be_invalid true
        end
      end
    end
  end

  describe Day02::Checker do
    it "is created from multiple ranges" do
      checker = Day02::Checker.from(["11-22", "95-115"])
      expect(checker).to be_a Day02::Checker
    end

    describe "#invalid_ids" do
      it "returns an enumerable of all invalid ids" do
        checker = Day02::Checker.from(["11-22", "95-115"])

        expect(checker.invalid_ids).to contain_exactly 11, 22, 99
      end
    end
  end

  context "part 1" do
    it "returns the correct answer for the example input" do
      input = File.readlines("spec/test_inputs/02.txt", chomp: true)
      expect(Day02.part_one(input)).to eq 1227775554
    end
  end

  context "part 2" do
    it "returns the correct answer for the example input" do
      input = File.readlines("spec/test_inputs/02.txt", chomp: true)
      expect(Day02.part_two(input)).to eq 4174379265
    end
  end
end
