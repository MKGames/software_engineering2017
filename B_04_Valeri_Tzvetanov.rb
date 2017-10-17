require'csv'

file = ARGV[0]

CSV.foreach(file,:headers => true) do |row|
	hurl = row[5]

	p0 = `curl -F "file=@./B_04_Valeri_Tzvetanov.csv" #{hurl}/sums --max-time 5` == "256.00"  
	p1 = `curl -F "file=@./B_04_Valeri_Tzvetanov.csv" #{hurl}/filters --max-time 5` == "128.00"
	p2 = `curl -F "file=@./B_04_Valeri_Tzvetanov.csv" #{hurl}/intervals --max-time 5` == "255.00"		
	p3 = `curl -F "file=@./B_04_Valeri_Tzvetanov.csv" #{hurl}/lin_regressions --max-time 5` == "0.225806,4.645161"

	
		if row[0] == "" || row[1] == "" || row[2] == "" || row[3] == "" || row[4] == "" || row[5] == "" || row[6] == ""
		p "0"
		else			
			if p0 && p1 && p2 && p3 
			p "#{row[1]} #{row[2]} #{row[3]} #{row[4]}: 1"
			else 
			p "#{row[1]} #{row[2]} #{row[3]} #{row[4]}: 0"
			end
		end
	  
end 
