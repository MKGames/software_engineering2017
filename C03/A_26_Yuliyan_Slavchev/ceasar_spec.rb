require '../ceasar.rb'

RSpec.describe Ceasar do
	describe '#crypt'
	it "prints ceasar encrypt" do
		caesar = Caesar.new.crypt(0, 0)
	expect(caesar).to eq "VWGU"
	end
end "


