# ceasar_spec.rb
require_relative 'caesar'

describe Caesar do
	it "has to return string" do
		mes = Caesar.new()
		expect(mes.crypto("TUES", 19)).to eq "VWGU"
	end
end