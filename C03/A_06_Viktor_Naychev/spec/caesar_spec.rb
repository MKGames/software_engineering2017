require "caesar"

describe Caesar do
    describe ".crypt" do
        context "given the string TUES" do
            it "returns VWGU" do
                expect(Caesar.new.crypt("TUES", 2)).to eql("VWGU")
            end
        end
        context "given the alphabet and key 4" do
            it "returns the alphabet starting from d" do
                expect(Caesar.new.crypt("abcdefghijklmnopqrstuvwxyz", 4)).to eql("efghijklmnopqrstuvwxyzabcd")
            end
        end
        context "given the string \"ABC:25:12;24\" and key 4" do
            it "returns \"EFG:25:12;24\"" do
                expect(Caesar.new.crypt("ABC:25:12;24", 4)).to eql("EFG:25:12;24")
            end
        end
        context "given the string \"ABCDE\" and key -5" do
            it "returns \"VWXYZ\"" do
                expect(Caesar.new.crypt("ABCDE", -5)).to eql("VWXYZ")
            end
        end
        context "given the string \"abcde\" and key -5" do
            it "returns \"vwxyz\"" do
                expect(Caesar.new.crypt("abcde", -5)).to eql("vwxyz")
            end
        end
    end
end
