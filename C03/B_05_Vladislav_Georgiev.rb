class Caesar
	def crypt(m,k)
		m.chars.map{|x| 
		chrCode = x.ord + k
		if chrCode >  'z'.ord
			chrCode -= 26;
		elsif chrCode <'a'.ord && chrCode > 'Z'.ord && k >0
			chrCode -= 26;
		end
		if chrCode < 'A'.ord 
			chrCode += 26;
		elsif chrCode < 'a'.ord && chrCode > 'Z'.ord && k <0
			chrCode+=26
		end 
		chrCode.chr
		}.join("")
	end
end

describe Caesar do
	caesar=Caesar.new;
	it "crypt" do
		expect(caesar.crypt("TUES", 2)).to eq "VWGU"
	end
	it "crypt with zzz" do
		expect(caesar.crypt("zzz", 1)).to eq "aaa"
	end
	it "crypt with ZzZ" do
		expect(caesar.crypt("ZzZ", 1)).to eq "AaA"
	end
	it "crypt with aaa" do
		expect(caesar.crypt("AAA", -1)).to eq "ZZZ"
	end
	it "crypt with aaa" do
		expect(caesar.crypt("AaA", -1)).to eq "ZzZ"
	end
end
