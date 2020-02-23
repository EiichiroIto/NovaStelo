test
testDefaultAllocationSize
	| l |
	l := LazyArray basicNew.
	self assert: l defaultAllocationSize equals: 100.