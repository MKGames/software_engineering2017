require 'csv'
# File.delete('./A_12_fixture_without_first_line.csv') if File.exist?('./A_12_fixture_without_first_line.csv')

input_csv_file_with_links = ARGV[0]
fixture_csv = ARGV[1]

# puts fixture_csv
result_curl_1 = 0
result_curl_2 = 0	
result_curl_3 = 0
result_curl_4 = 0

count = 0

file = open("./A_12_fixture_without_first_line_1.csv", "w")
# copy to string
file.close

file = open("A_12_fixture_without_first_line_1.csv","a+")

# writes csv into new file without FL -> A_12_fixture_without_first_line.csv
File.readlines(fixture_csv).drop(1).each do |line| 
  file.write(line)
end 
file.close

file = open("./A_12_fixture_without_first_line_1.csv", "rb")
# copy to string
info = file.read
file.close


file = open("./A_12_work.csv", "w")
file.write(info)
file.close 

file = open("./A_12_work.csv", "r")
contents = file.read

CSV.foreach(fixture_csv) do |row| 
	count += 1
	if count <= 1 # reads only the header
		result_curl_1 = row[0]
		result_curl_2 = row[1]
		result_curl_3 = row[2]
		result_curl_4 = row[3]
	end
	# result_curl_2_0 = row[1]
	# result_curl_2_1 = row[2]
	# result_curl_2 = "#{result_curl_2_0},#{result_curl_2_1}"
	# result_curl_3 = row[3]
	# result_curl_4 = row[4]
	# puts "#{result_curl_1} #{result_curl_2} #{result_curl_3} #{result_curl_4}"
end


count = 0
# filename = "A_12_filename.txt"
# file = open(filename, "w") 
CSV.foreach(input_csv_file_with_links) do |row| 
	result = 0
	current_url = row[5]
	r1 = `curl -s -F \"file=@./A_12_work.csv\" #{current_url}/sums`
	r2 = `curl -s -F \"file=@./A_12_work.csv\" #{current_url}/filters`
	r3 = `curl -s -F \"file=@./A_12_work.csv\" #{current_url}/intervals`
   	r4 = `curl -s -F \"file=@./A_12_work.csv\" #{current_url}/lin_regressions`  
	if r1.to_s == result_curl_1.to_s && r2.to_s == result_curl_2.to_s && r3.to_s == result_curl_3.to_s && r4.to_s == result_curl_4.to_s
		result = 1
	else 
		result = 0
	end

	if count > 0 && !current_url.nil?
		# file.write("#{row[1]},#{row[2]},#{row[3]},#{row[4]},#{result}\n" )
		puts "#{row[1]},#{row[2]},#{row[3]},#{row[4]},#{result}\n"
	end
	count+=1
end
File.truncate('A_12_fixture_without_first_line.csv', 0) # make sure file is empty
file.close

