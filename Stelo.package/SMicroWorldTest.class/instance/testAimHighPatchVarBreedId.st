tests-command
testAimHighPatchVarBreedId
	| w v ret |
	w := self newWorld.
	w createPatch: 5.
	w create: 3 turtles: 1.
	v := w patches addVariable: 'a'.
	"
	21 22 23 24 25
	16 17 18 19 20
	11 12 13 14 15
	 6  7  8  9 10
	 1  2  3  4  5
"
	w x: 3 at: 1 put: 0.
	w y: 3 at: 1 put: 0.
	w
		var: STurtleVarDef headingVarNo
		breed: 3
		at: 1
		put: 45.
	w
		var: v
		breed: 2
		at: 18
		put: 1.
	w
		var: v
		breed: 2
		at: 19
		put: 2.
	w
		var: v
		breed: 2
		at: 14
		put: 3.
	ret := w aimHighPatchVar: v breed: 3 id: 1.
	self assert: ret equals: -45.
	w
		var: v
		breed: 2
		at: 18
		put: 4.
	w
		var: v
		breed: 2
		at: 19
		put: 3.
	w
		var: v
		breed: 2
		at: 14
		put: 2.
	ret := w aimHighPatchVar: v breed: 3 id: 1.
	self assert: ret equals: 45.
	w
		var: v
		breed: 2
		at: 18
		put: 4.
	w
		var: v
		breed: 2
		at: 19
		put: 5.
	w
		var: v
		breed: 2
		at: 14
		put: 2.
	ret := w aimHighPatchVar: v breed: 3 id: 1.
	self assert: ret equals: 0.

	"
	21 22 23 24 25
	16 17 18 19 20
	11 12 13 14 15
	 6  7  8  9 10
	 1  2  3  4  5
"
	w
		var: STurtleVarDef headingVarNo
		breed: 3
		at: 1
		put: 90.
	w
		var: v
		breed: 2
		at: 16
		put: 1.
	w
		var: v
		breed: 2
		at: 17
		put: 1.
	w
		var: v
		breed: 2
		at: 18
		put: 2.
	w
		var: v
		breed: 2
		at: 19
		put: 3.
	w
		var: v
		breed: 2
		at: 20
		put: 3.
	ret := w aimHighPatchVar: v breed: 3 id: 1.
	self assert: ret equals: -45