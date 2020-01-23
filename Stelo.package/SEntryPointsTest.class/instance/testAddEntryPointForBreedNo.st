test
testAddEntryPointForBreedNo
	| p |
	p := SEntryPoints new.
	p addEntryPoint: 5 forBreedNo: 1.
	p addEntryPoint: 6 forBreedNo: 2.
	p addEntryPoint: 7 forBreedNo: 3.
	p addEntryPoint: 8 forBreedNo: 1.
	p addEntryPoint: 9 forBreedNo: 3.
	self assertCollection: p breedNoList equals: #(1 2 3).
	self assertCollection: (p forBreedNo: 1) asArray equals: #(5 8).
	self assertCollection: (p forBreedNo: 2) asArray equals: #(6).
	self assertCollection: (p forBreedNo: 3) asArray equals: #(7 9).