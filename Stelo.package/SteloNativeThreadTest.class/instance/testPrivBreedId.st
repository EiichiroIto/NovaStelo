test
testPrivBreedId
	| e |
	e := self newThread.
	self assert: e privBreedId isNil.
	e privBreedId: 10.
	self assert: e privBreedId equals: 10.
	e privBreedId: 20.
	self assert: e privBreedId equals: 20.