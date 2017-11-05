require 'csv'

studentsCSV = ARGV[0]
fixturesCSV = ARGV[1]

curlQueryString = 'curl --max-time 3 -s --form "file=@./A_09_Denis_Hristov.csv"'

answer = CSV.read(fixturesCSV, :col_sep => ', ')

CSV.foreach(studentsCSV, :headers => true) do |row|
	herokuLink = row[5]
	correct = 0
	
    sums = `#{curlQueryString} #{herokuLink}/sums`
	filters = `#{curlQueryString}  #{herokuLink}/filters`
	intervals = `#{curlQueryString}  #{herokuLink}/intervals`
	lin_regressions = `#{curlQueryString} #{herokuLink}/lin_regressions`
		
	if sums == answer[0][0] && filters== answer[0][1] && intervals == answer[0][2] && lin_regressions == answer[0][3]
		correct = 1
	end
	
	unless row[1].nil?
		puts "#{row[1]}, #{row[2]}, #{row[3]}, #{row[4]}, #{correct}"
	end
end
