module Constants
  TEST_DATA = './A_04_Vencislav_Tashev.csv'
  TIMEOUT_SECONDS = 15
  INITIAL_CURL_REQUEST = "curl -s --form \"file=@#{TEST_DATA}\" -m #{TIMEOUT_SECONDS}"
end
