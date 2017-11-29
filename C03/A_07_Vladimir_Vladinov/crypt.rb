class Caesar
	def letter?(char)
		char =~ /[A-Za-z]/
	end

	def crypt(msg, key)
		while(key-26 >= 0)
			key -= 26
		end
		new = String.new
		msg.each_char do |c|
			if !letter?(c)
				new << c
				next
			end
			if c=="z"
				new << ("a".ord+(key-1)).chr
				next	
			elsif c=="Z"
				new << ("A".ord+(key-1)).chr
				next
			end
			new << (c.ord + key).chr
		end
		new
	end
end
