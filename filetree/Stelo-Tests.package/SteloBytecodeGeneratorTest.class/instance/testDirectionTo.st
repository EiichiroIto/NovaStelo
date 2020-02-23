test
testDirectionTo
	| w t b r pno |
	w := self newWorld.
	w createPatch: 5.
	w create: 3 turtles: 2.
	w x: 3 at: 2 put: 1.
	"1  2  3  4  5
	 6  7  8  9 10
	11 12 13 14 15
	16 17 18 19 20
	21 22 23 24 25"
	b := self newGenerator.
	pno := w patchIndexAtX: 2 y: 1.
	r := b directionTo: pno.
	self assert: r isNil.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	r := t evaluate: 1.
	self assert: r closeTo: 0.5 arcTan radiansToDegrees.
	t := self newThread: w.
	t forBreedNo: 3 index: 2.
	t codes: b code.
	r := t evaluate: 1.
	self assert: r closeTo: 1 arcTan radiansToDegrees.