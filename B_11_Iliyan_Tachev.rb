require 'csv'
file=ARGV[0]
sums_answer=630.00
filters_answer=342.00
intervals_answer=645.00
CSV.foreach(file,:headers => true) do |row|
	if row[1]!="" && row[2]!="" && row[3]!="" && row[4]!="" && row[5]!="" && row[6]!=""
	
sums=`curl -s -F "file=@/home/iliyantachev/new/software_engineering2017/B_11_Iliyan_Tachev.csv --max-time 5" #{row[5]}/sums`
filters=`curl -s -F "file=@/home/iliyantachev/new/software_engineering2017/B_11_Iliyan_Tachev.csv --max-time 5" #{row[5]}/filters`
intervals=`curl -s -F "file=@/home/iliyantachev/new/software_engineering2017/B_11_Iliyan_Tachev.csv --max-time 5" #{row[5]}/intervals`
lin_regressions=`curl -s -F "file=@/home/iliyantachev/new/software_engineering2017/B_11_Iliyan_Tachev.csv --max-time 5" #{row[5]}/lin_regressions`
	#p "#{lin_regressions}"
	#p "#{lin_regressions}"
	#p "#{lin_regressions}"
	if sums==sums_answer && filters==filters_answer && intervals==intervals_answer
		 p "#{row[1]}, #{row[2]}, #{row[3]}, #{row[4]}, 1"
	else 
		 p "#{row[1]}, #{row[2]}, #{row[3]}, #{row[4]}, 0"
	end

	else 	
		p "#{row[1]}, #{row[2]}, #{row[3]}, #{row[4]}, 0"
	
	end
end
