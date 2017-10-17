require 'csv'

file = ARGV[0]

CSV.foreach(file, :headers => true) do |row|
	
	if row[1] != "" && row[2] != "" && row[3] != "" && row[4] != "" && row[5] != "" && row[6] != "" && row[1] != nil && row[2] != nil && row[3] != nil && row[4] != nil && row[5] != nil && row[6] != nil 
	
		if row[5][-1] == '/'
			p a = `curl --form 'file=@/home/mimi5025/B_16_Maria_Stoyanova.csv' #{row[5]}sums -m 5`
			p `curl --form 'file=@/home/mimi5025/B_16_Maria_Stoyanova.csv' #{row[5]}sums -m 5` == "528.00"
			p `curl --form 'file=@/home/mimi5025/B_16_Maria_Stoyanova.csv' #{row[5]}filters -m 5` == "324.00"
			p `curl --form 'file=@/home/mimi5025/B_16_Maria_Stoyanova.csv' #{row[5]}intervals -m 5` == "615.00"
			p `curl --form 'file=@/home/mimi5025/B_16_Maria_Stoyanova.csv' #{row[5]}lin_regressions -m 5` == "1.000000,0.000000"
		else 
			p `curl --form 'file=@/home/mimi5025/B_16_Maria_Stoyanova.csv' #{row[5]}/sums -m 5` == "528.00"
			p `curl --form 'file=@/home/mimi5025/B_16_Maria_Stoyanova.csv' #{row[5]}/filters -m 5` == "324.00"
			p `curl --form 'file=@/home/mimi5025/B_16_Maria_Stoyanova.csv' #{row[5]}/intervals -m 5` == "615.00"
			p `curl --form 'file=@/home/mimi5025/B_16_Maria_Stoyanova.csv' #{row[5]}/lin_regressions -m 5` == "1.000000,0.000000"
		end
	end
end
