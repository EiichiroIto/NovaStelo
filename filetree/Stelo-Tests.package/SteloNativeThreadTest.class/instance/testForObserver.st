test
testForObserver
	| e |
	e := self newThread.
	self assert: e privBreedId isNil.
	self assert: e privId isNil.
	e forObserver.
	self assert: e privBreedId equals: SBreedId observerBreedNo.
	self assert: e privId equals: 1.