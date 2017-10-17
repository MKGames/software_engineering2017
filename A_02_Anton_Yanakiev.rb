require 'csv'

	file = ARGV[0]

	result = 0;

	CSV.foreach(file) do |row|

		url = row [5]

		r1 = `curl -F "file=@./A_02_Anton_Yanakiev.csv" #{url}/sums`
		
		r2 = `curl -F "file=@./A_02_Anton_Yanakiev.csv" #{url}/filters`

		r3 = `curl -F "file=@./A_02_Anton_Yanakiev.csv" #{url}/intervals`
 
		r4 = `curl -F "file=@./A_02_Anton_Yanakiev.csv" #{url}/lin_regressions`

		if r1 == "23644.00" && r2 == "12228.00" && r3 == "16874.00" && r4 == "9.369864,219.991373"

			result = 1;

		else
		
			result = 0;
	end

	puts "#{row[3]}, #{row[4]}, #{result}\n"
end
