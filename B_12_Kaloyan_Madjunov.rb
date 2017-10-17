require 'csv'

class Student
  def initialize(cl, num, name, res)
      @class_, @number_, @name_, @result = cl, num, name, res
  end

  def print()
    puts @class_ + "," + @number_ + "," + @name_ + "," + @result.to_s 
  end
end

file = ARGV[0]

students = []

CSV.foreach(file, headers: true, skip_blanks: true) do |row|
  next if row[3] == nil

  time_finished = DateTime.strptime(row[0], '%d/%m/%Y %H:%M:%S')
  deadline = DateTime.new(2017,10,10,23,59,59)

  if time_finished > deadline
    print "Time is out for "
  end

  school_class = row[1].strip

  if school_class.include?("Б") || school_class.include?("б") || school_class.include?("B") || school_class.include?("b")
    school_class = "B"
  elsif school_class.include?("А") || school_class.include?("а") || school_class.include?("A") || school_class.include?("a") #Bulgarian letters
    school_class = "A"
  end

  number_in_class = row[2].strip

  student_name = row[3].strip + " " + row[4].strip

  heroku_url = row[5]

  if heroku_url == nil
    result = 0
  else
    if !heroku_url.end_with?("/")
      heroku_url = heroku_url + "/"
    end

    result = `curl -F "file=@B_12_Kaloyan_Madjunov.csv" #{heroku_url}sums 2>/dev/null` == "55.00" &&
	           `curl -F "file=@B_12_Kaloyan_Madjunov.csv" #{heroku_url}filters 2>/dev/null` == "0.00" &&
	           `curl -F "file=@B_12_Kaloyan_Madjunov.csv" #{heroku_url}intervals 2>/dev/null` == "55.00" &&
	           `curl -F "file=@B_12_Kaloyan_Madjunov.csv" #{heroku_url}lin_regressions 2>/dev/null` == "1.000000,0.000000" ? 1 : 0
  end

  student = Student.new(school_class, number_in_class, student_name, result)

  student.print()

  #students.push(student)
end
