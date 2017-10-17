require'csv'

file = ARGV[0]

CSV.foreach(file) do |row|
	hurl = row[4]

	p `curl -F "file=@A_23_Stanislav_Rangelov.csv" #{hurl}/sums` == "5" 
	p `curl -F "file=@A_23_Stanislav_Rangelov.csv" #{hurl}/filters` == "0"
	p `curl -F "file=@A_23_Stanislav_Rangelov.csv" #{hurl}/intervals` == "0"		
	p `curl -F "file=@A_23_Stanislav_Rangelov.csv" #{hurl}/lin_regressions` == "0"
end 
