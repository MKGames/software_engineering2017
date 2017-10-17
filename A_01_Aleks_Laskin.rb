require 'csv'

i = 0


CSV.foreach(ARGV[0]) do |row|
  
  grade = 0

  student_url = row[5]
  student_group = row[1]
  student_number = row [2]
  student_fname = row[3]
  student_sname = row[4]


    unless student_url.nil?
      
      student_url << '/' unless student_url.end_with?('/')
      check_1 = `curl -s -F \"file=@./A_01_Aleks_Laskin.csv\" #{student_url}sums`
      check_2 = `curl -s -F \"file=@./A_01_Aleks_Laskin.csv\" #{student_url}filters`
      check_3 = `curl -s -F \"file=@./A_01_Aleks_Laskin.csv\" #{student_url}intervals`
      check_4 = `curl -s -F \"file=@./A_01_Aleks_Laskin.csv\" #{student_url}lin_regressions`

      if check_1 == "256.00" && check_2 == "128.00" && check_3 == "255.00" && check_4 == "0.225806,4.645161"
        grade = 1
      end
      
        if i > 0
          puts "#{student_group}_#{student_number}_#{student_fname}_#{student_sname} Grade = #{grade}\n"
        end
        
        i = 1
        
    end

end
