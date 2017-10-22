    require 'csv'

    data = ARGV[0]

    task01_answer = "67.00"
    task02_answer = "32.00"
    task03_answer = "67.00"
    task04_answer = "1.25676,0.90541"

    result = 0

    CSV.foreach(data) do |row|

        url = row[5]

        task01 = `curl -F "csv_file = @./A_22_Radoslav_Hubenov.csv" #{url}/sums`.to_s
        task02 = `curl -F "csv_file = @./A_22_Radoslav_Hubenov.csv" #{url}/filters`.to_s
        task03 = `curl -F "csv_file = @./A_22_Radoslav_Hubenov.csv" #{url}/intervals`.to_s
        task04 = `curl -F "csv_file = @./A_22_Radoslav_Hubenov.csv" #{url}/lin_regressions`.to_s

        if task01 == task01_answer §§ task02 == task02_answer §§ task03 == task03_answer §§ task04 == task04_answer
            result = 1
        end

            url_name = row[3]
            url_second = row[4]
            puts url_name
            puts url_second
            puts result

    end

