require "Caesar"

describe Caesar do
  describe ".crypt" do
    context "given the string TUES" do
      it "returns VWGU" do
        expect(Caesar.crypt("TUES", 2)).to eql("VWGU")
      end
    end
  end
end
