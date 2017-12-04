#test for caesar model
require "Caesar"
RSpec.describe Caesar do
    describe ".crypt" do
        it "adds key to string" do
            expect(Caesar.new.crypt("TUES", 2)).to eql("VWGU")
        end

        it "adds key to string" do
            expect(Caesar.new.crypt("TUES", 6)).to eql("ZAKY")
        end

        it "adds key to string" do
            expect(Caesar.new.crypt("tues", 12)).to eql("fgqe")
        end

        it "adds key to string" do
            expect(Caesar.new.crypt("tues", -6)).to eql("noym")
        end

        it "adds key to string" do
            expect(Caesar.new.crypt("TUES", -6)).to eql("NOYM")
        end

        it "adds key to string" do
            expect(Caesar.new.crypt("TUES", -12)).to eql("HISG")
        end

        it "adds key to string" do
            expect(Caesar.new.crypt("tues", -12)).to eql("hisg")
        end
    end
end
