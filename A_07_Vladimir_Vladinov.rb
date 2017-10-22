require 'csv'

apps = Array.new
classNum = Array.new
grades = Array.new
csv_file = ARGV[0]
fixture = ARGV[1]

arr_of_arrs = CSV.read(csv_file)

answersF = Array.new
ans_file = CSV.read(fixture)
answersF = ans_file[0]

arr_of_arrs.each do |person|
	if(person[5] == nil || person[6] == nil)
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
		
		s  = s +  ", " + person[2] + ", " + person[3] + " " + person[4]
		classNum.push(s);
	end
end

classNum.shift
apps.shift

apps.each do |app|
	if app == "FAIL"
		grades.push(0)
		next
	end
	oneF = `curl --form "file=@./#{fixture}" #{appp}/sums`.to_s
	twoF = `curl --form "file=@./#{fixture}" #{appp}/filters`.to_s
	threeF = `curl --form "file=@./#{fixture}" #{appp}/intervals`.to_s
	fourF = `curl --form "file=@./#{fixture}" #{appp}/lin_regressions`.to_s

	if(oneF == answersF[0].to_s and twoF == answersF[1].to_s and three == answersF[2].to_s and four == answersF[3].to_s and app != "FAIL")
		grades.push(1)
		puts 1
	else
		puts 0
		grades.push(0)
	end
	puts answersF.to_s
end

grades.length.times do |i|
	puts classNum[i].to_s + ", " + grades[i].to_s
end
