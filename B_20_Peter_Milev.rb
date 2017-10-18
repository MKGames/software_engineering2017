require "csv"

HeroRow = 5
ClassRow = 1
NumRow = 2
arr = CSV.read(ARGV[0])

arr.each do |n|
	sum = `curl -F "file=@./B_21_Roberta_Netzova.csv" #{n[HeroRow]}/sums 2>/dev/null`.to_s
	filter = `curl -F "file=@./B_21_Roberta_Netzova.csv" #{n[HeroRow]}/filters 2>/dev/null`.to_s
	interval = `curl -F "file=@./B_21_Roberta_Netzova.csv" #{n[HeroRow]}/intervals 2>/dev/null`.to_s
	lin_regression = `curl -F "file=@./B_21_Roberta_Netzova.csv" #{n[HeroRow]}/lin_regressions 2>/dev/null`.to_s
	if(n[1] != "" && n[2] != "" && n[3] != "" && n[4] != "" && n[5] != "" && n[6] != "")
		if(sum == "126.00" && filter == "40.00" && interval == "118.00" && lin_regression == "0.014006,3.347899")
			puts "#{n[ClassRow]},#{n[NumRow]},#{n[3]},#{n[4]},1"
		else
			puts "#{n[ClassRow]},#{n[NumRow]},#{n[3]},#{n[4]},0"
		end
	end
end
