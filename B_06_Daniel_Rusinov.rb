require 'csv'

	csv_file = File.read(ARGV[0])
	csv = CSV.parse(csv_file, :headers => true)
	
	csv.each do |row|

		unless row[5].nil?
			result = 0
			herourl = row[5]
	
			r1 =`curl -F "file=@./B_06_Daniel_Rusinov.csv" #{herourl}/sums 2>/dev/null`
			r2 =`curl -F "file=@./B_06_Daniel_Rusinov.csv" #{herourl}/intervals 2>/dev/null`
			r3 =`curl -F "file=@./B_06_Daniel_Rusinov.csv" #{herourl}/filters 2>/dev/null`
			r4 =`curl -F "file=@./B_06_Daniel_Rusinov.csv" #{herourl}/lin_regressions 2>/dev/null`

			if r1 == "15.00" && r2 == "15.00" && r3 == "8.00" && r4 == "0.900000,0.300000" 
				result = 1
			else 
				result = 0
			end

			puts row[1] + "," + row[2] + "," + row[3] + "," + row[4] + "," + result.to_s
		end


	end

	
