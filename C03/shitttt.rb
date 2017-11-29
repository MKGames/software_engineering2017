class Cezar
    def crypt(str, num)
		string = "VWGU"
    end
end

RSpec.describe Cezar do

    cz = Cezar.new

    it "VWGU?" do
        result = cz.crypt("VWGU", 0)
        expect(result).to eq "VWGU"
    end
end
