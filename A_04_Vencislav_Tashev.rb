require 'csv'
require 'time'

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

  def pink
    colorize(35)
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

FILE_PATH = './A_04_Vencislav_Tashev.csv'
INITIAL_CURL_REQUEST = "curl -s --form \"file=@#{FILE_PATH}\" -m 10000"

TEST_CASES = [
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

def is_heroku_url?(url_string)
  url_string.end_with?('herokuapp.com/')
end

def is_on_time?(current_date, max_date)
  current_date <= max_date
end

def get_user_representation(user_info_hash)
  user_class = user_info_hash[1].strip.upcase
  user_number = user_info_hash[2]
  user_full_name = "#{user_info_hash[3].strip} #{user_info_hash[4].strip}"

  "#{user_full_name} (#{user_class}, #{user_number})"
end

def get_test_actual(url_string, action)
  `#{INITIAL_CURL_REQUEST} #{url_string + action}`.to_s
end

def get_test_status(passed, test_action)
  status_text = "Test on \"#{test_action}\""

  if passed
    status_text << ' passed'
    status_text.good
  else
    status_text << ' failed'
    status_text.bad
  end
end

date_format = '%d/%m/%Y %H:%M:%S'
deadline = DateTime.strptime '10/10/2017 23:59:59', date_format

CSV.foreach(ARGV[0], headers: true) do |row|
  url_string = row[5]

  unless url_string.nil?
    user_date = DateTime.strptime row[0], date_format
    user_info = get_user_representation row

    if is_on_time? user_date, deadline
      url_string = url_string.strip
      url_string << '/' unless url_string.end_with?('/')

      if is_heroku_url? url_string
        puts "Testing #{user_info}:".yellow
        puts "\tSubmission time: #{user_date.strftime date_format}"
        grade = 0

        TEST_CASES.each do |test|
          test[:actual] = get_test_actual url_string, test[:action]

          passed = test[:expected] == test[:actual]
          grade = passed ? 1 : 0
          current_test_status = get_test_status passed, test[:action]

          puts "\t#{current_test_status}"
        end

        puts "\n\tTotal grade: #{grade}".light_blue
        puts '-' * 45
      end
    else
      puts "#{user_info} is late.".pink
    end
  end
end
