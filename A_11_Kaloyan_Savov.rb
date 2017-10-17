require 'csv'
csv_file = ARGV[0]

grades = []

ar = CSV.read(csv_file)

ar.each do |row|
    a = row[5]
    unless row[1] == nil or row[5] == nil or row[0][0,2].to_i > 10
        r1 = `curl --form "file=@./A_11_Kaloyan_Savov.csv" #{a}/sums`
        r2 = `curl --form "file=@./A_11_Kaloyan_Savov.csv" #{a}/filters`
        r3 = `curl --form "file=@./A_11_Kaloyan_Savov.csv" #{a}/intervals`
        r4 = `curl --form "file=@./A_11_Kaloyan_Savov.csv" #{a}/lin_regressions`.to_s

        if r1 == 210 and r2 == 100 and r3 == 460 and r4 == "1.0 0.0"
            grades.push("1")
        end
    else
        grades.push("0")
    end

    p grades

end
