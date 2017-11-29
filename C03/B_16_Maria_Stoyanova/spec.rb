require 'caesar'
	RSpec.describe Caesar do
		it "crypts a message" do
			expect(Caesar.new.crypt("TUES", 2)).to eq "VWGU"
		end
	end
