require 'csv'
csv_file = ARGV[0]
csv_file_2 = ARGV[1]
isWorking = 0;

headers = CSV.open(csv_file_2, &:readline)

header_1_result = headers[0] 
header_2_result = headers[1] 
header_3_result = headers[2] 
header_4_result = headers[3]

new_file = CSV.open(csv_file_2, headers: true)
no_header = []
new_file.each { |row| no_header << row}
	no_header.pop
	CSV.open("input.csv", "w") do |csv|
		no_header.each do |row|
			csv << row
	end
end

new_file.close

CSV.foreach(csv_file) do |row|
	unless row[5].nil?   
	    sumsResult = `curl -s -F \"file=@./input.csv\" #{row[5]}/sums`
	    filtersResult = `curl -s -F \"file=@./input.csv\" #{row[5]}/filters`
	    intervalsResult = `curl -s -F \"file=@./input.csv\" #{row[5]}/intervals`
	    linRegressionsResult = `curl -s -F \"file=@./input.csv\" #{row[5]}/lin_regressions`

	    if sumsResult == header_1_result && filtersResult == header_2_result && intervalsResult == header_3_result && linRegressionsResult == header_4_result
	    	isWorking = 1
	    else isWorking = 0     
	    end
	    puts "#{row[1]},#{row[2]},#{row[3]},#{row[4]},#{isWorking}"   			
	end
end

#This took me way too long
#like 
#way
#way
#WAY
#too long
