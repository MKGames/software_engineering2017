require 'csv'

csv_file = ARGV[0]
file = File.read(ARGV[1])
fixtures = CSV.parse(file)
#result = 0

open("./fixtures.csv", 'w') { |f|
    fixtures.drop(1).each do |row|
        f.puts row.join(",")
    end
}

CSV.foreach(csv_file, :headers => true) do |row|
    if (row[1]!= nil && row[2]!= nil && row[3]!= nil && row[4]!= nil && row[5]!= nil && row[6]!= nil)
    
    url = row[5] 
    r1 = `curl -s -F \"file=@./fixtures.csv\" #{url}/sums`.to_s 
    r4 = `curl -s -F \"file=@./fixtures.csv\" #{url}/lin_regressions`.to_s  
    r2 = `curl -s -F \"file=@./fixtures.csv\" #{url}/filters`.to_s  
    r3 = `curl -s -F \"file=@./fixtures.csv\" #{url}/intervals`.to_s  

    lin_reg = fixtures[0][3].to_s + ',' + fixtures[0][4].to_s
    if (r1 == fixtures[0][0] && r2 == fixtures[0][1]  && r3 == fixtures[0][2]  && r4 == lin_reg )
          puts "#{row[1]}, #{row[2]}, #{row[3]}, #{row[4]}, 1"
    
    else

     puts "#{row[1]}, #{row[2]}, #{row[3]}, #{row[4]}, 0"
    end
end
end
