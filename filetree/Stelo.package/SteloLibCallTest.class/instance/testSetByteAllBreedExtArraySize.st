test
testSetByteAllBreedExtArraySize
	| c ext x |
	c := SteloLibCall new.
	c setupBreed: 3.
	c create: 3 turtles: 3.
	ext := FFIExternalArray externalNewType: 'byte' size: 3.
	ext at: 1 put: 10.
	ext at: 2 put: 20.
	ext at: 3 put: 30.
	[ 	c setByteAll: STurtleVarDef colorVarNo breed: 3 extArray: ext size: 3 ]
	ensure: [ ext release ].
	x := c getByte: STurtleVarDef colorVarNo breed: 3 id: 1.
	self assert: x equals: 10.
	x := c getByte: STurtleVarDef colorVarNo breed: 3 id: 2.
	self assert: x equals: 20.
	x := c getByte: STurtleVarDef colorVarNo breed: 3 id: 3.
	self assert: x equals: 30.