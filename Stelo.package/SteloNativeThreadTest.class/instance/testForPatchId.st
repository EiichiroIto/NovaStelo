test
testForPatchId
	| e |
	e := self newThread.
	self assert: e privBreedId isNil.
	self assert: e privId isNil.
	e forPatchId: 123.
	self assert: e privBreedId equals: 2.
	self assert: e privId equals: 123.