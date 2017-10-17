require 'csv'

file = ARGV[0]

r = 0;

CSV.foreach(file) do |row|
    r1 = `curl -m 1 --form "csv_file = @./A_06_Viktor_Naychev.csv" #{row[5]}/sums`.to_s
    r2 = `curl -m 1 --form "csv_file = @./A_06_Viktor_Naychev.csv" #{row[5]}/filters`.to_s
    r3 = `curl -m 1 --form "csv_file = @./A_06_Viktor_Naychev.csv" #{row[5]}/intervals`.to_s
    r4 = `curl -m 1 --form "csv_file = @./A_06_Viktor_Naychev.csv" #{row[5]}/lin_regressions`.to_s
    r1 = (r1 == "465.00")
    r2 = (r2 ==  "225.00")
    r3 = (r3 == "465.00")
    r4 = (r4 == "1.000000,1.000000")
    if r1 || r2 || r3 || r4
        r = 1
    end

    puts "#{row[1]} #{row[2]} #{row[3]} #{row[4]} #{r}" 
end
