require './caeser.rb'

Rspec.describe Caeser, '' do
	it "returns" do
	expect(Ceaser.new.crypt("tues,1")).to eq " yes"

end
end
