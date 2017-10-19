require 'csv'
require 'optparse'

require './student'
require './test_case'
require './strategies'

if ARGV.size < 2
    puts "Usage: #{$0} <data.csv> <fixture.csv> [options]"
    exit
end

STUDENTS_DATA = ARGV[0]
FIXTURE_DATA = ARGV[1]
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

options = {}
OptionParser.new do |opts|
  opts.on('-p', '--pretty') do
    options[:pretty] = true
  end
end.parse!

def get_strategy(tests, students)
  strategy_class = options[:pretty] ? PrettyStrategy : CSVStrategy

  strategy_class.new tests, students
end

def generate_students(csv_file)
  students = []
  CSV.foreach(csv_file, headers: true) do |row|
    url_string = row[5]

    unless url_string.nil?
      url_string << '/' unless url_string.end_with?('/')

      if url_string.end_with?('herokuapp.com/')
        timestamp = row[0]
        clazz = row[1]
        number = row[2]
        first_name = row[3]
        last_name = row[4]

        students << Student.new(timestamp, clazz, number, first_name, last_name, url_string)
      end
    end
  end

  students
end

def generate_test_cases(tests_hash)
  test_cases = []
  tests_hash.each do |test_case|
    test_cases << TestCase.new(test_case[:action], test_case[:expected])
  end

  test_cases
end

# ------------------------------------------------------------------------------

test_cases = generate_test_cases TESTS
students = generate_students STUDENTS_DATA

strategy = get_strategy test_cases, students
strategy.represent_results
