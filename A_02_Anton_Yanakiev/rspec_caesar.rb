require './caesar'

RSpec.describe Caesar do
	it "prints VWGU" do
		caesar = Caesar.new.crypt(0, 0)
	expect(caesar).to eq "VWGU"
	end
end 
