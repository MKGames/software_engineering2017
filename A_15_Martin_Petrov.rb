require 'csv'

#SUMS_ANSWER = "1697.00"
#FILTERS_ANSWER = "1276.00"
#INTERVALS_ANSWER = "831.00"
#LINREGRESSIONS_ANSWER = "1.100577,1.138961"

apps = []
classNum = []
grades = []
csv_file = ARGV[0]
file = ARGV[1]

sums = 0
filters = 0
intervals = 0
lin_regressions = 0

check = true
CSV.foreach(fixture) do |row|
    if check == 0
        sums = row[0].to_s
        filters = row[1].to_s
        intervals = row[2].to_s
        lin_regressions = row[3].to_s
        check = false
        next
    end
end

arr_of_arrs = CSV.read(csv_file)

arr_of_arrs.each do |person|
	if(person[5] == nil || person[6] == nil || person[0][0...2] > "10")
		person[5] = "POD SEKVA"
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
		s = s + " " + person[2].to_s
		classNum.push(s)
	end
end

classNum.shift
apps.shift

apps.each do |app|
	one = `curl --form "file=@./A_15_Martin_Petrov.csv" #{app}/sums`.to_s
	two = `curl --form "file=@./A_15_Martin_Petrov.csv" #{app}/filters`.to_s
	three = `curl --form "file=@./A_15_Martin_Petrov.csv" #{app}/intervals`.to_s
	four = `curl --form "file=@./A_15_Martin_Petrov.csv" #{app}/lin_regressions`.to_s
	if(one == sums and two == filters and three == intervals and four == lin_regressions and app != "POD SEKVA")
		grades.push(1)
	else
		grades.push(0)
	end
end
