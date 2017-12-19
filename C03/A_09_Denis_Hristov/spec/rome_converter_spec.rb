require "rome_converter"

describe RomeConverter do
    describe "to_rome" do
        context "simple conversions" do
            it "1 to I" do
                expect(RomeConverter.new.to_rome(1)).to eql("I")
            end

            it "5 to V" do
                expect(RomeConverter.new.to_rome(5)).to eql("V")
            end

            it "10 to X" do
                expect(RomeConverter.new.to_rome(10)).to eql("X")
            end

            it "50 to L" do
                expect(RomeConverter.new.to_rome(50)).to eql("L")
            end

            it "100 to C" do
                expect(RomeConverter.new.to_rome(100)).to eql("C")
            end

            it "500 to D" do
                expect(RomeConverter.new.to_rome(500)).to eql("D")
            end

            it "1000 to M" do
                expect(RomeConverter.new.to_rome(1000)).to eql("M")
            end
        end

        context "complex conversions" do
            it "4 to IV" do
                expect(RomeConverter.new.to_rome(4)).to eql("IV")
            end

            it "9 to IX" do
                expect(RomeConverter.new.to_rome(9)).to eql("IX")
            end

            it "40 to XL" do
                expect(RomeConverter.new.to_rome(40)).to eql("XL")
            end

            it "90 to XC" do
                expect(RomeConverter.new.to_rome(90)).to eql("XC")
            end

            it "400 to CD" do
                expect(RomeConverter.new.to_rome(400)).to eql("CD")
            end

            it "900 to CM" do
                expect(RomeConverter.new.to_rome(900)).to eql("CM")
            end

            it "4998 to MMMDDDCCCLLLXXXVVVIII" do
                expect(RomeConverter.new.to_rome(4998)).to eql("MMMDDDCCCLLLXXXVVVIII")
            end
        end
    end

    describe "to_dec" do
        context "simple conversions" do
            it "I to 1" do
                expect(RomeConverter.new.to_dec("I")).to eql(1)
            end

            it "V to 5" do
                expect(RomeConverter.new.to_dec("V")).to eql(5)
            end

            it "X to 10" do
                expect(RomeConverter.new.to_dec("X")).to eql(10)
            end

            it "L to 50" do
                expect(RomeConverter.new.to_dec("L")).to eql(50)
            end

            it "C to 100" do
                expect(RomeConverter.new.to_dec("C")).to eql(100)
            end

            it "D to 500" do
                expect(RomeConverter.new.to_dec("D")).to eql(500)
            end

            it "M to 1000" do
                expect(RomeConverter.new.to_dec("M")).to eql(1000)
            end
        end

        context "complex conversions" do
            it "IV to 4" do
                expect(RomeConverter.new.to_dec("IV")).to eql(4)
            end

            it "IX to 9" do
                expect(RomeConverter.new.to_dec("IX")).to eql(9)
            end

            it "XL to 40" do
                expect(RomeConverter.new.to_dec("XL")).to eql(40)
            end

            it "XC to 90" do
                expect(RomeConverter.new.to_dec("XC")).to eql(90)
            end

            it "CD to 400" do
                expect(RomeConverter.new.to_dec("CD")).to eql(400)
            end

            it "CM to 900" do
                expect(RomeConverter.new.to_dec("CM")).to eql(900)
            end

            it "MMMDDDCCCLLLXXXVVVIII to 4998" do
                expect(RomeConverter.new.to_dec("MMMDDDCCCLLLXXXVVVIII")).to eql(4998)
            end
        end
    end
end