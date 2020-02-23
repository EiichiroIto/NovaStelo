tests-accessing
testMaxBreedNo
	| w |
	w := self newWorld.
	self assert: w maxBreedNo equals: 3.
	5 timesRepeat: [ w newBreed ].
	self assert: w maxBreedNo equals: 8