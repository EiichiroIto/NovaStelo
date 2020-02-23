test
testMultiplyBy
	| l |
	l := LazyArray className: #FloatArray.
	l at: 1 put: 10.
	l at: 2 put: 20.
	l at: 3 put: 30.
	self assert: (l at: 1) equals: 10.
	self assert: (l at: 2) equals: 20.
	self assert: (l at: 3) equals: 30.
	l multiplyBy: 2.
	self assert: (l at: 1) equals: 20.
	self assert: (l at: 2) equals: 40.
	self assert: (l at: 3) equals: 60