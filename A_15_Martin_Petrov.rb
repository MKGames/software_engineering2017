require 'csv'

SUMS_ANSWER = '1830.00'
FILTERS_ANSWER = '896.00'
INTERVALS_ANSWER = '1365.00'
LIN_REGRESSIONS_ANSWER = '1.000000,0.000000'

heroku = []
class_num = []
csv_file = ARGV[0]
grade = []
finalche = Hash.new

arrays = CSV.read(csv_file)

arrays.each do |each|
  if(each[0][0...2] > "10" || each[5] = nil || each[6] = nil)
      each[5] = "POD SEKVA"

  elsif(each[1] == nil)
      next
    else
      heroku.push(each[5].to_s)
      st = "11"
      paralelka = each[1][-1]
      if(paralelka == "B" or paralelka == "b" or paralelka == "б" or paralelka == "Б")
          st += "B"
      elsif(paralelka == "a" or paralelka == "A" or paralelka == "А" or paralelka == "а")
      st += "A"
    end
    st = st + " " + each[2].to_s
    class_num.push(st)
  end
end

class_num.shift
heroku.shift

heroku.each do |app|
  curl_to_first = `curl --form "file=@./A_15_Martin_Petrov.csv" #{app}/sums`.to_s
  curl_to_second = `curl --form "file=@./A_15_Martin_Petrov.csv" #{app}/filters`.to_s
  curl_to_third = `curl --form "file=@./A_15_Martin_Petrov.csv" #{app}/intervals`.to_s
  curl_to_fourth = `curl --form "file=@./A_15_Martin_Petrov.csv" #{app}/lin_regressions`.to_s

  if(curl_to_first == SUMS_ANSWER and curl_to_second == FILTERS_ANSWER and curl_to_third == INTERVALS_ANSWER and curl_to_fourth == LIN_REGRESSIONS_ANSWER and heroku != "POD SEKVA")
    grade.push(1)
  else
    grade.push(0)
  end
end
grade.length.times do |i|
  finalche[class_num[i]] = grade[i]
end

p finalche
