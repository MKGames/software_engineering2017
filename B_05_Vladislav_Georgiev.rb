require 'csv'
require 'date'
file=CSV.read(ARGV[0])
count=1
endDate=Date.parse('2017-10-10');
file.drop(1).each do |row|
	res=0
	sum=''
	filter=''
	interval=''
	regression=''
	if row[5]!="" && row[4]!="" && row[3]!="" && row[2]!="" && row[1]!="" && row[5]!=nil && row[4]!=nil && row[3]!=nil && row[2]!=nil && row[1]!=nil
		date=Date.parse(row[0].split(' ')[0]);	
		if date > endDate
			p "#{count}.#{row[3]} #{row[4]} => 0 (After the deadline #{row[0].split(' ')[0]})"
		else
		if row[5][-1]=="/"
			sum= `curl --form 'file=@/home/vladislav/testing.csv' #{row[5]}sums --max-time 5 2>/dev/null`
			filter= `curl --form 'file=@/home/vladislav/testing.csv' #{row[5]}filters --max-time 5 2>/dev/null`
			interval= `curl --form 'file=@/home/vladislav/testing.csv' #{row[5]}intervals --max-time 5 2>/dev/null`
			regression= `curl --form 'file=@/home/vladislav/testing.csv' #{row[5]}lin_regressions --max-time 5 2>/dev/null`
				
		else
			sum= `curl --form 'file=@/home/vladislav/testing.csv' #{row[5]}/sums --max-time 5 2>/dev/null`
			filter= `curl --form 'file=@/home/vladislav/testing.csv' #{row[5]}/filters --max-time 5 2>/dev/null`
			interval= `curl --form 'file=@/home/vladislav/testing.csv' #{row[5]}/intervals --max-time 5 2>/dev/null`
			regression= `curl --form 'file=@/home/vladislav/testing.csv' #{row[5]}/lin_regressions --max-time 5 2>/dev/null`
		end 
		if sum=="528.00" && filter=="272.00" && interval=="525.00" && regression=="1.000000,0.000000"
        		p "#{count}.#{row[3]} #{row[4]} => 1"
		else
			p "#{count}.#{row[3]} #{row[4]} => 0"
		end
		end	
		count+=1
    end
end
