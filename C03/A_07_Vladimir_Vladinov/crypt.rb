class Caesar
	def letter?(char)
		if(char =~ /[A-Z]/) != nil
			return 1
		elsif(char =~ /[a-z]/) != nil
			retun 0
		end
		return -1
	end
	
	def crypt(msg, key)
		while(key-26 >= 0)
			key -= 26
		end
		new = String.new
		msg.each_char do |c|
			num = letter?(c)
			if num  == -1
				new << c
				next
			end
			c = (c.ord + key).chr
			if num == 1
				if c.ord > "Z".ord
					c = (c.ord - 26).chr
				elsif c.ord < "A".ord
					c = (c.ord + 26).chr
				end
			elsif num == 0
				if c.ord > "z".ord
					c = (c.ord - 26).chr
				elsif c.ord < "a".ord
					c = (c.ord + 26).chr
				end
			end
			new << c
		end
		new
	end
end
