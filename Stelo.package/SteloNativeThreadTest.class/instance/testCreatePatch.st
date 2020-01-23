test
testCreatePatch
	| w e |
	w := self newWorld.
	e := self newThread: w.
	self assert: w patches rows equals: 100.
	self assert: w patches cols equals: 100.
	self assert: e stack size equals: 0.
	e push: 20.
	e createPatch.
	self assert: e stack size equals: 0.
	self assert: w patches rows equals: 20.
	self assert: w patches cols equals: 20.