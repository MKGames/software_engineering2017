require 'csv' ###

doc = ARGV[0]

CSV.foreach(doc) do |row|
  hurl = row[5]

  if(row[1] != nil)

    if( `curl -s -F "file=@./B_10_Ivona_Mircheva.csv" #{hurl}/sums` == "112.00" && `curl -s -F "file=@B_10_Ivona_Mircheva.csv" #{hurl}/filters` == "38.00" && `curl -s -F "file=@B_10_Ivona_Mircheva.csv" #{hurl}/intervals` == "110.00" && `curl -s -F "file=@B_10_Ivona_Mircheva.csv" #{hurl}/lin_regressions` == "0.018328,3.197581")
      puts row[1] + ',' + row[2] + ',' + row[3] + ' ' + row[4] + ',1';
    else
      puts row[1] + ',' + row[2] + ',' + row[3] + ' ' + row[4] + ',0';
    end
  end
end

