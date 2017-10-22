require 'CSV' 

file = ARGV[0]

CSV.foreach(file) do |row|

 r1 = `curl -s -F "file=@B_21_Roberta_Netzova.csv" #{row[5]}/sums`   
 r2 = `curl -s -F "file=@B_21_Roberta_Netzova.csv" #{row[5]}/filters`
 r3 = `curl -s -F "file=@B_21_Roberta_Netzova.csv" #{row[5]}/intervals`
 r4 = `curl -s -F "file=@B_21_Roberta_Netzova.csv" #{row[5]}/lin_regressions`
 
 if r1 == "126.00"  && r2== "40.00" && r3 == "118.00" && r4 == "0.014006,3.347899"
  result = 1
 else 
  result = 0
 end
 open('B_14_Kristiqn_Stoimenov_results.csv', 'w') { |f|
 f.puts "#{row[1]}, #{row[2]}, #{row[3]} #{row[4]}, result" 
}
end
