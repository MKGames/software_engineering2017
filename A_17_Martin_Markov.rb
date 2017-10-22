require 'csv'
require 'uri'

csv_file_path = './A_17_Martin_Markov.csv'
hws_file_path = ARGV[0]
fixture_file_path = ARGV[1]

results = []

CSV.foreach(fixture_file_path) do |row|
  results = row
end

CSV.foreach(hws_file_path) do |row|
  result = "#{row[1]},#{row[2]},#{row[3]},#{row[4]},"
  begin
    row[5].strip!
    heroku_url = URI(row[5]).host
  rescue
    print "Invalid URL\n"
    next
  end
  result += `curl -s -F "file=@A_17_Martin_Markov.csv" #{heroku_url}/sums` == results[0] &&
            `curl -s -F "file=@A_17_Martin_Markov.csv" #{heroku_url}/filters` == results[1] &&
            `curl -s -F "file=@A_17_Martin_Markov.csv" #{heroku_url}/intervals` == results[2] &&
            `curl -s -F "file=@A_17_Martin_Markov.csv" #{heroku_url}/lin_regressions` == results[3] ? "1" : "0"
  print "#{result}\n"
end
