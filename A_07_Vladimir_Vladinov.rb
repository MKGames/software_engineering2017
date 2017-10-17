require 'csv'

SUMS_ANSWER = "903.0"
FILTERS_ANSWER = "425.0"
INTERVALS_ANSWER = "825.0"
LINREGRESSIONS_ANSWER = "1.0, 0.0"

apps = []
classNum = []
grades = []
csv_file = ARGV[0]
final = Hash.new

arr_of_arrs = CSV.read(csv_file)

arr_of_arrs.each do |person|
	if(person[5] == nil || person[6] == nil || person[0][0...2] > "10")
		person[5] = "FAIL"
	elsif(person[1] == nil)
		next
	else
		apps.push(person[5].to_s)
		s = "11"
		klas = person[1][-1]
		if(klas == "a" or klas == "А"  or klas == "A" or klas == "a")
			s += "A"
		elsif(klas == "б" or klas == "Б"  or klas == "B" or klas == "b")
			s += "B"
		end
		s = s + " - " + person[2].to_s
		classNum.push(s)
	end
end

classNum.shift
apps.shift

apps.each do |app|
	one = `curl --form "file=@./A_07_Vladimir_Vladinov.csv" #{app}/sums`.to_s
	two = `curl --form "file=@./A_07_Vladimir_Vladinov.csv" #{app}/filters`.to_s
	three = `curl --form "file=@./A_07_Vladimir_Vladinov.csv" #{app}/intervals`.to_s
	four = `curl --form "file=@./A_07_Vladimir_Vladinov.csv" #{app}/lin_regressions`.to_s
	if(one == SUMS_ANSWER and two == FILTERS_ANSWER and three == INTERVALS_ANSWER and four == LINREGRESSIONS_ANSWER and app != "FAIL")
		grades.push(1)
	else
		grades.push(0)
	end
end

grades.length.times do |i|
	final[classNum[i]] = grades[i]
end

p final
