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

TestCsvPath = "./B_26_Telerik_Arsov.csv"
Timeout = 10

tests = [
	["/sums", "11.00"], 
	["/intervals", "11.00"], 
	["/filters", "8.00"],
	["/lin_regressions", "1.100000,0.000000"]
]
counter = 0

csv = File.read(ARGV[0])
csv_file = CSV.parse(csv, :headers => true)
csv_file.each do |row|
	counter += 1
	Thread.new do
		result = 1;
		unless row[3].nil? && row[4].nil? && row[5].nil?
			hUrl = row[5]
			curl = "curl --form \"file=@#{TestCsvPath}\" #{hUrl}"
			tests.each do |test|
				#p "#{curl}#{test[0]}"
				response = `#{curl}#{test[0]} 2>/dev/null -m #{Timeout}`
				#puts response
				#todo 
				if response != test[1]
					result = 0
					break
				end
			end
			puts result == 1 ? "#{row[3]} #{row[4]}: #{result}".green : "#{row[3]} #{row[4]}: #{result}".red
		end
		counter -= 1
		#puts counter
		if counter == 0
			exit
		end
	end 
end
sleep