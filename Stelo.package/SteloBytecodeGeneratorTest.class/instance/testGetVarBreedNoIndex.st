test
testGetVarBreedNoIndex
	| w b vid t ret |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 1.
	vid := (w breedOf: 3) addVariable: 'a'.
	w
		var: vid
		breed: 3
		at: 1
		put: 4.
	w
		var: vid
		breed: 3
		at: 2
		put: 5.
	b := self newGenerator.
	ret := b getVar: [ :x | vid ] breedNo: 3 index: 2.
	self assert: ret isNil.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 5