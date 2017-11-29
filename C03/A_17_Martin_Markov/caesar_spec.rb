require 'caesar'

RSpec.describe Caesar do
	it "should return VWGU" do
		a = Caesar.new.crypt(0, 0)
		expect(a).to eql "VWGU"
	end
end
