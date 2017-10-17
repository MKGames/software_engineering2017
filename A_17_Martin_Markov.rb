require 'csv'
require 'uri'

csv_file_path = './A_17_Martin_Markov.csv'
hws_file_path = ARGV[0]

CSV.foreach(hws_file_path) do |row|
  print "#{row[1]} ##{row[2]} #{row[3]} #{row[4]} "
  begin
    row[5].strip!
    heroku_url = URI(row[5]).host
  rescue
    print "Invalid URL ->#{row[5]}\n"
    next
  end
  print `curl -s -F "file=@A_17_Martin_Markov.csv" #{heroku_url}/sums` == '1275.00' &&
        `curl -s -F "file=@A_17_Martin_Markov.csv" #{heroku_url}/filters` == '625.00' &&
        `curl -s -F "file=@A_17_Martin_Markov.csv" #{heroku_url}/intervals` == '1065.00' &&
        `curl -s -F "file=@A_17_Martin_Markov.csv" #{heroku_url}/lin_regressions` == '1.000000,0.000000' ? 1 : 0
  print "\n"
end
