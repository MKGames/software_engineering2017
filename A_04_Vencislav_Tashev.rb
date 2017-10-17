require 'csv'
require 'time'

STUDENTS_DATA = ARGV[0]
TEST_DATA = './A_04_Vencislav_Tashev.csv'
TIMEOUT_SECONDS = 15
INITIAL_CURL_REQUEST = "curl -s --form \"file=@#{TEST_DATA}\" -m #{TIMEOUT_SECONDS}"

TESTS = [
  {
    action: 'sums',
    expected: '51068.00'
  },
  {
    action: 'filters',
    expected: '24758.00'
  },
  {
    action: 'intervals',
    expected: '1930.00'
  },
  {
    action: 'lin_regressions',
    expected: '-0.000996,51.566565'
  }
]

DATE_FORMAT = '%d/%m/%Y %H:%M:%S'
DEADLINE = DateTime.strptime '10/10/2017 23:59:59', DATE_FORMAT
TEST_CASE_DELIMITER = '-' * 45

# ------------------------------------------------------------------------------

class String
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def light_blue
    colorize(36)
  end

  def good
    "#{"\u2713".encode('utf-8')} #{self.green}"
  end

  def bad
    "#{"\u2613".encode('utf-8')} #{self.red}"
  end

  def is_valid_heroku_url?
    self.end_with? 'herokuapp.com/'
  end
end

class DateTime
  def delay_in_seconds(timestamp)
    ((self - timestamp) * 24 * 60 * 60).to_i.abs
  end
end

# ------------------------------------------------------------------------------

class Student
  attr_reader :timestamp, :clazz, :number, :url_string

  def initialize(timestamp, clazz, number, first_name, last_name, url_string)
    @timestamp = DateTime.strptime timestamp, DATE_FORMAT
    @clazz = self.parse_clazz clazz
    @number = number.to_i
    @full_name = "#{first_name.strip} #{last_name.strip}"
    @url_string = url_string.strip
  end

  def parse_clazz(clazz)
    clazz.gsub!(' ', '')
    clazz.gsub!('10', '11')
    clazz.gsub!('XI', '11')
    clazz.gsub!(/[aAаА]/, 'A')
    clazz.gsub!(/[bBбБ]/, 'B')
    clazz.gsub!(/^A$/, '11A')
    clazz.gsub!(/^B$/, '11B')
    clazz
  end

  def on_time?
    @timestamp <= DEADLINE
  end

  def to_s
    "#{@full_name} (#{@clazz}, ##{@number})"
  end
end

class TestCase
  attr_accessor :actual_result, :passed
  attr_reader :action, :expected_result

  def initialize(action, expected_result)
    @action = action
    @expected_result = expected_result
    @actual_result = nil
    @passed = false
  end

  def status_text
    status_text = "Test on \"#{self.action}\""

    if passed
      status_text << ' passed'
      status_text.good
    else
      status_text << ' failed'
      status_text.bad
    end
  end

  def run(url_string)
    url = url_string + self.action
    self.actual_result = `#{INITIAL_CURL_REQUEST} #{url}`.to_s
    self.passed = self.expected_result == self.actual_result
  end
end

# ------------------------------------------------------------------------------

def generate_students(csv_file)
  students = []
  CSV.foreach(csv_file, headers: true) do |row|
    url_string = row[5]

    unless url_string.nil?
      url_string << '/' unless url_string.end_with?('/')

      if url_string.is_valid_heroku_url?
        timestamp = row[0]
        clazz = row[1]
        number = row[2]
        first_name = row[3]
        last_name = row[4]

        students.push Student.new timestamp, clazz, number, first_name, last_name, url_string
      end
    end
  end

  students
end

def generate_test_cases(tests_hash)
  test_cases = []
  tests_hash.each do |test_case|
    test_cases.push TestCase.new test_case[:action], test_case[:expected]
  end

  test_cases
end

def represent_grade(tests)
  total_tests = tests.size
  passed_tests = tests.select(&:passed).size

  grade = total_tests == passed_tests ? 1 : 0

  puts "\n\tTotal grade: #{grade} (#{passed_tests}/#{total_tests})".light_blue
end

# ------------------------------------------------------------------------------

students = generate_students STUDENTS_DATA
test_cases = generate_test_cases TESTS

students.sort_by { |s| [s.clazz, s.number] }.each do |student|
  puts "Testing #{student}:".yellow

  if student.on_time?
    puts "\tSubmission time: #{student.timestamp.strftime DATE_FORMAT}\n\n"

    test_cases.each do |test|
      test.run student.url_string
      puts "\t#{test.status_text}"
    end

    represent_grade test_cases
  else
    delay_in_seconds = DEADLINE.delay_in_seconds(student.timestamp)
    puts "\tSubmission delayed with #{delay_in_seconds} secs.".red
    puts "\tNo tests runned".red
  end

  puts TEST_CASE_DELIMITER
end
