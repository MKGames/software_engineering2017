require 'caesar'

RSpec.describe Caesar do
	let(:caesar) { Caesar.new }

	describe "#crypt" do
		it "positive key" do
			expect(caesar.crypt('TUES', 2)).to eq 'VWGU'
		end

		it "negative key" do
			expect(caesar.crypt('Rspec', -1)).to eq 'Qrodb'
		end

		it "keeps the same message on key zero" do
			expect(caesar.crypt('Untouched', 0)).to eq 'Untouched'
		end

		it "overflows last letter correctly" do
			expect(caesar.crypt('zoo', 1)).to eq 'app'
		end
	end

	describe "#decrypt" do
		it "positive key" do
			expect(caesar.decrypt('VWGU', 2)).to eq 'TUES'
		end

		it "negative key" do
			expect(caesar.decrypt('Qrodb', -1)).to eq 'Rspec'
		end

		it "keeps the same message on key zero" do
			expect(caesar.decrypt('Untouched', 0)).to eq 'Untouched'
		end

		it "reverts first letter correctly" do
			expect(caesar.decrypt('app', 1)).to eq 'zoo'
		end
	end
end

