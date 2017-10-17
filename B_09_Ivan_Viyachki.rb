require "csv"

student = CSV.read(ARGV[0])

student.each do |row|

    sum = `curl –form "file=@ /home/Desktop/Test.csv" #{row[5]}/sums 2>/dev/null`.to_s  
        filter = `curl –form "file=@/home/Desktop/Test.csv" #{row[5]}/filter 2>/dev/null`.to_s 
        interval = `curl –form "file=@/home/Desktop/Test.csv" #{row[5]}/interval 2>/dev/null`.to_s 
        regresion = `curl –form "file=@/home/Desktop/Test.csv" #{row[5]}/lin_regresion 2>/dev/null` .to_s 
    if(sum == "528.00" && filter == "272.00" && interval == "525.00" && regresion == "1.000000,0.000000")
        p "#{row[3]} #{row[4]} 1";
    else
        p 0
    end        
end 
