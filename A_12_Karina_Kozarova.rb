require 'csv'
input_file = ARGV[0]

result = 1

CSV.foreach(input_file) do |row| 
	result = 0
	current_url = row[5]

	puts " Current: #{current_url} #{row[3]} #{row[4]}\n" 
	r1 = `curl -F \"file=@./A_12_Karina_Kozarova.csv\" #{current_url}/sums` # 90.00
   	r2 = `curl -F \"file=@./A_12_Karina_Kozarova.csv\" #{current_url}/lin_regressions`  # 0.003953,1.913043
	r3 = `curl -F \"file=@./A_12_Karina_Kozarova.csv\" #{current_url}/filters` # 150.00
	r4 = `curl -F \"file=@./A_12_Karina_Kozarova.csv\" #{current_url}/intervals` #85.00


	if r1 == "90.00" && r2== "0.003953,1.913043" && r3 == "150.00" && r4 == "85.00"
		result = 1
	else 
		result = 0
	end

	puts result
end
