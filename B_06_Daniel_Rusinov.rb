require 'csv'

	table = ARGV[0]
	fixture = CSV.parse(File.read(ARGV[1]))
	

	open("./helpFixture.csv", 'w') { |f|
    		fixture.drop(1).each do |row|
       			f.puts row.join(",")
		end
	}

	result = 0
	count = 0

	CSV.foreach(table, :headers => true) do |row|

		Thread.new do
			count += 1

			unless row[5].nil?
				herourl = row[5]
					
				r1 =`curl -F "file=@./helpFixture.csv" #{herourl}/sums --max-time 9 2>/dev/null`
				r3 =`curl -F "file=@./helpFixture.csv" #{herourl}/intervals --max-time 9 2>/dev/null`
				r2 =`curl -F "file=@./helpFixture.csv" #{herourl}/filters --max-time 9 2>/dev/null`
				r4 =`curl -F "file=@./helpFixture.csv" #{herourl}/lin_regressions --max-time 9 2>/dev/null`

				
				lin_regression = fixture[0][3].to_s
				if r1 == fixture[0][0] && r2 == fixture[0][1]  && r3 == fixture[0][2]  && r4 == lin_regression
					result = 1
				end

				puts row[1] + "," + row[2] + "," + row[3] + "," + row[4] + "," + result.to_s

				count -= 1

				if count == 0
					exit
				end	
			end
		end
	end

sleep 
