class Cezar
    def encode(str, shift)
        str.chars.map{|x| 
            code = x.ord + shift
            if(code > 'z'.ord)
                code -= 26
            elsif(code < 'a'.ord && code > 'Z'.ord)
                code -= 26
            end
            code.chr
        }.join("")
    end
end

describe Cezar do
    cz = Cezar.new 
    it "should return bcd when calling with abc and 1" do
        result = cz.encode("abc", 1)
        expect(result).to eq "bcd"
    end
    it "should return abc when calling with abc and 1" do
        result = cz.encode("bcd", -1)
        expect(result).to eq "abc"
    end
    it "should return zzz when calling with aaa and 1" do
        result = cz.encode("zzz", 1)        
        expect(result).to eq "aaa"
    end
    it "should return ZZZ when calling with aaa and 1" do
        result = cz.encode("ZZZ", 1)        
        expect(result).to eq "AAA"
    end
    it "should return ZzaB when calling with aaa and 1" do
        result = cz.encode("ZzaB", 1)        
        expect(result).to eq "AabC"
    end
end
