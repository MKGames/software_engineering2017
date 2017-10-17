require 'csv'

doc = CSV.read(ARGV[0])

doc.each do |row|
	herokuURL = row[5]
	1st_result = `curl -s --form \"file=@./B_24_Simeon_Chakarov.csv\" #{herokuURL}/sums`.to_s
	2nd_result = `curl -s --form \"file=@./B_24_Simeon_Chakarov.csv\" #{herokuURL}/filters`.to_s
   	3rd_result = `curl -s --form \"file=@./B_24_Simeon_Chakarov.csv\" #{herokuURL}/intervals`.to_s
   	4th_result = `curl -s --form \"file=@./B_24_Simeon_Chakarov.csv\" #{herokuURL}/lin_regressions`.to_s
	if row[1]!="" && row[2]!="" && row[3]!="" && row[4]!="" && row[5]!="" && row[6]!=""
		if(1st_result== "528.00" && 
		2nd_result== "272.00" && 
		3rd_result == "525.00" && 
		4th_result=="1.000000,0.000000")
			puts "#{row[1]} #{row[2]} #{row[3]} #{row[4]} #{row[5]}: 1"
		else
			puts "#{row[1]} #{row[2]} #{row[3]} #{row[4]} #{row[5]}: 0"
		end
	end
end
