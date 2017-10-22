require 'csv'
file = ARGV[0]
chek_file = ARGV[1]
counter=0
CSV.foreach(file,:headers => true) do |row|
	url=row[5]
	ime=row[3]
	familiq=row[4]
	counter+=1
	Thread.new do
		sums = `curl -F "file=@./#{chek_file}" #{url}/sums 2>/dev/null -m 5` == "126.00"
		filters = `curl -F "file=@./#{chek_file}" #{url}/filters 2>/dev/null -m 5` == "40.00"
		lin_regressions = `curl -F "file=@./#{chek_file}" #{url}/lin_regressions 2>/dev/null -m 5` == "0.014006,3.347899"
		intervals = `curl -F "file=@./#{chek_file}" #{url}/intervals 2>/dev/null -m 5` == "118.00"
		if row[0] != "" && row[1] != "" && row[2] != "" && row[3] != "" && row[4] != "" && row[5] != "" && row[6] != "" 
			if sums && filters && lin_regressions && intervals
	        	       	puts "#{1},#{2},#{ime},#{familiq} : 1"
	        	else 
	        		puts "#{1},#{2},#{ime},#{familiq} : 0"
			end
			
		end
		counter-=1
		if counter ==0
			exit
		end
	end
end
sleep
