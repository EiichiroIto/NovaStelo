test
testPrintOn
	| p w |
	p := SEntryPoints new.
	p addEntryPoint: 5 forBreedNo: 1.
	p addEntryPoint: 6 forBreedNo: 2.
	p addEntryPoint: 7 forBreedNo: 3.
	p addEntryPoint: 8 forBreedNo: 1.
	p addEntryPoint: 9 forBreedNo: 3.
	w := WriteStream on: String new.
	p printOn: w.
	self assert: w contents equals: '(1->(5 8) 2->(6) 3->(7 9))'