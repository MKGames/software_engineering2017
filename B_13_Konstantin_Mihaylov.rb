require 'csv'

csv_file = ARGV[0]

result1_sums = "126.00"
result2_lin = "0.014006,3.347899"
result3_filters = "40.00"
result4_intervals = "118.00"

counter = 0
CSV.foreach(csv_file) do |row|
	is_correct_result = 0
	url_ = row[5]

	result1 = `curl -s -F \"file=@./B_13_Konstantin_Mihaylov.csv\" #{url_}/sums`
	result2 = `curl -s -F \"file=@./B_13_Konstantin_Mihaylov.csv\" #url_}/lin_regressions`  
	result3 = `curl -s -F \"file=@./B_13_Konstantin_Mihaylov.csv\" #{url_}/filters`
    result4 = `curl -s -F \"file=@./B_13_Konstantin_Mihaylov.csv\" #{url_}/intervals
	
	if result1 == result1_sums  && result2== result2_lin && result3 == result3_filters && result4 == result4_intervals
		is_correct_result = 1
	else 
		is_correct_result = 0
	end
	if counter > 0 && !current_url.nil?
			puts "#{row[1]},#{row[2]},#{row[3]},#{row[4]},#{is_correct_result}\n" 
	end
    counter+=1
end
