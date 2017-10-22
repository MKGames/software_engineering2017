    require 'csv'

    data = ARGV[0]

    fixture_path = ARGV[1]

    values = []
    
    CSV.foreach(fixture_path) do |row|
        values = row
    end


    result = 0

    CSV.foreach(data) do |row|
        
        url = row[5]

        task01 = `curl -s -F "file=@./A_22_Radoslav_Hubenov.csv" #{url}/sums`
        task02 = `curl -s -F "file=@./A_22_Radoslav_Hubenov.csv" #{url}/filters`
        task03 = `curl -s -F "file=@./A_22_Radoslav_Hubenov.csv" #{url}/intervals`
        task04 = `curl -s -F "file=@./A_22_Radoslav_Hubenov.csv" #{url}/lin_regressions`

        if task01 == values[0] && task02 == values[1] && task03 == values[2] && task04 == values[3]
            result = 1
        end
        puts "#{row[1]},#{row[2]},#{row[3]},#{row[4]},#{result}"
        result = 0
        
    end

