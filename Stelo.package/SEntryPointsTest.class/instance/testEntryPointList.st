test
testEntryPointList
	| e ret |
	e := SEntryPoints new.
	self assert: e breedNoList isEmpty.
	e addEntryPoint: 5 forBreedNo: 7.
	e addEntryPoint: 2 forBreedNo: 2.
	e addEntryPoint: 1 forBreedNo: 7.
	ret := e entryPointList.
	self assert: ret isArray.
	self assert: ret size equals: 3.
	self assertCollection: ret first equals: #(2 2).
	self assertCollection: ret second equals: #(7 5).
	self assertCollection: ret third equals: #(7 1).