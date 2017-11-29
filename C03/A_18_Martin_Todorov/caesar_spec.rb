require "caesar_crypt"

describe Caesar do 
	describe ".crypt" do
		it "returns VWGU" do
			expect(Caesar.new.crypt("TUES", 2)).to eql("VWGU")
		end
	end
end
