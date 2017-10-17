require 'csv'

file = ARGV[0]
hw = 0

CSV.foreach(file) do |row|
    r1 = `curl -s -m 3 --form \"file = @./A_06_Viktor_Naychev.csv\" #{row[5]}/sums`.to_f
