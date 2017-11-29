require "caesar"

describe Caesar do

  describe ".crypt" do
    context "given a string and number" do
      it "excrypts it" do
        expect(Caesar.crypt("TUES", 2)).to eql("VWGU")
      end
    end
  end
end
