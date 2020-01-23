test
testGetVar
	| w t v |
	w := self newWorld.
	t := self newThread: w.
	w create: 3 turtles: 1.
	t forBreedNo: 3 index: 1.
	v := (w breedOf: 3) addVariable: 'b'.
	t push: v.
	t getVar.
	self assert: t pop equals: 0.
	w
		var: v
		breed: 3
		at: 1
		put: 10.
	t push: v.
	t getVar.
	self assert: t pop equals: 10