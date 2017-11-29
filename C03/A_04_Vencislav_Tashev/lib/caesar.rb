class Caesar
	def shift_letter letter, base, offset
		(((letter.ord - base) + offset) % 26 + base).chr
	end

	def crypt message, key
		message.chars.map do |ch|
			case ch
			when 'a'..'z'
				shift_letter ch, 'a'.ord, key
			when 'A'..'Z'
				shift_letter ch, 'A'.ord, key
			end
		end.join
	end

	def decrypt message, key
		crypt message, -key
	end
end

