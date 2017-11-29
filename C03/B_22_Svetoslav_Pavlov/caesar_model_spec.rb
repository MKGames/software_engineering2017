require_relative 'classy'

describe Caesar do

	it "Expect key encrypt" do
	caesar = Caesar.new
	message = caesar.crypt("TUES", 2)
	expect(message).to eq "VWGU"
  end
end


