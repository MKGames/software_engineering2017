require './utils'

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
  def represent_results
    puts '... Calculating results ...'.yellow

    output_file = Constants::OUTPUT_FILE
    CSV.open(output_file, 'wb') do |csv|
      csv << ['Клас', 'Номер', 'Име', 'Резултат']

      @students.each do |student|
        if student.on_time?
          @tests.each do |test|
            test.run student.url_string
          end

          grade = self.get_grade
        else
          grade = "0 (Delayed with #{student.delay} seconds)"
        end

        csv << [student.clazz, student.number, student.full_name, grade]
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
