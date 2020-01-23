test
testAtPut
	| l |
	l := LazyArray className: #FloatArray.
	self assert: l privArray isNil.
	l at: 1 put: 1.
	self assert: l privArray size equals: l defaultAllocationSize.
	self assert: (l at: 1) equals: 1.
	l at: 2 put: 2.
	l at: 3 put: 3.
	self assert: (l at: 1) equals: 1.
	self assert: (l at: 2) equals: 2.
	self assert: (l at: 3) equals: 3.
	l at: 103 put: 103.
	self assert: l privArray size equals: l defaultAllocationSize * 2.
	self assert: (l at: 1) equals: 1.
	self assert: (l at: 2) equals: 2.
	self assert: (l at: 3) equals: 3.
	self assert: (l at: 103) equals: 103.