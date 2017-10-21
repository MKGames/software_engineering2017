require 'csv'


file = ARGV[0]
file_test = ARGV[1]
open("./B_16_Maria_Stoyanova_results.csv", 'w') { |f| 
CSV.foreach(file, :headers => true) do |row|
	
	if row[1] != "" && row[2] != "" && row[3] != "" && row[4] != "" && row[5] != "" && row[6] != "" && row[1] != nil && row[2] != nil && row[3] != nil && row[4] != nil && row[5] != nil && row[6] != nil 
	
		if row[5][-1] == '/'
			sum = `curl --form 'file=@./#{file_test}' #{row[5]}sums -m 10 2>/dev/null`
			filter = `curl --form 'file=@./#{file_test}' #{row[5]}filters -m 10 2>/dev/null` 
			interval = `curl --form 'file=@./#{file_test}' #{row[5]}intervals -m 10 2>/dev/null` 
			lin_regression = `curl --form 'file=@./#{file_test}' #{row[5]}lin_regressions -m 10 2>/dev/null` 
		else 
			sum = `curl --form 'file=@./#{file_test}' #{row[5]}/sums -m 10 2>/dev/null` 
			filter = `curl --form 'file=@./#{file_test}' #{row[5]}/filters -m 10 2>/dev/null` 
			interval = `curl --form 'file=@./#{file_test}' #{row[5]}/intervals -m 10 2>/dev/null` 
			lin_regression = `curl --form 'file=@./#{file_test}' #{row[5]}/lin_regressions -m 10 2>/dev/null` 
		end
		if row[1]=~/[BbБб1]/ 
			a = "11Б"
		end
		if row[1]=~/[АаAa1]/ 
   			a = "11А"
		end
		if sum == "126.00" && filter == "40.00" && interval == "118.00" && lin_regression == "0.014006,3.347899" 
			
			f.puts "#{a},№#{row[2]},#{row[3]},#{row[4]},1"
		else  
			f.puts "#{a},№#{row[2]},#{row[3]},#{row[4]},0"
			
		end
	end
end
}
