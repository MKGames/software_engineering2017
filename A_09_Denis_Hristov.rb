require 'csv'

studentsCSV = ARGV[0]
fixturesCSV = ARGV[1]

answer = []

CSV.foreach(fixturesCSV, {:col_sep => ', '}) do |row|
	answer[0] = row[0].to_s
	answer[1] = row[1].to_s
	answer[2] = row[2].to_s
	answer[3] = row[3].to_s
end

skipHeader=0

CSV.foreach(studentsCSV) do |row|
	herokuLink = row[5].to_s
	correct = 0
	
	
    sums = `curl --max-time 3 -s --form "file=@./A_09_Denis_Hristov.csv" #{herokuLink}/sums`.to_s
	filters = `curl --max-time 3 -s --form "file=@./A_09_Denis_Hristov.csv" #{herokuLink}/filters`.to_s
	intervals = `curl --max-time 3 -s --form "file=@./A_09_Denis_Hristov.csv" #{herokuLink}/intervals`.to_s
	lin_regressions = `curl --max-time 3 -s --form "file=@./A_09_Denis_Hristov.csv" #{herokuLink}/lin_regressions`.to_s
		
	if sums == answer[0] && filters== answer[1] && intervals == answer[2] && lin_regressions == answer[3]
		correct = 1
	end
	
	if skipHeader > 0
		puts "#{row[1]}, #{row[2]}, #{row[3]}, #{row[4]}, #{correct}"
	end
	
	skipHeader = 1
	#i know i suck
	
end
