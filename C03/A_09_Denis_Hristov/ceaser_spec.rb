require_relative "./ceaser.rb"

describe Ceaser do
    it "is encrypted to" do
        expect(Ceaser.new.encrypt("TUES", 2)).to eq "VWGU"
    end

    it "is encrypted to" do
        expect(Ceaser.new.encrypt("abc", 3)).to eq "def"
    end

    it "is encrypted to" do
        expect(Ceaser.new.encrypt("xyz", 2)).to eq "zab"
    end

    it "is encrypted to" do
        expect(Ceaser.new.encrypt("XYZ", 2)).to eq "ZAB"
    end

    it "is encrypted to" do
        expect(Ceaser.new.encrypt("XYZ", 28)).to eq "ZAB"
    end

    it "is encrypted to" do
        expect(Ceaser.new.encrypt("xyz", 28)).to eq "zab"
    end

    it "is encrypted to" do
        expect(Ceaser.new.encrypt("xYz", 28)).to eq "zAb"
    end

    it "is encrypted to" do
        expect(Ceaser.new.encrypt("abYZ", 5)).to eq "fgDE"
    end

    it "is encrypted to" do
        expect(Ceaser.new.encrypt("abYZ", 0)).to eq "abYZ"
    end

    it "is encrypted to" do
        expect(Ceaser.new.encrypt("edhbgjz", -3873)).to eq "feichka"
    end

    it "is encrypted to" do
        expect(Ceaser.new.encrypt("edhbgjz", -3)).to eq "baeydgw"
    end

    it "is encrypted to" do
        expect(Ceaser.new.encrypt("feichka", 26)).to eq "feichka"
    end

    it "is encrypted to" do
        expect(Ceaser.new.encrypt("zZ", 1)).to eq "aA"
    end

end
