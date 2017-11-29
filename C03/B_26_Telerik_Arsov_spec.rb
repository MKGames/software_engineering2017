class CeaserModel
	def crypt message, key
		alphabet  = Array('a'..'z')
  		non_caps  = Hash[alphabet.zip(alphabet.rotate(key))]
  
  		alphabet = Array('A'..'Z')
  		caps = Hash[alphabet.zip(alphabet.rotate(key))]
  
  		encrypter = non_caps.merge(caps)
		message.chars.map { |c| encrypter.fetch(c, c) }.join
	end
end

RSpec.describe CeaserModel do
	it "adds key to string" do
		ceaser = CeaserModel.new
		message = ceaser.crypt("tues", 2)
		expect(message).to eq "vwgu"
	end

	it "adds key to string" do
		ceaser = CeaserModel.new
		message = ceaser.crypt("z", 2)
		expect(message).to eq "b"
	end

	it "adds key to string" do
		ceaser = CeaserModel.new
		message = ceaser.crypt("aBc", 2)
		expect(message).to eq "cDe"
	end

	it "adds key to string" do
		ceaser = CeaserModel.new
		message = ceaser.crypt("aBc", -1)
		expect(message).to eq "zAb"
	end
end
