require 'csv'

csv_file = ARGV[0]

result1_curl = "90.00"
result2_curl = "0.003953,1.909091"
result3_curl = "150.00"
result4_curl = "60.00"

counter = 0
CSV.foreach(csv_file) do |row|
	is_correct_result = 0
	url_ = row[5]

	result1 = `curl -s -F \"file=@./B_13_Konstantin_Mihaylov.csv\" #{url_}/sums`
	result2 = `curl -s -F \"file=@./B_13_Konstantin_Mihaylov.csv\" #url_}/lin_regressions`  
	result3 = `curl -s -F \"file=@./B_13_Konstantin_Mihaylov.csv\" #{url_}/filters`
    result4 = `curl -s -F \"file=@./B_13_Konstantin_Mihaylov.csv\" #{url_}/intervals
	
	if result1 == result1_curl  && result2== result2_curl && result3 == result3_curl && result4 == result4_curl
		is_correct_result = 1
	else 
		is_correct_result = 0
	end
	if counter > 0 && !current_url.nil?
			puts "#{row[1]},#{row[2]},#{row[3]},#{row[4]},#{is_correct_result}\n" 
	end
    counter+=1
end
