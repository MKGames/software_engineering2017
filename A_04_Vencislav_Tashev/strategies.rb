require './utils'

class String
  include Colors
end

class BaseStrategy
  def initialize(tests, students)
    raise 'Tests should be an array.' unless tests.is_a?(Array)
    raise 'Students should be an array.' unless students.is_a?(Array)

    @tests = tests
    @students = students.sort_by { |s| [s.clazz, s.number] }
  end

  def get_grade
    total_tests = @tests.size
    passed_tests = @tests.select(&:passed).size

    total_tests == passed_tests ? 1 : 0
  end

  def represent_results
    raise NotImplementedError
  end
end

class CSVStrategy < BaseStrategy
  def print_status(ready, all)
    print "#{'x' * ready}".light_blue
    print '-' * (all - ready)
    print " #{ready}/#{all}".light_blue
    print "\r"
  end

  def get_results_as_csv
    results = []

    @students.each.with_index do |student, index|
      if student.on_time?
        @tests.each do |test|
          test.run student.url_string
        end

        grade = self.get_grade
      else
        grade = "0 (Delayed with #{student.delay} seconds)"
      end

      results << [student.clazz, student.number, student.full_name, grade]
      self.print_status index + 1, @students.size
    end

    results
  end

  def represent_results
    puts '... Calculating results ...'.yellow
    results = self.get_results_as_csv

    output_file = Constants::OUTPUT_FILE
    CSV.open(output_file, 'wb') do |csv|
      csv << ['Клас', 'Номер', 'Име', 'Резултат']

      results.each do |result_list|
        csv << result_list
      end
    end

    puts "Results written in #{output_file}".green
  end
end

class PrettyStrategy < BaseStrategy
  @@delimiter = '-' * 45

  def grade_representation
    "Total grade: #{self.get_grade}".light_blue
  end

  def test_status_text(test)
    status_text = "Test on \"#{test.action}\""

    if test.passed
      status_text << ' passed'
      status_text.good
    else
      status_text << ' failed'
      status_text.bad
    end
  end

  def represent_results
    @students.each do |student|
      puts "Testing #{student}:".yellow

      if student.on_time?
        puts "\tSubmission time: #{student.timestamp}\n\n"

        @tests.each do |test|
          test.run student.url_string
          puts "\t#{self.test_status_text test}"
        end

        puts "\n\t#{self.grade_representation}"
      else
        puts "\tSubmission delayed with #{student.delay} secs.".red
        puts "\tNo tests runned".red
      end

      puts @@delimiter
    end
  end
end
