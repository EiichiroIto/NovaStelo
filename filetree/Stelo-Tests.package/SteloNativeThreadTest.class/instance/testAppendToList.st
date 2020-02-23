test
testAppendToList
	| w t v |
	w := self newWorld.
	t := self newThread: w.
	w create: SBreedId turtleBreedNo turtles: 1.
	t forBreedNo: SBreedId turtleBreedNo index: 1.
	v := (w breedOf: SBreedId turtleBreedNo) addList: 'a'.
	t push: v.
	t push: 123.
	t appendToList.
	t push: v.
	t push: 456.
	t appendToList.
	self assert: (w var: v breed: SBreedId turtleBreedNo list: 1 at: 1) equals: 123.
	self assert: (w var: v breed: SBreedId turtleBreedNo list: 1 at: 2) equals: 456.
	self assert: t stack size equals: 0.