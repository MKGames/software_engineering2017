require 'csv'


file = ARGV[0]

CSV.foreach(file,:headers => true) do |row|
	
		unless row[2].nil? && row[3].nil? && row[4].nil? 

		 herokuurl = row[5]
		 
		 sum = `curl –form "file=@ /home/Desktop/Test.csv" #{herokuurl}/sums 2>/dev/null`.to_s
		 filter = `curl –form "file=@/home/Desktop/Test.csv" #{herokuurl}/filters 2>/dev/null`.to_s
		 interval = `curl –form "file=@/home/Desktop/Test.csv" #{herokuurl}/intervals 2>/dev/null`.to_s
		 regresion = `curl –form "file=@/home/Desktop/Test.csv" #{herokuurl}/lin_regresions 2>/dev/null` .to_s 		
		

		p  row[1] + row[2] + row[3] + row[4]

		if(sum == "528.00" && filter == "272.00" && interval == "525.00" && regresion == "1.000000,0.000000")

		p 1

		else p 0

		end 

	end 
end

