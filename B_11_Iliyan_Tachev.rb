require 'csv'
file=ARGV[0]
fixture = CSV.read(ARGV[1])
csv_file = "B_21_Roberta_Netzova.csv"
sums_answer = fixture[0][0]
filters_answer = fixture[0][1]
intervals_answer = fixture[0][2]
regressions_answer = fixture[0][3]
CSV.foreach(file, :headers => true) do |row|
	if row[1]!=nil && row[2]!=nil && row[3]!=nil && row[4]!=nil && row[5]!=nil && row[6]!=nil
	
	sums=`curl -s -F "file=@./#{csv_file}" #{row[5]}/sums`
	filters=`curl -s -F "file=@./#{csv_file}" #{row[5]}/filters`
	intervals=`curl -s -F "file=@./#{csv_file}" #{row[5]}/intervals`
	lin_regressions=`curl -s -F "file=@./#{csv_file}" #{row[5]}/lin_regressions`
	if sums==sums_answer && filters==filters_answer && intervals==intervals_answer && regressions_answer==lin_regressions
		 p "#{row[1]}, #{row[2]}, #{row[3]}, #{row[4]}, 1"
	else 
		 p "#{row[1]}, #{row[2]}, #{row[3]}, #{row[4]}, 0"
	end
	
	end
end

