require "csv"

HerokuRow = 5
ClassRow = 1
NumRow = 2
arr = CSV.read(ARGV[0])
results = CSV.read(ARGV[1])

open("./test_file.csv", 'w') { |file_row|
	i = 0
	results.each do |row|
		if(i != 0)
			file_row.puts row.join(',')
		end
		i = 1
	end
}
counter = 0
first_row = 1
arr.each do |n|
	if(first_row == 1)
		puts "#{n[ClassRow]},#{n[NumRow]},#{n[3]},#{n[4]},Резултат"
		first_row = 0
	else
		counter += 1
		Thread.new do
			unless n[1].nil? && n[2].nil? && n[3].nil? && n[4].nil? && n[5].nil?
				sum = `curl -F "file=@./test_file.csv" #{n[HerokuRow]}/sums 2>/dev/null`.to_s
				filter = `curl -F "file=@./test_file.csv" #{n[HerokuRow]}/filters 2>/dev/null`.to_s
				interval = `curl -F "file=@./test_file.csv" #{n[HerokuRow]}/intervals 2>/dev/null`.to_s
				lin_regression = `curl -F "file=@./test_file.csv" #{n[HerokuRow]}/lin_regressions 2>/dev/null`.to_s
				if(sum == results[0][0] && filter == results[0][1] && interval == results[0][2] && lin_regression == results[0][3])
					puts "#{n[ClassRow]},#{n[NumRow]},#{n[3]},#{n[4]},1"
				else
					puts "#{n[ClassRow]},#{n[NumRow]},#{n[3]},#{n[4]},0"
				end	
			end
			counter -= 1
			if(counter == 0)
				File.delete("./test_file.csv")
				exit
			end
		end
	end
end
#File.delete("./test_file.csv")
sleep
