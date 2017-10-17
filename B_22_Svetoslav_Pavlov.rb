require "csv"
csvget = ARGV[0]
	answ=1
	#za vseki red, obikalqi znachi CSV.
		CSV.foreach(csvget) do |row|
			answ=0
			url = row[5]
			#vuv failut koito ste kachili, petata kolona e heroku i url vzima stoinostta na heroku linka.
		#r1-4 - vrushtat stoinosti sled podadeni curl zaqvki. Kato se podadat v url adresa i to se namira zadachata
		puts"Current: #{url} #{row[3]} #{row[4]} \n"
			#na vsqka ot zadachite ot domashnoto vzimame answer koito da sochi s curl zaqvka
	answ1 = `curl -F \"file=@./B_22_Svetoslav_Pavlov.csv\" #{url}/sums`
	answ2 = `curl -F \"file=@./B_22_Svetoslav_Pavlov.csv\" #{url}/lin_regressions`
	answ3 = `curl -F \"file=@./B_22_Svetoslav_Pavlov.csv\" #{url}/filters`
	answ4 = `curl -F \"file=@./B_22_Svetoslav_Pavlov.csv\" #{url}/intervals`
	
	if answ1 == "90.00" && answ2 == "0.003953,1.909091" && answ3 == "150.00" && answ4 == "60.00"
		#proverqvame otgovorite na zadachite s inputa ot CSV-to
		answ=1
	else 
	answ=0
end
	puts answ
end
