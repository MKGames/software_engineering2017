require 'csv'

file = ARGV[0]
fixture = CSV.read(ARGV[1])
result = 0

CSV.foreach(file, :headers => true) do |row|

	heroku_url = row[5]
	#p row[1] + ', ' + row[2] + ', ' + row[3] + ', ' + row[4]  
	
	r1 = `curl -s -F "file=@./B_21_Roberta_Netzova.csv" #{heroku_url}/sums`
	r2 = `curl -s -F "file=@./B_21_Roberta_Netzova.csv" #{heroku_url}/filters`
	r3 = `curl -s -F "file=@./B_21_Roberta_Netzova.csv" #{heroku_url}/intervals`
	r4 = `curl -s -F "file=@./B_21_Roberta_Netzova.csv" #{heroku_url}/lin_regressions`

	if(row[1] != nil && row[2] != nil && row[3] != nil && row[4] != nil && row[5] != nil && row[6] != nil)
		if(r1 == fixture[0][0] && r2 == fixture[0][1] && r3 == fixture[0][2] && r4 == fixture[0][3])
		
			result = 1
		else
		
			result = 0
		end

		puts "#{row[1]}, #{row[2]}, #{row[3]}, #{row[4]}, #{result}"
		#puts row[1] + ', ' + row[2] + ', ' + row[3] + ', ' + row[4] + ', ' + result
	end
	
end
