require 'csv'

csv = ARGV[0]

CSV.foreach(csv) do |row|
	r1 = p `curl -F "file=@B_04_Valeri_Tzvetanov.csv" #{hurl}/sums`
	r2 = p `curl -F "file=@B_04_Valeri_Tzvetanov.csv" #{hurl}/filters`
	r3 = p `curl -F "file=@B_04_Valeri_Tzvetanov.csv" #{hurl}/intervals`
end
