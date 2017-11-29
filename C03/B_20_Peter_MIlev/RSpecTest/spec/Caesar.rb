require_relative './Caesar_spec.rb'

describe Caesar do
    it "Crypt a message" do
        caesar = Caesar.new
        message = caesar.crypt("TUES", 2)
        caesar.crypt("TUES", 2)
        expect(message).to eq "VWGU"
    end
end