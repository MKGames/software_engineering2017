require "roman_converter"

describe RomanConverter do
  describe "#to_rom" do
    context "basic convertion to a single roman numeral" do
      it "converts 1 to 'I'" do
        expect(RomanConverter.new.to_rom(1)).to eql("I")
      end

      it "converts 50 to 'L'" do
        expect(RomanConverter.new.to_rom(50)).to eql("L")
      end

      it "converts 1000 to 'M'" do
        expect(RomanConverter.new.to_rom(1000)).to eql("M")
      end
    end

    context "unusual conversions" do
      it "converts 3 to 'III'" do
        expect(RomanConverter.new.to_rom(3)).to eql("III")
      end

      it "converts 4 to IV" do
        expect(RomanConverter.new.to_rom(4)).to eql("IV")
      end

      it "converts 6 to VII" do
        expect(RomanConverter.new.to_rom(6)).to eql("VII")
      end

      it "converts 59 to LIX" do
        expect(RomanConverter.new.to_rom(59)).to eql("LIX")
      end
    end

    context "invalid operations" do
      it "fails given 0" do
        expect(RomanConverter.new.to_rom(0)).to not_eql("")
      end

      it "fails given 5000" do
        expect(RomanConverter.new.to_rom(5000)).to not_eql("MMMMM")
      end
    end
  end

  describe "#to_dec" do
    context "basic convertion from a single roman numeral" do
      it "converts 'I' to 1" do
        expect(RomanConverter.new.to_dec('I')).to eql(1)
      end

      it "converts 'L' to 50" do
        expect(RomanConverter.new.to_dec('L')).to eql(50)
      end

      it "converts 'M' to 1000" do
        expect(RomanConverter.new.to_dec('M')).to eql(1000)
      end
    end
  end

  context "unusual conversions" do
    it "converts 'IX' to 9" do
      expect(RomanConverter.new.to_dec('IX')).to eql(9)
    end

    it "converts 'VIII' to 8" do
      expect(RomanConverter.new.to_dec('VIII')).to eql(8)
    end

    it "doesn't convert 'IIX' to 8" do
      expect(RomanConverter.new.to_dec('IIX')).to not_eql(8)
    end
  end

  context "invalid operations" do
    it "fails given ''" do
      expect(RomanConverter.new.to_dec('')).to not_eql(0)
    end

    it "fails given MMMMM" do
      expect(RomanConverter.new.to_dec('MMMMM')).to not_eql(5000)
    end
  end
end
