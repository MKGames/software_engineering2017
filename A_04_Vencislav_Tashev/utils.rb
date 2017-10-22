module Constants
  extn = File.extname $0
  FILENAME = File.basename $0, extn

  INPUT_FILE = "./#{FILENAME}.csv"
  OUTPUT_FILE = "./#{FILENAME}_results.csv"

  TIMEOUT_SECONDS = 15
  INITIAL_CURL_REQUEST = "curl -s --form \"file=@#{INPUT_FILE}\" -m #{TIMEOUT_SECONDS}"
end

module Colors
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
