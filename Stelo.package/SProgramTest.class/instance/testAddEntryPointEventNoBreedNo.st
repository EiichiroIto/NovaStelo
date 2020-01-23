test
testAddEntryPointEventNoBreedNo
	| p |
	p := SProgram new.
	self assert: p eventNoList isEmpty.
	p addEntryPoint: 5 eventNo: 1 breedNo: 2.
	p addEntryPoint: 6 eventNo: 2 breedNo: 2.
	p addEntryPoint: 7 eventNo: 3 breedNo: 2.
	p addEntryPoint: 8 eventNo: 1 breedNo: 1.
	p addEntryPoint: 9 eventNo: 3 breedNo: 1.
	p addEntryPoint: 10 eventNo: 2 breedNo: 3.
	p addEntryPoint: 11 eventNo: 3 breedNo: 3.
	self assertCollection: p eventNoList equals: #(1 2 3).
	self assertCollection: ((p forEventNo: 1) forBreedNo: 1) asArray equals: #(8).
	self assertCollection: ((p forEventNo: 1) forBreedNo: 2) asArray equals: #(5).
	self assertCollection: ((p forEventNo: 1) forBreedNo: 3) asArray equals: #().
	self assertCollection: ((p forEventNo: 2) forBreedNo: 1) asArray equals: #().
	self assertCollection: ((p forEventNo: 2) forBreedNo: 2) asArray equals: #(6).
	self assertCollection: ((p forEventNo: 2) forBreedNo: 3) asArray equals: #(10).
	self assertCollection: ((p forEventNo: 3) forBreedNo: 1) asArray equals: #(9).
	self assertCollection: ((p forEventNo: 3) forBreedNo: 2) asArray equals: #(7).
	self assertCollection: ((p forEventNo: 3) forBreedNo: 3) asArray equals: #(11).