test
testForceSize
	| l |
	l := LazyArray className: #FloatArray.
	self assert: l size equals: 0.
	l at: 20 put: 1.
	self assert: l size equals: l defaultAllocationSize.
	l forceSize: 10.
	self assert: l size equals: 10.
	l forceSize: 20.
	self assert: l size equals: 20.
	l reset.
	self should: [ l at: 30 put: 1 ] raise: Error.