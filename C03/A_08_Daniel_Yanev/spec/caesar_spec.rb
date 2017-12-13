require "Caesar"

describe Caesar do
  describe ".crypt" do
    context "given the string ABC" do
      it "returns EFG" do
        expect(Caesar.new.crypt("ABC", 4)).to eql"EFG"
      end
    end
  end
end
