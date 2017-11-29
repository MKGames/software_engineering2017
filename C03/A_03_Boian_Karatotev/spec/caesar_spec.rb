require "caesar"

describe Caesar do

  describe "#crypt" do
    context "given a string and number" do
      it "excrypts it" do
        expect(Caesar.new.crypt("TUES", 2)).to eql("VWGU")
      end
    end

    context "given a string and number" do
      it "decrypts it" do
        expect(Caesar.new.crypt("VWGU", -2)).to eql("TUES")
      end
    end
  end
end
