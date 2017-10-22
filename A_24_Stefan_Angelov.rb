require 'csv'
file = File.new(ARGV[0])
controllers = Array.new(4)
controllers = ["sums","filters","intervals","lin_regressions"]
csv = File.new(ARGV[1])
csv_fixture = CSV.open(csv,'r') { |csv| csv.first}
csv_path = File.absolute_path(csv)

CSV.foreach(file) do |row|
	tasks_done = 0
	if row[5] == nil || row[1] == "Клас"
		next
	end
	for i in 0...4
		heroku_path = row[5] + controllers[i].to_s
		r1 = "curl -s -F \"file=@#{csv_path}\" " + heroku_path
		r1 = `#{r1}`
		case controllers[i]
		when "sums"
			if r1 == csv_fixture[0].to_s
				tasks_done += 1
			end
		when "filters"
			if r1 == csv_fixture[1].to_s
				tasks_done += 1
			end
		when "intervals"
			if r1 == csv_fixture[2].to_s
				tasks_done += 1
			end
		when "lin_regressions"
			if r1 == csv_fixture[3].to_s
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
