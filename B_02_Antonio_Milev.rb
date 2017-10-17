require "csv"

arr = CSV.read(ARGV[0])

arr.each do |n|
	sum = `curl -s --form "file=@/home/antonio/Desktop/TUES/TP/ZADA4KI/B_02_Antonio_Milev.csv" #{n[5]}/sums`.to_s
	filter = `curl -s --form "file=@/home/antonio/Desktop/TUES/TP/ZADA4KI/B_02_Antonio_Milev.csv" #{n[5]}/filters`.to_s
	interval = `curl -s --form "file=@/home/antonio/Desktop/TUES/TP/ZADA4KI/B_02_Antonio_Milev.csv" #{n[5]}/intervals`.to_s
	lin_regression = `curl -s --form "file=@/home/antonio/Desktop/TUES/TP/ZADA4KI/B_02_Antonio_Milev.csv" #{n[5]}/lin_regressions`.to_s
	if(n[1] != "" && n[2] != "" && n[3] != "" && n[4] != "" && n[5] != "" && n[6] != "")
		if(sum == "528.00" && filter == "272.00" && interval == "525.00" && lin_regression == "1.000000,0.000000")
			p "#{n[1]} #{n[2]} #{n[3]} #{n[4]} pass"
		else
			p "#{n[1]} #{n[2]} #{n[3]} #{n[4]} fail"
		end
	end
end
