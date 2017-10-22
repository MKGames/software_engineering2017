require 'csv'
input_csv_file_with_links = ARGV[0]
fixture_csv = ARGV[1]

	result_curl_1 = 0
	result_curl_2 = 0	
	result_curl_3 = 0
	result_curl_4 = 0

CSV.foreach(fixture_csv) do |row| 
	result_curl_1 = row[0]
	result_curl_2 = row[1]
	result_curl_3 = row[2]
	result_curl_4 = row[3]

	# result_curl_2_0 = row[1]
	# result_curl_2_1 = row[2]
	# result_curl_2 = "#{result_curl_2_0},#{result_curl_2_1}"
	# result_curl_3 = row[3]
	# result_curl_4 = row[4]
	# puts "#{result_curl_1} #{result_curl_2} #{result_curl_3} #{result_curl_4}"
end

count = 0
# filename = "A_12_filename.txt"
# file = open(filename, "w") 
CSV.foreach(input_csv_file_with_links) do |row| 
	result = 0
	current_url = row[5]

	r1 = `curl -s -F \"file=@./A_12_Karina_Kozarova.csv\" #{current_url}/sums` 
   	r2 = `curl -s -F \"file=@./A_12_Karina_Kozarova.csv\" #{current_url}/lin_regressions`  
	r3 = `curl -s -F \"file=@./A_12_Karina_Kozarova.csv\" #{current_url}/filters`
	r4 = `curl -s -F \"file=@./A_12_Karina_Kozarova.csv\" #{current_url}/intervals`

	if r1 == result_curl_1 && r2.to_s== result_curl_2.to_s && r3.to_s == result_curl_3.to_s && r4.to_s == result_curl_4.to_s
		result = 1
	else 
		result = 0
	end
	if count > 0 && !current_url.nil?
		# file.write("#{row[1]},#{row[2]},#{row[3]},#{row[4]},#{result}\n" )
		puts "#{row[1]},#{row[2]},#{row[3]},#{row[4]},#{result}\n"
	end
	count+=1
end

#file.close

