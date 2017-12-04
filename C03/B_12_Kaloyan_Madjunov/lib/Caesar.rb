class Caesar
    def crypt m, k
				crypted = ""

				m.chars.map! { |b|
					c = b.ord

					if k < 0 && b.ord + k < 97 && b.ord > 90
						c = 97 - (b.ord + k)
						b = 123 - c
					elsif b.ord + k > 122 && b.ord > 90
						c = b.ord + k - 122
						b = 96 + c
					elsif k < 0 && b.ord + k < 65 && b.ord < 91
						c = 65 - (b.ord + k)
						b = 91 - c
					elsif b.ord + k > 90 && b.ord < 91
						c = b.ord + k - 90
						b = 64 + c
					else
						b = c + k
					end

					crypted += b.chr
				}

				crypted
    end
end
