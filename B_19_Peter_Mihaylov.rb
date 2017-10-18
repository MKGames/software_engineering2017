require "csv"

input_file = CSV.read(ARGV[0])

input_file.each do |row|
	sum = `curl -s --form "file=@/home/user/workspace/Ruby/Git/software_engineering2017/B_19_Peter_Mihaylov.csv" #{row[5]}/sums`.to_s
	filter = `curl -s --form "file=@/home/user/workspace/Ruby/Git/software_engineering2017/B_19_Peter_Mihaylov.csv"  #{row[5]}/filters`.to_s
	interval = `curl -s --form "file=@/home/user/workspace/Ruby/Git/software_engineering2017/B_19_Peter_Mihaylov.csv"  #{row[5]}/intervals`.to_s
	lin_regression = `curl -s --form "file=@/home/user/workspace/Ruby/Git/software_engineering2017/B_19_Peter_Mihaylov.csv"  #{row[5]}/lin_regressions`.to_s
	if(row[1] != "" && row[2] != "" && row[3] != "" && row[4] != "" && row[5] != "" && row[6] != "")
		if(sum == "528.00" && filter == "272.00" && interval == "525.00" && lin_regression == "1.000000,0.000000")
			p "#{row[1]} #{row[2]} #{row[3]} #{row[4]}: 1"
		else
			p "#{row[1]} #{row[2]} #{row[3]} #{row[4]}: 0"
		end
	end
end
