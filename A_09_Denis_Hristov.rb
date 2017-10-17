require 'csv'

file = ARGV[0]
hw = 0

sums = 1176.00
filters = 648.00
intervals = 1023.00
lin_regressions = 1.000000, 3.000000

CSV.foreach(file) do |row|
    r1 = `curl --form \"file = @./A_09_Denis_Hristov.csv\" #{row[5]}/sums`.to_f
	r2 = `curl --form \"file = @./A_09_Denis_Hristov.csv\" #{row[5]}/filters`.to_f
	r3 = `curl --form \"file = @./A_09_Denis_Hristov.csv\" #{row[5]}/intervals`.to_f
	r4 = `curl --form \"file = @./A_09_Denis_Hristov.csv\" #{row[5]}/lin_regressions`.to_f
	
	if r1 == sums && r2 == filters && r3 == intervals && r4 == lin_regressions
		hw = 1
	end
	
	puts "#{row[1]}, #{row[2]}, #{row[3]}, #{row[4]}, #{hw}"
end
