require 'csv'


file = ARGV[0]
content = File.read(ARGV[1])
test = CSV.parse(content)

CSV.foreach(file,:headers => true) do |row|
	
		unless row[2].nil? && row[3].nil && row[4]?
				
		 herokuurl = row[5]
		 
	
		 sum = `curl –form "file=@ /home/Dcomunets/CSV.csv" #{row[5]}/sums.to_s
		 filter = `curl –form "file=@/home/Documents/CSV.csv" #{row[5]}/filters`.to_s
		 interval = `curl –form "file=@/home/Documents/CSV.csv" #{row[5]}/intervals`.to_s
		 	
		

		p  row[1] + row[2] + row[3] 

		if(sum == test[0][1] && filter == test[0][2] && interval == test[0][3] )

		p 1

		else 
		
		p 0

		end 
	end 
end
