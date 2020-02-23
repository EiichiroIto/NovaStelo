test
testBreedNoList
	| e |
	e := SEntryPoints new.
	self assert: e breedNoList isEmpty.
	e addEntryPoint: 1 forBreedNo: 7.
	e addEntryPoint: 2 forBreedNo: 2.
	e addEntryPoint: 1 forBreedNo: 7.
	self assertCollection: e breedNoList sort equals: #(2 7).