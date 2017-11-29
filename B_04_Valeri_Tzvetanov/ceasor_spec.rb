require 'rails_helper'

RSpec.describe Ceasor do
 it "ERROR,WRONG STRING" do 
 	expect(Ceasor.crypt).to eq("VWGU")
end
end
