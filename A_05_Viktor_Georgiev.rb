require'csv'

file = ARGV[0]

CSV.foreach(file) do |row|
	hurl = row[4]

	p `curl -F "file=@A_05_Viktor_Georgiev.csv" #{hurl}/sums` == "5" 
	p `curl -F "file=@A_05_Viktor_Georgiev.csv" #{hurl}/filters` == "0"
	p `curl -F "file=@A_05_Viktor_Georgiev.csv" #{hurl}/intervals` == "0"		
	p `curl -F "file=@A_05_Viktor_Georgiev.csv" #{hurl}/lin_regressions` == "0"
end 
