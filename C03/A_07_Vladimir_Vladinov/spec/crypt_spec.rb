require_relative '../crypt.rb'

describe Caesar do
	it "returns" do
		expect(Caesar.new.crypt("TuEs", 1)).to eq "UvFt"
		expect(Caesar.new.crypt("te ;sT0", 2)).to eq "vg ;uV0"
		expect(Caesar.new.crypt("Sobranie", 26)).to eq "Sobranie"
		expect(Caesar.new.crypt("", 50)).to eq ""
	end
end
