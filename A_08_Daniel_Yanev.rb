require 'csv'
require 'net/http'

  f_path = ARGV[0]
ARGV.each do|a|
  puts "Argument: #{a}"
  f_path = a;
end

id = CSV.read(f_path).size

arr = Array.new(id)
name = Array.new(id)
id = 0
CSV.foreach(f_path) do |row|
  url = row[5].to_s
  #url = "https://se-hw-1.herokuapp.com/"
  r1 = `curl --max-time 4 -F "file=@/home/dany/Downloads/A_08_Daniel_Yanev.csv" #{url}sums`
  r2 = `curl --max-time 4 -F "file=@/home/dany/Downloads/A_08_Daniel_Yanev.csv" #{url}filters`
  r3 = `curl --max-time 4 -F "file=@/home/dany/Downloads/A_08_Daniel_Yanev.csv" #{url}intervals`
  r4 = `curl --max-time 4 -F "file=@/home/dany/Downloads/A_08_Daniel_Yanev.csv" #{url}lin_regressions`
  name[id] = row[3].to_s + ' ' + row[4].to_s
  #puts "#{r1}, #{r2}, #{r3}, #{r4}"
  if r1 == "666.00" && r2 == "13.00" && r3 == "645.00" && r4 == "1.000000,0.000000"
    arr[id] = 1
  else
    arr[id] = 0
  end
  id += 1
end

for i in 0..id
  puts "#{name[i]}: #{arr[i]}"
  #puts "HELLO : #{arr[i]}"
end
