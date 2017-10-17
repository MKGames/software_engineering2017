require 'csv'

file = ARGV[0]

CSV.foreach(file, :headers => true) do |row|
    hurl = row[5]
    p row[3] + row[4]
    if(`curl -F "file=@sum.csv" #{hurl}/sums` == "55.00" && `curl -F "file=@sum.csv" #{hurl}/filters` == "0.00" && `curl -F "file=@sum.csv" #{hurl}/intervals` == "55.00" && `curl -F "file=@sum.csv" #{hurl}/lin_regressions` == "1.000000,0.000000")
      p 1
      else p 0
    end
end
