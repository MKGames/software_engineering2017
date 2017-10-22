require 'csv'

class Student
  attr_accessor :class, :number, :fname, :lname, :result

  def initialize(cl, num, fname, lname, res)
    @class, @number, @fname, @lname, @result = cl, num, fname, lname, res
  end

  def print
    puts @class + "," + @number + "," + @fname + "," + @lname + "," + @result
  end
end

students_file = ARGV[0]
data_file = CSV.read(ARGV[1])

result1 = data_file[0][0]
result2 = data_file[0][1]
result3 = data_file[0][2]
result4 = data_file[0][3]

students = []

current_row = 0

file_length = CSV.read(students_file).drop(1).length

results_file='./B_12_Kaloyan_Madjunov_results.csv'

CSV.foreach(students_file, headers: true, skip_blanks: true) do |row|
  Thread.new do
    if row[3] == nil
      file_length -= 1
      next
    end

#Option: See which students are late
=begin
    time_finished = DateTime.strptime(row[0], '%d/%m/%Y %H:%M:%S')
    deadline = DateTime.new(2017,10,10,23,59,59)

    result = ""

    if time_finished > deadline
      result += "Too late "
    end
=end

    school_class = row[1].strip

    if school_class.include?("Б") || school_class.include?("б") || school_class.include?("B") || school_class.include?("b")
      school_class = "B"
    elsif school_class.include?("А") || school_class.include?("а") || school_class.include?("A") || school_class.include?("a") #Bulgarian letters
      school_class = "A"
    end

    number_in_class = row[2].strip

    student_first_name = row[3].strip

    student_last_name = row[4].strip

    heroku_url = row[5]

    if heroku_url == nil
      result = "0"
    else
      if !heroku_url.end_with?("/")
        heroku_url = heroku_url.strip + "/"
      end

      sum_res = `curl -F "file=@B_12_Kaloyan_Madjunov.csv" #{heroku_url}sums 2>/dev/null`
      filters_res = `curl -F "file=@B_12_Kaloyan_Madjunov.csv" #{heroku_url}filters 2>/dev/null`
      intervals_res = `curl -F "file=@B_12_Kaloyan_Madjunov.csv" #{heroku_url}intervals 2>/dev/null`
      lin_reg_res = `curl -F "file=@B_12_Kaloyan_Madjunov.csv" #{heroku_url}lin_regressions 2>/dev/null`

      if sum_res == result1 && filters_res == result2 && intervals_res == result3 && lin_reg_res == result4
        result = "1"
      else
        result = "0"
      end
    end

    student = Student.new(school_class, number_in_class, student_first_name, student_last_name, result)
    students.push(student)

    current_row += 1

    if current_row == file_length
      students.sort_by! { |s| [s.class.to_s, s.number.to_i] }

      open(results_file, 'w') { |file|
        file.puts "Class,Number,First name,Last name,Result"

        students.each do |s|
          file.puts "#{s.class},#{s.number},#{s.fname},#{s.lname},#{s.result}"
          s.print
        end
      }

      exit
    end
  end
end
sleep
