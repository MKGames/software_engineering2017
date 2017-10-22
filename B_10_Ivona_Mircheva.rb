

require 'csv' ###

kids_for_sale = ARGV[0]
check_them_all = CSV.read(ARGV[1])

sums_out = check_them_all[0][0]
filters_out = check_them_all[0][1]
intervals_out = check_them_all[0][2]
lin_regressions_out = check_them_all[0][3]

CSV.foreach(kids_for_sale) do |row|
  heroku_url = row[5]

  # CSV.open("./B_10_Ivona_Mircheva_results.csv", "a+") do |csv|
  if(row[5] != nil)

     if( `curl -s -F "file=@./B_21_Roberta_Netzova.csv" #{heroku_url}/sums` == sums_out &&
      `curl -s -F "file=@./B_21_Roberta_Netzova.csv" #{heroku_url}/filters` == filters_out &&
      `curl -s -F "file=@./B_21_Roberta_Netzova.csv" #{heroku_url}/intervals` == intervals_out &&
      `curl -s -F "file=@./B_21_Roberta_Netzova.csv" #{heroku_url}/lin_regressions` == lin_regressions_out)
     kid = String.new("#{row[1].strip},#{row[2].strip},#{row[3].strip},#{row[4].strip},1")
     puts kid
       # csv.puts kid
     else
      kid = row[1].strip + ',' + row[2].strip + ',' + row[3].strip + ',' + row[4].strip + ',0'
      puts kid
        # csv.puts kid
      end
    end
  # end
end
