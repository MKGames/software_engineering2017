require 'csv'

csv_file=CSV.read(ARGV[0])
sum_file=CSV.read(ARGV[1])
CSV.parse(sum_file) do |row|
  c1=row[0]
end
CSV.parse(sum_file) do |row|
  c2=row[1]
end
CSV.parse(sum_file) do |row|
  c3=row[2]
end
CSV.parse(sum_file) do |row|
  c4=row[3]
end
puts"#{c1} #{c2} #{c3} #{c4}"
csv_file.each do |row|
    if row[1]!="" && row[2]!="" && row[3]!="" && row[4]!="" && row[5]!="" && row[6]!=""
        r1 = `curl -s --form \"file=@./A_14_Margarita_Marinova.csv\" #{row[5]}/sums`
        r2 =`curl -s --form \"file=@./A_14_Margarita_Marinova.csv\" #{row[5]}/filters`
        r3 =`curl -s --form \"file=@./A_14_Margarita_Marinova.csv\" #{row[5]}/intervals`
        r4 = `curl -s --form \"file=@./A_14_Margarita_Marinova.csv\" #{row[5]}/lin_regressions`
        if r1==c1 && r2==c2 && r3 ==c3 && r4==c4
            puts "#{row[1]},#{row[2]},#{row[3]},#{row[4]}: 1"

        else
            puts "#{row[1]},#{row[2]},#{row[3]},#{row[4]}: 0"
        end
    end
end
