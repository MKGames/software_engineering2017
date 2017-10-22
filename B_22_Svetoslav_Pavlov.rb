require 'csv'

csvdoc = ARGV[0]
fixtures = CSV.parse(File.read(ARGV[1]))


open("./temp.csv", 'w') { |f|
    fixture.drop(1).each do |row|
        f.puts row.join(",")
    end
}

CSV.foreach(csvdoc, :headers => true) do |row|
    if (row[1]!= nil && row[2]!= nil && row[3]!= nil && row[4]!= nil && row[5]!= nil && row[6]!= nil)
    
    url = row[5] 
    r1 = `curl -s -F \"file=@./temp.csv\" #{url}/sums`.to_s 
       r4 = `curl -s -F \"file=@./temp.csv\" #{url}/lin_regressions`.to_s  
    r2 = `curl -s -F \"file=@./temp.csv\" #{url}/filters`.to_s  
    r3 = `curl -s -F \"file=@./temp.csv\" #{url}/intervals`.to_s  

    lin_reg = fixture[0][3].to_s
    if (r1 == fixture[0][0] && r2 == fixture[0][1]  && r3 == fixture[0][2]  && r4 == lin_reg )
          puts "#{row[1]}, #{row[2]}, #{row[3]}, #{row[4]}, 1"
    
    else

     puts "#{row[1]}, #{row[2]}, #{row[3]}, #{row[4]}, 0"
    end
end
end
