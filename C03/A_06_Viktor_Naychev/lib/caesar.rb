class Caesar
    def crypt(m, k)
        k = (k % 26)
        arr = Array.new
        m.each_char do |ch|
            if (ch =~ /[a-zA-Z]/) ==  nil
                    arr << ch
            elsif (ch.ord + k > "z".ord and (ch=~/[a-z]/) != nil) or (ch.ord + k > "Z".ord and (ch=~/[A-Z]/) != nil)
                arr << (ch.ord + k - 26).chr
            else
                arr << (ch.ord + k).chr
                
            end
        end
        m = arr.join
        m
    end
end
