require('csv')
require('time')

# this is in accordance to my file
# NOTE change this -- put answers at the top?
$correct_answers = ['5148.00', '2607.00', '1819.00', '-0.072535,55.143030']
$TIMEOUT = 30
# $all_answers = []

def get_time(time_str)
  DateTime.strptime(time_str, '%d/%m/%Y %H:%M:%S')
end

# there must be something built in for these
class String
  def blank?
    self.nil? || self.empty?
  end
end

class NilClass
  def blank?
    self.nil?
  end
end

class Student
  @@paths = ['sums/', 'filters/', 'intervals/', 'lin_regressions/']
  @@last_date = get_time('10/10/2017 23:59:59')
  def initialize(info)
    @timestamp = get_time(info[0])

    @info = info[1..4]
    @url = info[-2]
    @github = info[-1]
    @status = ''
  end
  attr_reader :info

  def validate
    if ARGV[2] == 'late'
      return 'too_late' if @timestamp > @@last_date
    end
    return 'wrong_info' if @info.any?(&:blank?)

    # validate homework urls
    return 'bad_links' if @url.blank? || @github.blank?
    if @url[-1] != '/'
      @url.strip!
      @url << ('/')
    end

    answers = []
    @@paths.each do |path|
      result = `curl -s -F "file=@#{ARGV[1]}" #{@url}#{path} -m #{$TIMEOUT}`
      answers << result
    end
    # $all_answers << answers
    # print answers, $correct_answers
    if answers == $correct_answers then 'correct' else 'bad_answers' end
  end
end

# ARGV[1] is the test file
file = CSV.open(ARGV[0], 'r')
# CSV.foreach(ARGV[0], headers: true)
# get header of the file, where correct dtaa shoudl be located

# it would be more efficient to have a queue and like 10 threads going through
# them but for ~100 iterations i don't care
threads = []
answers = []

file.drop(1).each_with_index do |line, index|
  threads << Thread.new(index) do
    student = Student.new(line)
    answers << [student.info, student.validate]
  end
end

threads.each do |t|
  t.join
end

# print(answers)
CSV.open("A_03_Boian_Karatotev_results.csv", "wb") do |csv|
  answers.each do |user, score|
    if !user[0].blank?
      csv << user.push(if score == 'correct' then 1 else 0 end)
    end
  end
end
