require_relative "../crypt.rb"

describe Caesar do
	it "returns" do
		expect(Caesar.new.crypt("TUES", 1)).to eq "UVF"
	end
end
