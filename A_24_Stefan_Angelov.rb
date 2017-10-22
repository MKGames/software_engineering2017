require 'csv'
file = File.new(ARGV[0])
controllers = Array.new(4)
controllers = ["/sums","/filters","/intervals","/lin_regressions"]
CSV.foreach(file) do |row|
	tasks_done = 0
	if row[5] == nil || row[1] == "Клас"
		next
	end
	for i in 0...4
		heroku_path = row[5] + controllers[i].to_s
		r1 = "curl -s -F \"file=@./A_24_Stefan_Angelov.csv\" " + heroku_path
		r1 = `#{r1}`
		case controllers[i]
		when "/sums"
			if r1 == "529.00"
				tasks_done += 1
			end
		when "/filters"
			if r1 == "289.00"
				tasks_done += 1
			end
		when "/intervals"
			if r1 == "495.00"
				tasks_done += 1
			end
		when "/lin_regressions"
			if r1 == "0.812500,3.125000"
				tasks_done += 1
			end
		end
	end 
	print row[1] + ',' + row[2] + ',' + row[3] + ' ' + row[4] + ','  
	if tasks_done == 4
		puts '1'
	else
		puts '0'
	end
end
