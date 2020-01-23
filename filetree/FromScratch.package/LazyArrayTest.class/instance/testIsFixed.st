test
testIsFixed
	| l |
	l := LazyArray className: #FloatArray.
	self deny: l isFixed.
	l at: 20 put: 1.
	self deny: l isFixed.
	l forceSize: 10.
	self assert: l isFixed.
	l reset.
	self assert: l isFixed.