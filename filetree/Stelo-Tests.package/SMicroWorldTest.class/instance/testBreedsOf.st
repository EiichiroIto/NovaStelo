tests-accessing
testBreedsOf
	| w |
	w := SMicroWorld new.
	w addBreed: (STurtles new breedNo: 3).
	self assert: (w breedOf: 3) class equals: STurtles.