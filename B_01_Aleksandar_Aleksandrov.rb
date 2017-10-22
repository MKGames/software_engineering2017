require 'csv'

file = ARGV[0]
source = ARGV[1]

CSV.foreach(file, :headers => true, skip_blanks: true) do |row|
	unless row[2].nil? && row[3].nil? && row[4].nil?	
		hurl = row[5]
		if(`curl -F "file=@./#{source}" #{hurl}/sums 2>/dev/null` == "126.00" &&
		   `curl -F "file=@./#{source}" #{hurl}/filters 2>/dev/null` ==  "40.00" && 
		   `curl -F "file=@./#{source}" #{hurl}/intervals 2>/dev/null` == "118.00" &&
	           `curl -F "file=@./#{source}" #{hurl}/lin_regressions 2>/dev/null` == "0.014006,3.347899")
			puts "#{row[1]}, #{row[2]}, #{row[3]}, #{row[4]}, 1"
		else puts "#{row[1]}, #{row[2]}, #{row[3]}, #{row[4]}, 0"
		end
	end
end

