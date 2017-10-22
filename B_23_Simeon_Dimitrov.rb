require 'csv'

file = ARGV[0]

CSV.foreach(file, :headers => true) do |row|

	sum = `curl --form "file=@./B_21_Roberta_Netzova.csv" #{row[5]}/sums`
	filter = `curl --form "file=@./B_21_Roberta_Netzova.csv" #{row[5]}/filters`
	interval = `curl --form "file=@./B_21_Roberta_Netzova.csv" #{row[5]}/intervals`
	lin_regression = `curl --form "file=@./B_21_Roberta_Netzova.csv" #{row[5]}/lin_regressions`

	if row[0] != "" && row[1] != "" && row[2] != "" && row[3] != "" && row[4] != "" && row[5] != "" && row[6] != "" 
	if sum == "126.00" && filter == "40.00" && interval == "118.00" && lin_regression == "0.014006,3.347899" 
			
		puts "#{a},№#{row[2]},#{row[3]},#{row[4]},1"
	else  
		puts "#{a},№#{row[2]},#{row[3]},#{row[4]},0"
			
	end
  end

end
