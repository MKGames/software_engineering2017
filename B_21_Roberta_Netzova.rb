require 'csv'

file = ARGV[0]
	
sums = "126.00"
filters = "40.00"
intervals = "118.00"
regressions = "0.014006,3.347899"

CSV.foreach(file, :headers => true) do |row|
    hurl = row[5]
	filename = "file=@B_21_Roberta_Netzova.csv"
	 if row[2] != nil && row[3] != nil && row[3] != nil && row[4] != nil && row[5] != nil && row[6] != nil 

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
