require 'csv'
require 'time'

Tests = [
    {
        filePath: ARGV[1],
        requests:[
            {
                url: "/sums",
                response: "126.00"
            },
            {
                url: "/intervals",
                response: "118.00"
            },
            {
                url: "/filters",
                response: "40.00"
            },
            {
                url: "/lin_regressions",
                response: "0.014006,3.347899"
            }
        ]
    }
]

DeadLine = DateTime.parse("10/10/2017 23:59:59");

csv_text = File.read(ARGV[0])
csv = CSV.parse(csv_text, :headers => true)

students = [];

csv.each do |row|
    unless row[2].nil? && row[3].nil? && row[4].nil?
        late = ((DateTime.parse(row[0]) - DeadLine)* 24 * 60 * 60).to_i;
        students.push({
            late: late > 0 ? "(#{late} seconds late)" : "",
            klas: row[1] =~ /[bBбБ]/ ? "B" : ( row[1] =~ /[aAаА]/ ? "A" : "?"),    
            number: row[2],            
            name: row[3].to_s + "," + row[4].to_s,
            hurl: row[5],
            done: false
        })
    end
end

ReqMaxTime = 15;

Thread.abort_on_exception=true
students.each do |s|
    Thread.new do
        result = "1"
        Tests.each do |test| 
            test[:requests].each do |req|
                res = `curl --form \"file=@#{test[:filePath]}\" #{s[:hurl]}#{req[:url]} 2>/dev/null -m #{ReqMaxTime}`;
                if(res != req[:response])
                    result = "0";
                    break;
                end
            end
        end
        s[:done] = true;
        s[:row] = sprintf "%s,%02d,%s,%s\n", s[:klas], s[:number], s[:name], result
        if students.all? {|t| t[:done] }
            open("./B_17_Martin_Datsev_results.csv", 'w') { |f|
                students.sort_by! {|s| [s[:klas].to_s, s[:number].to_i] }
                students.each do |o|
                    f.puts o[:row]
                end
            }
            exit
        end
        printf students.select{|t| t[:done]}.size.to_s + "/" + students.size.to_s + "\r";
    end
end

sleep