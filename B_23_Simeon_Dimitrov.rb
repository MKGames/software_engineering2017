require 'csv'

hr = 5
cr = 1
nr = 2

arr = CSV.read(ARGV[0])

arr.each do |n|

	sum = `curl --form "file=@/home/simo/Desktop/simo.csv" #{n[hr]}/sums`.to_s
	filter = `curl --form "file=@/home/simo/Desktop/simo.csv" #{n[hr]}/filters`.to_s
	interval = `curl --form "file=@/home/simo/Desktop/simo.csv" #{n[hr]}/intervals`.to_s
	lin_regression = `curl --form "file=@/home/simo/Desktop/simo.csv" #{n[hr]}/lin_regressions`.to_s

	if(n[1] != "" && n[2] != "" && n[3] != "" && n[4] != "" && n[5] != "" && n[6] != "")
		if(sum == "137.00" && filter == "14.00" && interval == "137.00" && lin_regression == "-0.024064,4.560606")

			p "#{n[cr]} #{n[nr]} #{n[3]} #{n[4]} 1"
		else
			p "#{n[cr]} #{n[nr]} #{n[3]} #{n[4]} 0"
		end
	end
end
