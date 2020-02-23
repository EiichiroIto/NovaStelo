test
testSetArray
	| l a b |
	l := LazyArray className: #FloatArray.
	self assert: l privArray isNil.
	a := #(1 2 3) asFloatArray.
	b := #(4 5 6) asFloatArray.
	l privArray: a.
	self assertCollection: l privArray equals: a.
	l setArray: b.
	self assertCollection: l privArray equals: b.
	self should: [l setArray: #(4 5 6)] raise: Error.