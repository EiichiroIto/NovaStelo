test
testGetByteAllBreed
	| w t arr |
	w := SPluginWorld new.
	t := STurtles new breedNo: 3.
	t create: 2.
	w addBreed: t.
	arr := w getByteAll: STurtleVarDef colorVarNo breed: 3.
	self assert: arr size equals: 100.
	self assert: arr first equals: (t colorAt: 1).
	self assert: arr second equals: (t colorAt: 2).
	self assert: arr third equals: (t colorAt: 3).