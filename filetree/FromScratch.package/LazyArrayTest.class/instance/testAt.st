test
testAt
	| l a |
	l := LazyArray basicNew.
	self assert: (l at: 1) equals: 0.
	a := FloatArray new: 5.
	a at: 2 put: 3.
	a at: 5 put: 9.
	l privArray: a.
	self assert: (l at: 1) equals: 0.0.
	self assert: (l at: 2) equals: 3.0.
	self assert: (l at: 3) equals: 0.0.
	self assert: (l at: 4) equals: 0.0.
	self assert: (l at: 5) equals: 9.0.
	self assert: (l at: 6) equals: 0.0.