require 'rspec'
require_relative '/home/elsyser/Desktop/ruby/caesar.rb'
RSpec.describe Caesar do
	it "should return the crypted word" do
	 expect(Caesar.new.crypt "TUES", 2). to eq "VWGU"
	 end
end
