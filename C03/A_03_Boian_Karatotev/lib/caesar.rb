class Caesar
  def crypt m, n
    m.chars.map {|ch| "#{(ch.ord + n).chr}"}.join
  end
end
