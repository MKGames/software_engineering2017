require './utils'

class TestCase
  attr_accessor :actual_result, :passed
  attr_reader :action, :expected_result

  def initialize(action, expected_result)
    @action = action
    @expected_result = expected_result
    @actual_result = nil
    @passed = false
  end

  def run(url_string)
    url = url_string + self.action
    self.actual_result = `#{Constants::INITIAL_CURL_REQUEST} #{url}`.to_s
    self.passed = self.expected_result == self.actual_result
  end
end
