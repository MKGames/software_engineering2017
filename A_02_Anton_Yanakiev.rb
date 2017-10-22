require 'csv'

	file = ARGV[0]
	homework = ARGV[1]

	test = 0;
	result = Array.new

	CSV.foreach(homework) do |row|
		result = row
	end
	

	CSV.foreach(file) do |row|

		url = row [5]

		r1 = `curl -F "file=@./A_02_Anton_Yanakiev.csv" #{url}/sums`
		
		r2 = `curl -F "file=@./A_02_Anton_Yanakiev.csv" #{url}/filters` 

		r3 = `curl -F "file=@./A_02_Anton_Yanakiev.csv" #{url}/intervals` 
 
		r4 = `curl -F "file=@./A_02_Anton_Yanakiev.csv" #{url}/lin_regressions`

		if r1 == result[0] && r2 == result[1] && r3 == result[2] && r4 == result[3]

			test = 1;

		else
		
			test = 0;
	end

	puts "#{row[3]}, #{row[4]}, #{test}\n"
end
