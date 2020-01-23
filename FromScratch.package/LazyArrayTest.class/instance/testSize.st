test
testSize
	| l a |
	l := LazyArray basicNew.
	self assert: l size equals: 0.
	a := FloatArray new: 5.
	a at: 2 put: 3.
	a at: 5 put: 9.
	l privArray: a.
	self assert: l size equals: 5.