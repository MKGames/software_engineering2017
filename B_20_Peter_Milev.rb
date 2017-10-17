require "csv"

HeroRow = 5
ClassRow = 1
NumRow = 2
arr = CSV.read(ARGV[0])

arr.each do |n|
	sum = `curl -F "file=@/root/workspace/file.csv" #{n[HeroRow]}/sums 2>/dev/null`.to_s
	filter = `curl -F "file=@/root/workspace/file.csv" #{n[HeroRow]}/filters 2>/dev/null`.to_s
	interval = `curl -F "file=@/root/workspace/file.csv" #{n[HeroRow]}/intervals 2>/dev/null`.to_s
	lin_regression = `curl -F "file=@/root/workspace/file.csv" #{n[HeroRow]}/lin_regressions 2>/dev/null`.to_s
	if(n[1] != "" && n[2] != "" && n[3] != "" && n[4] != "" && n[5] != "" && n[6] != "")
		if(sum == "2567.00" && filter == "5873.00" && interval == "2562.00" && lin_regression == "8.812097,-58.187097")
			p "#{n[ClassRow]} #{n[NumRow]} #{n[3]} #{n[4]} 1"
		else
			p "#{n[ClassRow]} #{n[NumRow]} #{n[3]} #{n[4]} 0"
		end
	end
end
