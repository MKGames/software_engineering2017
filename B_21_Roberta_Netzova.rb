require 'csv'

file = ARGV[0]
csv_file = CSV.read(ARGV[1])	
sums = csv_file[0][0]
filters = csv_file[0][1]
intervals = csv_file[0][2]
regressions = csv_file[0][3]

CSV.foreach(file, :headers => true) do |row|
    hurl = row[5]
    filename = "file=@./B_21_Roberta_Netzova.csv"
	 if row[1] != nil && row[2] != nil && row[3] != nil && row[4] != nil && row[5] != nil && row[6] != nil 

    		if (`curl -s -F #{filename} #{hurl}/sums` == sums &&
		   `curl -s -F #{filename} #{hurl}/filters` == filters && 
		   `curl -s -F #{filename} #{hurl}/intervals` == intervals &&  
		   `curl -s -F #{filename} #{hurl}/lin_regressions` == regressions)
		
     			 puts "#{row[1]}, #{row[2]}, #{row[3]} #{row[4]}, 1" 
     		else
			 puts "#{row[1]}, #{row[2]}, #{row[3]} #{row[4]}, 0"
    		end
	end
end
