require 'csv'
require 'net/http'

  f_path = ARGV[0]
  fixture_csv = ARGV[1]

#ARGV.each do|a|
#  puts "Argument: #{a}"
#  f_path = a;
#end

#id = CSV.read(f_path).size

answer_1 = "0"
answer_2 = "0"
answer_3 = "0"
answer_4 = "0"

id = 0

CSV.foreach(fixture_csv) do |row|
  if(id == 0)
    answer_1 = row[0]
    answer_2 = row[1]
    answer_3 = row[2]
    answer_4 = row[3]
    id += 1
  end
end

CSV.foreach(f_path) do |row|
  url = row[5].to_s
  #url = "https://myapp-herokuk.herokuapp.com/"
  #if fixture_csv = ./A_08_Daniel_Yanev.csv (aka file wihtout header it works for all herokus)
  r1 = `curl --max-time 4 -s -F "file=@fixture_csv" #{url}sums`
  r2 = `curl --max-time 4 -s -F "file=@fixture_csv" #{url}filters`
  r3 = `curl --max-time 4 -s -F "file=@fixture_csv" #{url}intervals`
  r4 = `curl --max-time 4 -s -F "file=@fixture_csv" #{url}lin_regressions`
  #name[id] = row[3].to_s + ' ' + row[4].to_s
  #puts "#{r1}, #{r2}, #{r3}, #{r4}"
  if r1 == answer_1 && r2 == answer_2 && r3 == answer_3 && r4 == answer_4
    puts "#{row[1]},#{row[2]},#{row[3]},#{row[4]}, 1\n"
  else
    puts "#{row[1]},#{row[2]},#{row[3]},#{row[4]}, 0\n"
  end
end
