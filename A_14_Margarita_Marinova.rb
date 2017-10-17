require 'csv'

c1=528
c2=251.00
c3=525
c4="1.000000,0.000000"

csv_file=CSV.read(ARGV[0])

csv_file.each do |row|
    if row[1]!="" && row[2]!="" && row[3]!="" && row[4]!="" && row[5]!="" && row[6]!=""
        r1 = `curl -s --form \"file=@./A_14_Margarita_Marinova.csv\" #{row[5]}/sums`
        r2 =`curl -s --form \"file=@./A_14_Margarita_Marinova.csv\" #{row[5]}/filters`
        r3 =`curl -s --form \"file=@./A_14_Margarita_Marinova.csv\" #{row[5]}/intervals`
        r4 = `curl -s --form \"file=@./A_14_Margarita_Marinova.csv\" #{row[5]}/lin_regressions`
        if r1==c1 && r2==c2 && r3 ==c3 && r4==c4
            puts "#{row[1]} #{row[2]} #{row[3]} #{row[4]}: 1"

        else
            puts "#{row[1]} #{row[2]} #{row[3]} #{row[4]}: 0"
        end
    end
end
