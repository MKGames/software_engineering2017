require 'csv'

class String
  def black; "\e[30m#{self}\e[0m" end
  def red; "\e[31m#{self}\e[0m" end
  def green; "\e[32m#{self}\e[0m" end
  def brown; "\e[33m#{self}\e[0m" end
  def blue; "\e[34m#{self}\e[0m" end
  def magenta; "\e[35m#{self}\e[0m" end
  def cyan; "\e[36m#{self}\e[0m" end
  def gray; "\e[37m#{self}\e[0m" end
 
  def bg_black; "\e[40m#{self}\e[0m" end
  def bg_red; "\e[41m#{self}\e[0m" end
  def bg_green; "\e[42m#{self}\e[0m" end
  def bg_brown; "\e[43m#{self}\e[0m" end
  def bg_blue; "\e[44m#{self}\e[0m" end
  def bg_magenta; "\e[45m#{self}\e[0m" end
  def bg_cyan; "\e[46m#{self}\e[0m" end
  def bg_gray; "\e[47m#{self}\e[0m" end
 
  def bold; "\e[1m#{self}\e[22m" end
  def italic; "\e[3m#{self}\e[23m" end
  def underline; "\e[4m#{self}\e[24m" end
  def blink; "\e[5m#{self}\e[25m" end
  def reverse_color; "\e[7m#{self}\e[27m" end
end

TestCsvPath = ARGV[1]
Timeout = 10

tests = [
	["/sums", "126.00"], 
	["/intervals", "118.00"], 
	["/filters", "40.00"],
	["/lin_regressions", "0.014006,3.347899"]
]
counter = 0

csv = File.read(ARGV[0])
csv_file = CSV.parse(csv, :headers => true)
deadline = Date.parse('2017-10-10')
dataForFile = []
resultFilePath = './B_26_Telerik_Arsov_results.csv'
csv_file.each do |row|
	counter += 1
	Thread.new do
		result = 1;
		unless row[3].nil? && row[4].nil? && row[5].nil?
			hUrl = row[5]
			curl = "curl --form \"file=@#{TestCsvPath}\" #{hUrl}"
			date = Date.parse(row[0].split(' ')[0]) 
			if row[1] =~/[BbБб]/
				row[1] = "11Б"
			elsif row[1] =~/[aAаА]/
				row[1] = "11A"
			else
				row[1] = "?"
			end
			tests.each do |test|
				#p "#{curl}#{test[0]}"
				response = `#{curl}#{test[0]} 2>/dev/null -m #{Timeout}`
				#puts response
				#todo 
				if date > deadline
					result = 0
					break	
				elsif response != test[1]
					result = 0
					break
				end
			end
			dataForFile.push([row[1], row[2], row[3], row[4], result])
			puts result == 1 ? "#{row[3]} #{row[4]}: #{result}".green : "#{row[3]} #{row[4]}: #{result}".red
		end
		counter -= 1
		#puts counter
		if counter == 0
			dataForFile.sort_by! {|row| [row[0].to_s, row[1].to_i] }
			#puts dataForFile
			puts "writing to file"
			open(resultFilePath, 'w') { |f|
				f.puts "Клас,Номер,Име,Фамилия,Резултат"
	  			dataForFile.each do |row|
	  				puts "#{row[0]},#{row[1]},#{row[2]},#{row[3]},#{row[4]}"
					f.puts "#{row[0]},#{row[1]},#{row[2]},#{row[3]},#{row[4]}"					
				end
			}
			exit
		end
	end 
end
sleep