require "csv"

HerokuRow = 5
ClassRow = 1
NumRow = 2
arr = CSV.read(ARGV[0])
test_file = ARGV[1]
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
				sum = `curl -F "file=@./#{test_file}" #{n[HerokuRow]}/sums 2>/dev/null`.to_s
				filter = `curl -F "file=@./#{test_file}" #{n[HerokuRow]}/filters 2>/dev/null`.to_s
				interval = `curl -F "file=@./#{test_file}" #{n[HerokuRow]}/intervals 2>/dev/null`.to_s
				lin_regression = `curl -F "file=@./#{test_file}" #{n[HerokuRow]}/lin_regressions 2>/dev/null`.to_s
				if(sum == "126.00" && filter == "40.00" && interval == "118.00" && lin_regression == "0.014006,3.347899")
					puts "#{n[ClassRow]},#{n[NumRow]},#{n[3]},#{n[4]},1"
				else
					puts "#{n[ClassRow]},#{n[NumRow]},#{n[3]},#{n[4]},0"
				end	
			end
			counter -= 1
			if(counter == 0)
				exit
			end
		end
	end
end
sleep
