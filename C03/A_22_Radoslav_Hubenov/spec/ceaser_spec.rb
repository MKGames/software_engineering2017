require_relative '../ceaser'

RSpec.describe Ceaser do
    describe  '#crypt'
    it "returns VWGU" do
        test = Ceaser.new.crypt(0, 0)
        expect(test).to eq "VWGU"
    end
end

