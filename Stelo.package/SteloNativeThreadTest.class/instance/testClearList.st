test
testClearList
	| w t v |
	w := self newWorld.
	w create: SBreedId turtleBreedNo turtles: 1.
	v := (w breedOf: SBreedId turtleBreedNo) addList: 'a'.
	w var: v breed: SBreedId turtleBreedNo list: 1 add: 10.
	w var: v breed: SBreedId turtleBreedNo list: 1 add: 20.
	w var: v breed: SBreedId turtleBreedNo list: 1 add: 30.
	t := self newThread: w.
	t forBreedNo: SBreedId turtleBreedNo index: 1.
	t push: v.
	t clearList.
	self assert: t stack size equals: 0.
	self assert: (w var: v breed: SBreedId turtleBreedNo list: 1) isEmpty