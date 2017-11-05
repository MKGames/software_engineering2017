require 'csv'

csv_file = ARGV[0]
fixture_csv_file = ARGV[1]

	results = []
CSV.foreach(fixture_csv_file) do |row|
	results = row
end
CSV.foreach(csv_file) do |row|
	scores = 0
	heroku_url = row[5]
	output_01 = `curl -s -F "file=@./A_26_Yuliyan_Slavchev.csv" #{heroku_url}/sums` 
	output_02 = `curl -s -F "file=@./A_26_Yuliyan_Slavchev.csv" #{heroku_url}/filters` 
	output_03 = `curl -s -F "file=@./A_26_Yuliyan_Slavchev.csv" #{heroku_url}/intervals` 
	output_04 = `curl -s -F "file=@./A_26_Yuliyan_Slavchev.csv" #{heroku_url}/lin_regressions` 

	if output_01 == results[0] && output_02 == results[1] && output_03 == results[2] && output_04 == results[3]
			scores = 1
	else 
		scores = 0
	end
	puts "#{row[1]},#{row[2]},#{row[3]},#{row[4]},#{scores}" 
end
