require './utils'

class String
  def good
    "#{"\u2713".encode('utf-8')} #{self.green}"
  end

  def bad
    "#{"\u2613".encode('utf-8')} #{self.red}"
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
    self.actual_result = `#{Constants::INITIAL_CURL_REQUEST} #{url}`.to_s
    self.passed = self.expected_result == self.actual_result
  end
end
