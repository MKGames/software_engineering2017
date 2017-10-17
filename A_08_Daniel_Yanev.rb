require 'csv'
require 'net/http'

r1 = %x( echo 'hi' )
puts r1

ARGV.each do|a|
  puts "Argument: #{a}"
  f_path = a;
end
doc = ARGV[0]
puts "#{doc}"
CSV.foreach(f_path) do |row|
  url = row[5].to_s
  uri = URI(url)

  r1 = %x( echo 'hi')
  puts r1
  puts "File opened succesfully"
  #r2 = %x
end
