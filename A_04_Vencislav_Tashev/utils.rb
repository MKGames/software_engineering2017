module Constants
  extn = File.extname $0
  FILENAME = File.basename $0, extn

  INPUT_FILE = "./#{FILENAME}.csv"
  OUTPUT_FILE = "./#{FILENAME}_results.csv"

  TIMEOUT_SECONDS = 15
  INITIAL_CURL_REQUEST = "curl -s --form \"file=@#{INPUT_FILE}\" -m #{TIMEOUT_SECONDS}"
end
