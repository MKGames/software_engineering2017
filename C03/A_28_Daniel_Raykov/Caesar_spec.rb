require_relative './Caesar.rb'

RSpec.describe Caesar do

	it 'message crypted successfully' do
		message = "TUES", key = "2".to_i
		expect(Caesar.new.crypt(message, key)).to eq("VWGU")
	end
	
	it 'message decrypted successfully' do
		message = "VWGU", key = "2".to_i
		expect(Caesar.new.decrypt(message, key)).to eq("TUES")
	end
end
