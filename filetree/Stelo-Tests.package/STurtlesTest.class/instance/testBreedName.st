tests-accessing
testBreedName
	| ts |
	ts := STurtles new.
	ts breedNo: 5.
	self assert: ts breedName equals: 'Turtle5'.
	ts breedNo: 3.
	self assert: ts breedName equals: 'Turtle3'.