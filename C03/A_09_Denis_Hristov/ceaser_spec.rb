require_relative "./ceaser.rb"

describe Ceaser do
    it "encrypts" do
        expect(Ceaser.new.encrypt("TUES", 2)).to eq "VWGU"
    end
end
