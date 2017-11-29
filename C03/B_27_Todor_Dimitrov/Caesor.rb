require_relative './Caesor_spec.rb'

describe Caesor do
	it "Crypt a message" do
	caesor = Caesor.new
	message = caesor.crypt("TUES",2)
	expect(message).to eq "VWGU"
	end	
end
