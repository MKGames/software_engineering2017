class CeaserModel
	def caeser_cipher message, key
		alphabet  = Array('a'..'z')
  		non_caps  = Hash[alphabet.zip(alphabet.rotate(key))]
  
  		alphabet = Array('A'..'Z')
  		caps = Hash[alphabet.zip(alphabet.rotate(key))]
  
  		encrypter = non_caps.merge(caps)
		message.chars.map { |c| encrypter.fetch(c, c) }.join
	end

	def crypt message, key
		caeser_cipher(message, key)	
	end

	def decrypt message, key
		caeser_cipher(message, -key)	
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

	it "decrypt test" do
		ceaser = CeaserModel.new
		message = ceaser.decrypt("cDe", 2)
		expect(message).to eq "aBc"
	end

	it "decrypt test" do
		ceaser = CeaserModel.new
		message = ceaser.decrypt("a", 2)
		expect(message).to eq "y"
	end
end
