require 'csv'

file = ARGV[0]

a1 = "1176.00"
a2 = "648.00"
a3 = "1023.00"
a4 = "1.000000,3.000000"

CSV.foreach(file) do |row|
    sums = `curl -s --form \"file = @./A_09_Denis_Hristov.csv\" #{row[5]}/sums`.to_s
	filters = `curl --form \"file = @./A_09_Denis_Hristov.csv\" #{row[5]}/filters`.to_s
	intervals = `curl --form \"file = @./A_09_Denis_Hristov.csv\" #{row[5]}/intervals`.to_s
	lin_regressions = `curl --form \"file = @./A_09_Denis_Hristov.csv\" #{row[5]}/lin_regressions`.to_s
	
	correct = 0
	
	if sums == a1 && filters == a2 && intervals == a3 && lin_regressions == a4
		correct = 1
	end
	
	puts "#{row[1]}, #{row[2]}, #{row[3]}, #{row[4]}, #{correct}"
end
