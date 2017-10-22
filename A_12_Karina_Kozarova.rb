require 'csv'
input_file = ARGV[0]

result_curl_1 = "90.00"
result_curl_2 = "0.003953,1.909091"
result_curl_3 = "150.00"
result_curl_4 = "60.00"

count = 0
filename = "A_12_filename.txt"
file = open(filename, "w") 

CSV.foreach(input_file) do |row| 
	result = 0
	current_url = row[5]

	r1 = `curl -s -F \"file=@./A_12_Karina_Kozarova.csv\" #{current_url}/sums` 
   	r2 = `curl -s -F \"file=@./A_12_Karina_Kozarova.csv\" #{current_url}/lin_regressions`  
	r3 = `curl -s -F \"file=@./A_12_Karina_Kozarova.csv\" #{current_url}/filters`
	r4 = `curl -s -F \"file=@./A_12_Karina_Kozarova.csv\" #{current_url}/intervals`

	if r1 == result_curl_1  && r2== result_curl_2 && r3 == result_curl_3 && r4 == result_curl_4
		result = 1
	else 
		result = 0
	end
	if count > 0 && !current_url.nil?
		file.write("#{row[1]},#{row[2]},#{row[3]},#{row[4]},#{result}\n" )
	end
	count+=1
end

file.close

