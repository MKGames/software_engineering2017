require_relative 'rspec'
describe Caesar do

	it "caesar test" do
		str = Caesar.new();
		expect(str.crypt("TUES",2)).to eq "VWGU"
	end
end
