class Caesar
  def crypt m, n
    n %= 26
    m.chars.map { |c| "#{(c.ord + n).chr}" }.join
    #"VWGU"
  end
end
