tests-accessing
testPatches
	| w |
	w := self newWorld.
	self assert: w patches class equals: SPatches.