private
sampleProgram3
	| program |
	program := SProgram new.
	program addCode: #(#pushShort 10 0 #pushShort 20 0 #stop).
	program addEntryPoint: 1 eventNo: 4 breedNo: 3.
	^ program