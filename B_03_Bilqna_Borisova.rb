require 'csv'

class Student
  def initialize(cl, num, f, l, res)
      @class_, @number_, @first_, @last_, @result = cl, num, f, l, res
  end

  def print()
    puts @class_ + "," + @number_ + "," + @first_ + "," + @last_ + "," + @result.to_s 
  end
end

file=ARGV[0]
results = CSV.read(ARGV[1])

students = []

r1 = results[0][0]
r2 = results[0][1]
r3 = results[0][2]
r4 = results[0][3]

CSV.foreach(file, :headers => true) do |row|
  next if row[3] == nil && row[4] == nil 
  Thread.new do

  #finished_time = DateTime.strptime(row[0], '%d/%m/%Y %H:%M:%S')
  #deadline = DateTime.new(2017,10,10,23,59,59)
 

  #if finished_time > deadline
  #print "Time out:  "
  #end 

  #DeadLine = DateTime.parse(row[0], "10/10/2017 23:59:59");

  school_class = row[1].strip

 # if school_class.include?("A")
  #  school_class = "A"
  #elsif school_class.include?("B")
   # school_class = "B"
  #end

  number_in_class = row[2].strip

  student_first = row[3].strip 

  student_last = row[4].strip

  hurl = row[5]
  heroku_url = row[5]

  if heroku_url == nil
    result = 0
  else
    if !heroku_url.end_with?("/")
      heroku_url = heroku_url.strip + "/"
    end

    result = `curl -F "file=@B_21_Roberta_Netzova.csv" #{heroku_url}sums 2>/dev/null` == r1 && 
         `curl -F "file=@B_21_Roberta_Netzova.csv" #{heroku_url}filters 2>/dev/null` == r2 &&
         `curl -F "file=@B_21_Roberta_Netzova.csv" #{heroku_url}intervals 2>/dev/null` == r3 && 
         `curl -F "file=@B_21_Roberta_Netzova.csv" #{heroku_url}lin_regressions 2>/dev/null` == r4 ? 1 : 0
  end

  student = Student.new(school_class, number_in_class, student_first, student_last, result)

  student.print()

 end
end
sleep
