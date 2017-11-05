require 'csv'

file = ARGV[0]

fixture = ARGV[1];


r = 0;

countr = 0

sums = 0
filters = 0
intervals = 0
lin_regressions = 0

CSV.foreach(fixture) do |row|
    if countr == 0
        sums = row[0].to_s
        filters = row[1].to_s
        intervals = row[2].to_s
        lin_regressions = row[3].to_s
        countr += 1
        next
    end
end

#print "#{sums} #{filters} #{intervals} #{lin_regressions}"
#puts

CSV.foreach(file) do |row|
    r1 = `curl -s -m 5 --form \"file = @./#{fixture}\" #{row[5]}/sums`.to_s
    #puts "Operation returned #{r1}"
    r2 = `curl -s -m 5 --form \"file = @./#{fixture}\" #{row[5]}/filters`.to_s
    #puts "Operation returned #{r2}"
    r3 = `curl -s -m 5 --form \"file = @./#{fixture}\" #{row[5]}/intervals`.to_s
    #puts "Operation returned #{r3}"
    r4 = `curl -s -m 5 --form \"file = @./#{fixture}\" #{row[5]}/lin_regressions`.to_s
    #puts "Operation returned #{r4}" 

    #r1 = (r1 == "465.00")
    #r2 = (r2 ==  "225.00")
    #r3 = (r3 == "465.00")
    #r4 = (r4 == "1.000000,1.000000")
    
    if r1 == sums && r2 == filters && r3 == intervals && r4 == lin_regressions
        r = 1
    end

    puts "#{row[1]},#{row[2]},#{row[3]},#{row[4]},#{r}" 
end
