test
testSetByteAllBreedFrom
	| w t arr r |
	w := SPluginWorld new.
	t := STurtles new breedNo: 3.
	t create: 50.
	w addBreed: t.
	arr := #(10 200 30 40 50 60 7 8 9 10) asByteArray.
	w setByteAll: STurtleVarDef colorVarNo breed: 3 from: arr.
	r := w var: STurtleVarDef colorVarNo breed: 3 at: 1.
	self assert: r equals: 10.