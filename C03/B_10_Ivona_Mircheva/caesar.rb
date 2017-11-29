require_relative "lib/caesar_cipher"

message = gets

cipher = CaesarCipher.new()
puts cipher.encrypt(message)
