require 'CSV' 

klas, *nomer = ARGV

CSV.foreach do |line|
	if(row[1] == klas && row[2] == nomer)
		heroku_url = row[5]
	end

end
