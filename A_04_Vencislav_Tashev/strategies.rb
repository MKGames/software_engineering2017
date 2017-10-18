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
end

class BaseStrategy
  def initialize(tests, students)
    raise 'Tests should be in array' unless tests.is_a?(Array)
    raise 'Students should be in array' unless students.is_a?(Array)

    @tests = tests
    @students = students
  end

  def get_grade
    total_tests = @tests.size
    passed_tests = @tests.select(&:passed).size

    total_tests == passed_tests ? 1 : 0
  end

  def sorted_students
    @students.sort_by { |s| [s.clazz, s.number] }
  end

  def represent_results
    raise NotImplementedError
  end
end

class CSVStrategy < BaseStrategy
  def represent_results
    # TODO: Threads

    self.sorted_students.each.with_index do |student, index|
      if student.on_time?
        @tests.each do |test|
          test.run student.url_string
        end

        puts "#{student} - #{self.get_grade}"
      else
        puts "#{student} - 0 (late)"
      end
    end
  end
end

class PrettyStrategy < BaseStrategy
  @@delimiter = '-' * 45

  def get_grade_representation
    "Total grade: #{self.get_grade}".light_blue
  end

  def represent_results
    self.sorted_students.each do |student|
      puts "Testing #{student}:".yellow

      if student.on_time?
        puts "\tSubmission time: #{student.timestamp}\n\n"

        @tests.each do |test|
          test.run student.url_string
          puts "\t#{test.status_text}"
        end

        puts "\n\t#{self.get_grade_representation}"
      else
        puts "\tSubmission delayed with #{student.delay} secs.".red
        puts "\tNo tests runned".red
      end

      puts @@delimiter
    end
  end
end
