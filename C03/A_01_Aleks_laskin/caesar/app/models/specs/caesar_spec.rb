require "spec_helper"
class Caesar
  describe Caesar, '#crypt' do
    it 'returns the crypted code' do
      crypt = Caesar.crypt(k:'0',m:'VWGU')
      expect(crypt).to_eq 'VWGU'
    end
  end
end
