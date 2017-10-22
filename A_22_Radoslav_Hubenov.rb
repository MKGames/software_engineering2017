    require 'csv'

    data = ARGV[0]

    task01_answer = "10210.00"
    task02_answer = "4604.00"
    task03_answer = "1872.00"
    task04_answer = "0.047745,46.251658"

    result = 0

    CSV.foreach(data) do |row|

        url = row[5]

        task01 = `curl -s -F "csv_file = @./A_22_Radoslav_Hubenov.csv" #{url}/sums`.to_s
        task02 = `curl -s -F "csv_file = @./A_22_Radoslav_Hubenov.csv" #{url}/filters`.to_s
        task03 = `curl -s -F "csv_file = @./A_22_Radoslav_Hubenov.csv" #{url}/intervals`.to_s
        task04 = `curl -s -F "csv_file = @./A_22_Radoslav_Hubenov.csv" #{url}/lin_regressions`.to_s

        if task01 == task01_answer && task02 == task02_answer && task03 == task03_answer && task04 == task04_answer
            result = 1
        end

            url_name = row[3]
            url_second = row[4]
            puts url_name
            puts url_second
            puts result

    end

