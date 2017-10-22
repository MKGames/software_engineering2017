require 'csv'
require 'date'
require 'io/console'
file=CSV.read(ARGV[0])
testFile='B_21_Roberta_Netzova.csv'
fixture=CSV.read(ARGV[1])
count=0
filelenght= file.drop(1).length 
endDate=Date.parse('2017-10-10');
resultFile='./B_05_Vladislav_Georgiev_results.csv'
edited=[]
file.drop(1).each do |row|
	Thread.new do
		res=0
		sum=''
		filter=''
		interval=''
		regression=''
		if  row[5]!=nil && row[4]!=nil && row[3]!=nil && row[2]!=nil && row[1]!=nil
			date=Date.parse(row[0].split(' ')[0]);	
			if row[1]=~/[BbБб]/
				row[1]="11Б"
			elsif row[1]=~/[aAаА]/
				row[1]="11A"
			else
				row[1]="?"
			end
			if date > endDate
				row[7]="0 (After the deadline #{row[0].split(' ')[0]})"
				edited.push(row)
			else
				if row[5][-1]=="/"
					sum= `curl --form 'file=@./#{testFile}' #{row[5]}sums --max-time 9 2>/dev/null`
					filter= `curl --form 'file=@./#{testFile}' #{row[5]}filters --max-time 9 2>/dev/null`
					interval= `curl --form 'file=@./#{testFile}' #{row[5]}intervals --max-time 9 2>/dev/null`
					regression= `curl --form 'file=@./#{testFile}' #{row[5]}lin_regressions --max-time 9 2>/dev/null`
				
				else
					sum= `curl --form 'file=@./#{testFile}' #{row[5]}/sums --max-time 9 2>/dev/null`
					filter= `curl --form 'file=@./#{testFile}' #{row[5]}/filters --max-time 9 2>/dev/null`
					interval= `curl --form 'file=@./#{testFile}' #{row[5]}/intervals --max-time 9 2>/dev/null`
					regression= `curl --form 'file=@./#{testFile}' #{row[5]}/lin_regressions --max-time 9 2>/dev/null`
				end 	
				if sum==fixture[0][0] && filter==fixture[0][1] && interval==fixture[0][2] && regression==fixture[0][3]+","+fixture[0][4]
					row[7]=1
					edited.push(row)
				else
					row[7]=0
					edited.push(row)
				end
			end	
			count+=1
			if count==filelenght 
				edited.sort_by! {|row| [row[1].to_s, row[2].to_i] }
				open(resultFile, 'w') { |f|				
					f.puts "Клас,Номер,Пръво име,Фамилия,Резултат"
	  				edited.each do |row|
						f.puts "#{row[1]},#{row[2]},#{row[3]},#{row[4]},#{row[7]}"					
					end
				}
				exit			
			end
		else
			filelenght-=1
		end
	end
end
sleep
