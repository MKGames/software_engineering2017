require 'csv'

csv_file = ARGV[0]
result = 1


CSV.foreach(csv_file) do |row|
	if row[1]!="" && row[2]!="" && row[3]!="" && row[4]!="" && row[5]!="" && row[6]!=""
	result = 0
	url = row[5] 
	r1 = `curl -F \"file=@./A_13_Katerina_Solenkova.csv\" #{url}/sums` 
   	r4 = `curl -F \"le=@./A_13_Katerina_Solenkova.csv\" #{url}/lin_regressions`  
	r2 = `curl -F \"file=@./A_13_Katerina_Solenkova.csv\" #{url}/filters` 
	r3 = `curl -F \"file=@./A_13_Katerina_Solenkova.csv\" #{url}/intervals` 
	
	
	if r1 == "54.00" && r2== "36.00" && r3 == "54.00" && r4 == "0.000000,2.000000"
		result = 1
	else 
		result = 0
	end

	puts "#{row[3]},#{row[4]}: #{result}"
end
end
