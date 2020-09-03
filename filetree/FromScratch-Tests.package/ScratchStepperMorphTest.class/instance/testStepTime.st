test
testStepTime
	| s |
	s := self newMorph.
	self assert: s stepTime equals: s defaultStepTime.
	s stepTime: 123.
	self assert: s stepTime equals: 123