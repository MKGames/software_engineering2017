require "Caesar"
RSpec.describe Caesar do
    describe ".crypt" do
        it "adds key to string" do
            expect(Caesar.new.crypt("TUES", 2)).to eql("VWGU")
        end
    end
end
