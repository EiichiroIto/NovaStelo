test
testPrivArray
	| l a b |
	l := LazyArray basicNew.
	self assert: l privArray isNil.
	a := #(1 2 3).
	b := #(4 5 6).
	l privArray: a.
	self assertCollection: l privArray equals: a.
	l privArray: b.
	self assertCollection: l privArray equals: b.