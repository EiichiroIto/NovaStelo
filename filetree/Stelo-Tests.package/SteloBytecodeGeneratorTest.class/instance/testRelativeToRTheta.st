test
testRelativeToRTheta
	| w b t |
	w := self newWorld.
	w createPatch: 5.
	w create: 3 turtles: 1.

" 1  2  3  4  5
  6  7  8  9 10
 11 12 13 14 15
 16 17 18 19 20
 21 22 23 24 25
"

	b := self newGenerator.
	b relativeToR: 1 theta: 0.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 14.

	b := self newGenerator.
	b relativeToR: 1 theta: 90.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 18.

	b := self newGenerator.
	b relativeToR: 1 theta: 180.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 12.

	b := self newGenerator.
	b relativeToR: 1 theta: 270.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 8.

	b := self newGenerator.
	b relativeToR: 2 theta: 0.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 15.