test
testSetFloatAllBreedExtArraySize
	| c ext x |
	c := SteloLibCall new.
	c setupBreed: 3.
	c create: 3 turtles: 3.
	ext := FFIExternalArray externalNewType: 'float' size: 3.
	ext at: 1 put: 1.5.
	ext at: 2 put: 2.6.
	ext at: 3 put: 3.7.
	[ 	c setFloatAll: STurtleVarDef xVarNo breed: 3 extArray: ext size: 3 ]
	ensure: [ ext release ].
	x := c getFloat: STurtleVarDef xVarNo breed: 3 id: 1.
	self assert: x closeTo: 1.5.
	x := c getFloat: STurtleVarDef xVarNo breed: 3 id: 2.
	self assert: x closeTo: 2.6.
	x := c getFloat: STurtleVarDef xVarNo breed: 3 id: 3.
	self assert: x closeTo: 3.7.