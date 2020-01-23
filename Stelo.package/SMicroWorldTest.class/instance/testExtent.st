tests-accessing
testExtent
	| w |
	w := self newWorld.
	w createPatch: 10.
	self assert: w extent equals: 10 @ 10.
	w createPatch: 20.
	self assert: w extent equals: 20 @ 20.