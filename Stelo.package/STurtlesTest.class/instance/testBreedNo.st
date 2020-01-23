tests-accessing
testBreedNo
	| ts |
	ts := STurtles new.
	self assert: ts breedNo isNil.
	ts breedNo: 3.
	self assert: ts breedNo equals: 3.
	ts breedNo: 4.
	self assert: ts breedNo equals: 4.