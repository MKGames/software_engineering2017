require_relative './Caesar.rb'

RSpec.describe Caesar do
	it 'encrypted message successfull' do
		string = "TUES", number = "2".to_i
		expect(Caesar.crypt(string, number)).to eq("VWGU")
	end
end
