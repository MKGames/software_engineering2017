require 'csv'
file = File.new(ARGV[0])
controllers = Array.new(4)
controllers = ["/sums","/filters","/intervals","/lin_regressions"]
CSV.foreach(file.path) do |row|
	tasks_done = 0
	if row[5] == nil
		next
	end
	for i in 0...4
		print controllers[i].to_s
		heroku_path = row[5] + controllers[i].to_s
		r1 = "curl -s -F \"file=@/home/stefan50/tp/basic.csv\" " + heroku_path
		r1 = `#{r1}`
		case controllers[i]
		when "/sums"
			if r1 == "529.00"
				tasks_done += 1
				print "\t+1"
			end
		when "/filters"
			if r1 == "289.00"
				tasks_done += 1
				print "\t+1"
			end
		when "/intervals"
			if r1 == "468.00"
				tasks_done += 1
				print "\t+1"
			end
		end
		puts '' 
	end
	if tasks_done == 3
		puts row[3] + ' ' + row[4] + ' ' + ' 1'
	else
		puts row[3] + ' ' + row[4] + ' ' + ' 0'
	end
end
