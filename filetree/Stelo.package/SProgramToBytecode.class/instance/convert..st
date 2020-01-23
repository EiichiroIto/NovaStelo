private
convert: aProgram
	aProgram eventNoList
		do: [ :each | self convert: (aProgram forEventNo: each) eventNo: each ]