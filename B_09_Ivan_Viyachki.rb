require "csv"

student = CSV.read(ARGV[0])
test_ = ARGV[1]
counter = 0

student.each do |row|
        counter += 1
        Thread.new do
                unless row[2].nil? && row[3].nil? && row[4].nil?
                
                        sum = `curl --form "file=@./#{test_}" #{row[5]}/sums 2>/dev/null`.to_s  
                        filter = `curl --form "file=@./#{test_}" #{row[5]}/filters 2>/dev/null`.to_s 
                        interval = `curl --form "file=@./#{test_}" #{row[5]}/intervals 2>/dev/null`.to_s 
                        regression = `curl --form "file=@./#{test_}" #{row[5]}/lin_regressions 2>/dev/null`.to_s 

                        if(sum == "126.00" && filter == "40.00" && interval == "118.00" && regression == "0.014006,3.347899")
                                p "#{row[3]} #{row[4]} 1";
                        else
                                p "#{row[3]} #{row[4]} 0";
                        end
                end
                counter -= 1
                if counter == 0
                        exit
                end
         end        
end 
sleep