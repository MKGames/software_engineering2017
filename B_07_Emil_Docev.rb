require "CSV" 
Row = 5 
arr = CSV.read(ARGV[0]) 

arr.reach do |n|
	sum = `curl --form "file=@/home/elsyser/CSV.csv" #{n[Row]}/sums` 
	filter = `curl --form "file=@/home/elsyser/CSV.csv" #{n[Row]}/filters`
	interval = `curl --form "file=@/home/elsyser/CSV.csv" #{n[Row]}/intervals`
	lin-regression = `curl --form "file=@/home/elsyser/CSV.csv" #{n[Row]}/lin_regression` 
	p sum, filter, interval 
	if(n[1] == NULL || n[2] == NULL || n[2] == NULL || n[4] == NULL || n[5] == NULL || n[6] == NULL)
	if(sum ==  528.00 && filters == 272.00 && intervals == 525.00 ) 
	   	p "#{n[1]} #{n[2]} #{n[3]}  pass"
		else
			p "#{n[1]} #{n[2]} #{n[3]} fail"
		end
	end
end
