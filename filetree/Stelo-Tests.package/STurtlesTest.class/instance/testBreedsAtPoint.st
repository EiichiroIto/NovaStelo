tests-command
testBreedsAtPoint
	| ts list |
	ts := STurtles new breedNo: SBreedId turtleBreedNo.
	ts create: 5.
	list := ts breedsAtPoint: 0 @ 0.
	self assertCollection: list asArray equals: #(1 2 3 4 5).
	ts killAt: 3.
	list := ts breedsAtPoint: 0 @ 0.
	self assertCollection: list asArray equals: #(1 2 4 5).
	ts xAt: 2 put: 1.
	list := ts breedsAtPoint: 0 @ 0.
	self assertCollection: list asArray equals: #(1 4 5).
	ts yAt: 1 put: 1.
	list := ts breedsAtPoint: 0 @ 0.
	self assertCollection: list asArray equals: #(4 5)