require 'csv'
csv_file = ARGV[0]
isWorking = 0;

CSV.foreach(csv_file) do |row|
	unless row[5].nil?   
	    
	    sumsResult = `curl -s -F \"file=@./A_18_Martin_Todorov.csv\" #{row[5]}/sums`
	    filtersResult = `curl -s -F \"file=@./A_18_Martin_Todorov.csv\" #{row[5]}/filters`
	    intervalsResult = `curl -s -F \"file=@./A_18_Martin_Todorov.csv\" #{row[5]}/intervals`
	    linRegressionsResult = `curl -s -F \"file=@./A_18_Martin_Todorov.csv\" #{row[5]}/lin_regressions`

	    if sumsResult == '274.00' && filtersResult == '114.00'	&& intervalsResult == '180.00' && linRegressionsResult == '-0.021538,5.932549'
	    	isWorking = 1
	    else isWorking = 0      
	    end
	    puts "#{row[1]} | #{row[2]} | #{row[3]} | #{row[4]} | #{isWorking}"   			
	end
end
