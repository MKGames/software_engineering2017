require 'csv'

file=CSV.read(ARGV[0])

correctSum=528
correctFilter=272.00
correctInterval=525
correctRegression="1.000000,0.000000"
file.each do |row|
    if row[1]!="" && row[2]!="" && row[3]!="" && row[4]!="" && row[5]!="" && row[6]!=""
        sum = `curl –form "file=@/home/elsyser/testing.csv" #{row[5]}/sums`
        filter =`curl –form "file=@/home/elsyser/testing.csv" #{row[5]}/filters`
        interval =`curl –form "file=@/home/elsyser/testing.csv" #{row[5]}/intervals`
        regression = `curl –form "file=@/home/elsyser/testing.csv" #{row[5]}/lin_regressions`
        if sum==correctSum && filter==correctFilter && interval == correctInterval && regression==correctRegression
            p "#{row[3]} #{row[4]}: 1"
        end
    else
        p "#{row[3]} #{row[4]}: 0"
    end
end 
