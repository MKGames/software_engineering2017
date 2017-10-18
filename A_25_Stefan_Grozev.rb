require 'csv'

csv_file = argv[0]

result = 1


CSV.foreach(csv_file) do |row|
	result = 0
	
	current_url = row[5]
	
	r1 = `curl -F "file=@/home/elsyser/A_25_Stefan_Grozev.csv" #{current_url}/sums` 
	r2 = `curl -F "file=@/home/elsyser/A_25_Stefan_Grozev.csv" #{current_url}/filters` 
	r3 = `curl -F "file=@/home/elsyser/A_25_Stefan_Grozev.csv" #{current_url}/intervals` 
	r4 = `curl -F "file=@/home/elsyser/A_25_Stefan_Grozev.csv" #{current_url}/lin_regressions` 
	if r1 == "55" || r2 == "30" || r3 == "55" || r4 == "1.000000,0.000000"
		result = 1
	else 
		result = 0
	end

	puts "#{row[1]} #{row[3]} #{row[4]} #{result}" 
end
