require 'csv'

csv_file = ARGV[0]


CSV.foreach(csv_file) do |row|
	scores = 0
	heroku_url = row[5]
	
	output_01 = `curl -F "file=@./A_26_Yuliyan_Slavchev.csv" #{heroku_url}/sums` 
	output_02 = `curl -F "file=@./A_26_Yuliyan_Slavchev.csv" #{heroku_url}/filters` 
	output_03 = `curl -F "file=@./A_26_Yuliyan_Slavchev.csv" #{heroku_url}/intervals` 
	output_04 = `curl -F "file=@./A_26_Yuliyan_Slavchev.csv" #{heroku_url}/lin_regressions` 
	if output_01 == "1275.00" && output_02 == "625.00" && output_03 == "1065.00" && output_04 == "1.000000,0.000000"
		scores = 1
	else 
		scores = 0
	end
	puts "#{row[1]} #{row[3]} #{row[4]} #{scores}" 
end
