require'csv'

file = ARGV[0]
fixtures = CSV.parse(File.read(ARGV[1]))

open("./temp.csv", 'w') { |f|
    fixtures.drop(1).each do |row|
        f.puts row.join(",")
    end
}
		CSV.foreach(file,:headers => true) do |row|
		hurl = row[5]
		p0 = `curl -F \"file=@./temp.csv\" #{hurl}/sums 2>/dev/null`.to_s  
		p1 = `curl -F \"file=@./temp.csv\" #{hurl}/filters 2>/dev/null`.to_s
		p2 = `curl -F \"file=@./temp.csv\" #{hurl}/intervals 2>/dev/null`.to_s		
		p3 = `curl -F \"file=@./temp.csv\" #{hurl}/lin_regressions 2>/dev/null`.to_s
		if row[0] == "" || row[1] == "" || row[2] == "" || row[3] == "" || row[4] == "" || row[5] == "" || row[6] == ""
     		p "#{row[1]}, #{row[2]}, #{row[3]}, #{row[4]}, 0"
		else	
			lin_reg = fixtures[0][3].to_s		
			if (p0 == fixtures[0][0] && p1 == fixtures[0][1]  && p2 == fixtures[0][2]  && p3 == lin_reg )
				p "#{row[1]} #{row[2]} #{row[3]} #{row[4]}: 1\n"

			else 
				p "#{row[1]} #{row[2]} #{row[3]} #{row[4]}: 0\n"
			end
		end
		end 
