test
testEntryPointList
	| p ret |
	p := SProgram new.
	self assert: p entryPointList isEmpty.
	p addEntryPoint: 5 eventNo: 1 breedNo: 2.
	p addEntryPoint: 6 eventNo: 2 breedNo: 2.
	p addEntryPoint: 7 eventNo: 3 breedNo: 2.
	p addEntryPoint: 8 eventNo: 1 breedNo: 1.
	p addEntryPoint: 9 eventNo: 3 breedNo: 1.
	p addEntryPoint: 10 eventNo: 2 breedNo: 3.
	p addEntryPoint: 11 eventNo: 3 breedNo: 3.
	ret := p entryPointList.
	self assert: ret isArray.
	self assert: ret size equals: 7.
	self assertCollection: ret first equals: #(1 1 8).
	self assertCollection: ret second equals: #(1 2 5).
	self assertCollection: ret third equals: #(2 2 6).
	self assertCollection: ret fourth equals: #(2 3 10).
	self assertCollection: ret fifth equals: #(3 1 9).
	self assertCollection: ret sixth equals: #(3 2 7).
	self assertCollection: ret seventh equals: #(3 3 11)