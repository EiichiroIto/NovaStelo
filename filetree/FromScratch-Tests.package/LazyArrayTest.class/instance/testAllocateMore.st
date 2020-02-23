test
testAllocateMore
	| l |
	l := LazyArray className: #FloatArray.
	l allocateMore: 10.
	self assert: (l privArray isKindOf: FloatArray).
	self assert: l privArray size equals: l defaultAllocationSize.
	l allocateMore: 10.
	self assert: (l privArray isKindOf: FloatArray).
	self assert: l privArray size equals: l defaultAllocationSize * 2.