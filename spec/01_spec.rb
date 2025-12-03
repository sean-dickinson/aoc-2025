require "./01"
RSpec.describe Day01 do
  describe "Dial" do
    it "can be created with a range and a starting number" do
      dial = Day01::Dial.new(range: 0..99, start: 50)

      expect(dial).to be_a Day01::Dial
    end

    it "has a current value" do
      dial = Day01::Dial.new(range: 0..99, start: 50)

      expect(dial.current).to eq 50
    end

    it "can be turned right" do
      dial = Day01::Dial.new(range: 0..99, start: 50)

      dial.turn 30

      expect(dial.current).to eq 80
    end

    it "can be turned left" do
      dial = Day01::Dial.new(range: 0..99, start: 50)

      dial.turn(-20)

      expect(dial.current).to eq 30
    end

    it "wraps around when turning right past the end of the range" do
      dial = Day01::Dial.new(range: 0..99, start: 50)

      dial.turn 49
      expect(dial.current).to eq 99

      dial.turn 1
      expect(dial.current).to eq 0
    end

    it "wraps around when turning left past the start of the range" do
      dial = Day01::Dial.new(range: 0..99, start: 50)

      dial.turn(-51)
      expect(dial.current).to eq 99

      dial.turn(-1)
      expect(dial.current).to eq 98
    end

    it "wraps around multiple times correctly" do
      dial = Day01::Dial.new(range: 0..99, start: 50)

      dial.turn 150
      expect(dial.current).to eq 0

      dial.turn(-250)
      expect(dial.current).to eq 50
    end

    describe "#passes" do
      it "returns 0 if the dial never passes 0" do
        dial = Day01::Dial.new(range: 0..9, start: 5)

        expect(dial.passes).to eq 0

        dial.turn 1
        expect(dial.passes).to eq 0
      end

      it "returns 1 if the dial passes 0 once" do
        dial = Day01::Dial.new(range: 0..9, start: 5)
        dial.turn(6) # ends on 1 but passes 0 once

        expect(dial.passes).to eq 1
      end

      it "returns 1 if the dial ends on 0" do
        dial = Day01::Dial.new(range: 0..9, start: 5)
        dial.turn(5) # ends on 0

        expect(dial.passes).to eq 1
      end

      it "returns 2 if the dial passes 0 twice" do
        dial = Day01::Dial.new(range: 0..9, start: 5)
        dial.turn(15) # ends on 0 after passing once, so a total of 2 passes

        expect(dial.passes).to eq 2
      end

      it "returns 1 if the dial passes 0 once when turning left" do
        dial = Day01::Dial.new(range: 0..9, start: 5)
        dial.turn(-6) # ends on 9 but passes 0 once

        expect(dial.passes).to eq 1
      end

      it "returns 2 if the dial passes 0 twice when turning left" do
        dial = Day01::Dial.new(range: 0..9, start: 5)
        dial.turn(-15) # ends on 0 after passing once, so a total of 2 passes

        expect(dial.passes).to eq 2
      end

      it "returns 1 if the dial ends on 0 when turning left" do
        dial = Day01::Dial.new(range: 0..9, start: 5)
        dial.turn(-5) # ends on 0

        expect(dial.passes).to eq 1
      end

      it "returns the correct number of passes for multiple turns" do
        dial = Day01::Dial.new(range: 0..9, start: 5)
        dial.turn(6) # passes 0 once, now at 1
        dial.turn(-12) # passes 0 twice more, now at 9
        dial.turn(25) # passes 0 three times more, ends at 4

        expect(dial.passes).to eq 6
      end
    end
  end

  describe "Lock" do
    it "can be created with a dial and list of instructions" do
      dial = Day01::Dial.new(range: 0..99, start: 50)
      instructions = ["L5", "R10"]

      lock = Day01::Lock.new(dial: dial, instructions: instructions)

      expect(lock).to be_a Day01::Lock
    end

    describe "#password" do
      it "returns the 0 if the dial never ends on 0" do
        dial = Day01::Dial.new(range: 0..99, start: 50)
        instructions = ["R5"]

        lock = Day01::Lock.new(dial: dial, instructions: instructions)

        expect(lock.password).to eq 0
      end

      it "returns the correct password for a series of instructions" do
        dial = Day01::Dial.new(range: 0..99, start: 50)
        instructions = [
          "L50", # 0
          "R5", # 5
          "L5", # 0
          "R100" # 0
        ]

        lock = Day01::Lock.new(dial: dial, instructions: instructions)

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
