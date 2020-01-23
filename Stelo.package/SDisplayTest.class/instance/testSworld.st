test
testSworld
	| d w |
	d := self newDisplay.
	self assert: (d sworld isKindOf: SWorld).
	w := self newWorld.
	d sworld: w.
	self assert: d sworld equals: w