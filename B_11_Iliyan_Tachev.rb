require 'csv'
file=ARGV[0]
fixture=ARGV[1]
sums_answer="126.00"
filters_answer="40.00"
intervals_answer="118.00"
regressions_answer="0.014006,3.347899"
CSV.foreach(file,:headers => true) do |row|
	if row[1]!=nil && row[2]!=nil && row[3]!=nil && row[4]!=nil && row[5]!=nil && row[6]!=nil
	
	sums=`curl -s -F 'file=@./#{fixture}' #{row[5]}/sums`
	filters=`curl -s -F 'file=@./#{fixture}' #{row[5]}/filters`
	intervals=`curl -s -F 'file=@./#{fixture}' #{row[5]}/intervals`
	lin_regressions=`curl -s -F 'file=@./#{fixture}' #{row[5]}/lin_regressions`
	if sums==sums_answer && filters==filters_answer && intervals==intervals_answer && regressions_answer==lin_regressions
		 p "#{row[1]}, #{row[2]}, #{row[3]}, #{row[4]}, 1"
	else 
		 p "#{row[1]}, #{row[2]}, #{row[3]}, #{row[4]}, 0"
	end

	else 	
		p "#{row[1]}, #{row[2]}, #{row[3]}, #{row[4]}, 0"
	
	end
end

