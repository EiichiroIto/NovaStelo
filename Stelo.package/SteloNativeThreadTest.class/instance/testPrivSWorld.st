test
testPrivSWorld
	| w1 w2 e |
	w1 := self newWorld.
	e := self newThread: w1.
	self assert: e privSWorld equals: w1.
	w2 := self newWorld.
	e privSWorld: w2.
	self assert: e privSWorld equals: w2.