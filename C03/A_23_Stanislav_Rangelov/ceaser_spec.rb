require '/ceaser.rb'

RSpec.describe ceaser do 
   context "With valid input" do 

		it "should detect if properly converted" do
			expect (ceaser.new.crypt). to eq("VWGU")
		end

	end
end
