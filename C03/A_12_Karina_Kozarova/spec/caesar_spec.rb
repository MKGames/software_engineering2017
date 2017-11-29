require_relative  "../caesar.rb"
RSpec.describe Caesar, "#crypt" do 
	
	context "testing caesar" do 
		it "tests caesar" do
			res = Caesar.new 
			expect(res.crypt("TUES" , 2)).to eq "VWGU"
		end
	end 

end 
