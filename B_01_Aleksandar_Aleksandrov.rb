require 'csv'

file = ARGV[0]

CSV.foreach(file, :headers => true, skip_blanks: true) do |row|
	unless row[2].nil? && row[3].nil? && row[4].nil?	
		hurl = row[5]
 		puts row[3] + " " + row[4] + ":"  
		if(`curl -F "file=@sum.csv" #{hurl}/sums` == "55.00" && `curl -F "file=@sum.csv" #{hurl}/filters` == "0.00" && `curl -F "file=@sum.csv" #{hurl}/intervals` == "55.00" && `curl -F "file=@sum.csv" #{hurl}/lin_regressions` == "1.000000,0.000000")
			puts 1
		else puts 0
		end
	end
end
