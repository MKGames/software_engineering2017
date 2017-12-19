require_relative  'ceaser_model' 
describe Caesar do 
	 it "Expects key encrypt" do 
	caesar = Caesar.new
	message = caesar.crypt("TUES", 2) 
	expect(message).to eq "VWGU"
	end 


end 
