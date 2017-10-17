require 'csv'
input_file = ARGV[0]

result_curl_1 = "90.00"
result_curl_2 = "0.003953,1.909091"
result_curl_3 = "150.00"
result_curl_4 = "60.00"
result = 1
count = 0
CSV.foreach(input_file) do |row| 
	result = 0
	current_url = row[5]

	r1 = `curl -s -F \"file=@./A_12_Karina_Kozarova.csv\" #{current_url}/sums` # 90.00
   	r2 = `curl -s -F \"file=@./A_12_Karina_Kozarova.csv\" #{current_url}/lin_regressions`  # 0.003953,1.913043
	r3 = `curl -s -F \"file=@./A_12_Karina_Kozarova.csv\" #{current_url}/filters` # 150.00
	r4 = `curl -s -F \"file=@./A_12_Karina_Kozarova.csv\" #{current_url}/intervals` #85.00

	if r1 == result_curl_1  && r2== result_curl_2 && r3 == result_curl_3 && r4 == result_curl_4
		result = 1
	else 
		result = 0
	end
	if count > 0
		puts "#{row[1]},#{row[2]},#{row[3]},#{row[4]},#{result}\n" 
	end
		count+=1
end
