class Caesar

def crypt plaintext,factor
codepoints_array = []
  ciphertext = ""

  a_codepoint = 'a'.ord

  plaintext.split('').each do |letter|
    if letter =~ /[^a-zA-Z]/
      codepoints_array << letter.bytes.join('').to_i
    else
      shifted_codepoint = letter.downcase.bytes.join('').to_i + factor
      codepoints_array << (shifted_codepoint - a_codepoint) % 26 + a_codepoint
    end
  end
  ciphertext = codepoints_array.pack 'C*'
  ciphertext.upcase
end

end

res = Caesar.new 
puts res.crypt("TUES" , 2)
