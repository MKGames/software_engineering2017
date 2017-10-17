require 'csv'
file = ARGV[0]
CSV.foreach(file,:headers => true) do |row|
	url=row[5]
	p url
	ime=row[3]
	familiq=row[4]
	sums = `curl -F "file=@./B_27_Todor_Dimitrov.csv" #{url}/sums 2>/dev/null -m 5` == "551.00"
	filters = `curl -F "file=@./B_27_Todor_Dimitrov.csv" #{url}/filters 2>/dev/null -m 5` == "2.00"
	lin_regressions = `curl -F "file=@./B_27_Todor_Dimitrov.csv" #{url}/lin_regressions 2>/dev/null -m 5` == "2.301401,-25.682353"
	intervals = `curl -F "file=@./B_27_Todor_Dimitrov.csv" #{url}/intervals 2>/dev/null -m 5` == "529.00"
	if row[0] != "" && row[1] != "" && row[2] != "" && row[3] != "" && row[4] != "" && row[5] != "" && row[6] != "" 
	if sums && filters && lin_regressions && intervals
               	puts "#{ime} #{familiq} : 1"
        else 
        	puts "#{ime} #{familiq} : 0"
	end
	end
end
