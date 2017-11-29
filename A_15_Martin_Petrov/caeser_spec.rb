require_relative './caeser.rb'

describe Caeser do
	it "returns" do 
		expect(Caeser.new.crypt("tues", 1)).to eq "bla bla"
	end
end
