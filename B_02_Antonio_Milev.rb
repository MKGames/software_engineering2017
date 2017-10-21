require "csv"
require "date"

arr = CSV.read(ARGV[0])
len = arr.drop(1).length
counter = 0
results = []
#deadline = Date.parse('2017-10-10')

arr.drop(1).each do |n|
	Thread.new do
		if(n[1] != "" && n[2] != "" && n[3] != "" && n[4] != "" && n[5] != "" && n[6] != "" && n[1] != nil && n[2] != nil && n[3] != nil && n[4] != nil && n[5] != nil && n[6] != nil)
			#date = Date.parse(n[0].split(' ')[0])

			sum = `curl -s --form "file=@./B_21_Roberta_Netzova.csv" #{n[5]}/sums`.to_s
			filter = `curl -s --form "file=@./B_21_Roberta_Netzova.csv" #{n[5]}/filters`.to_s
			interval = `curl -s --form "file=@./B_21_Roberta_Netzova.csv" #{n[5]}/intervals`.to_s
			lin_regression = `curl -s --form "file=@./B_21_Roberta_Netzova.csv" #{n[5]}/lin_regressions`.to_s
		

			if(sum == "126.00" && filter == "40.00" && interval == "118.00" && lin_regression == "0.014006,3.347899")
				results.push("#{n[1]},#{n[2]},#{n[3]},#{n[4]},1")
			else
				results.push("#{n[1]},#{n[2]},#{n[3]},#{n[4]},0")
			end

			counter += 1

			if counter == len
				open("B_02_Antonio_Milev_results.csv", "w") { |f|
					results.each do |r|
						f.puts("#{r}")
					end
				}
				exit
			end
		else
			len -= 1
		end
	end
end
sleep
