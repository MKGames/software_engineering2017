require "csv"

doc = CSV.read(ARGV[0])
fxt = CSV.read(ARGV[1])

doc.drop(1).each do |row|
	Thread.new do
		if(row[1] != "" && row[1] != nil && row[2] != "" && row[2] != nil && 
			row[3] != "" && row[3] != nil && row[4] != "" && row[4] != nil && 
			row[5] != "" && row[5] != nil && row[6] != "" && row[6] != nil)
			grade = row[1]
			number = row[2]			
			firstName = row[3]
			lastName = row[4]			
			herokUrl = row[5]			

			first = `curl -s -F "file=@./B_21_Roberta_Netzova.csv" #{herokUrl}/sums`.to_s
			second = `curl -s -F "file=@./B_21_Roberta_Netzova.csv" #{herokUrl}/filters`.to_s
			third = `curl -s -F "file=@./B_21_Roberta_Netzova.csv" #{herokUrl}/intervals`.to_s
			fourth = `curl -s -F "file=@./B_21_Roberta_Netzova.csv" #{herokUrl}/lin_regressions`.to_s

			if(first == fxt[0][0] && second == fxt[0][1] && third == fxt[0][2] && 
			fourth == fxt[0][3].to_s + ',' + fxt[0][4].to_s)
			#if(first == "126.00" && second == "40,00" && third == "118.00" && 
			#fourth == "0.014006,3.347899") *acts strange
				puts "#{grade},#{number},#{firstName},#{lastName},1"
			else				
				puts "#{grade},#{number},#{firstName},#{lastName},0"
			end
		end
	end
end
sleep
