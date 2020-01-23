tests-accessing
testColorAtPointPut
	| ps |
	ps := SPatches new.
	ps create: 3.
	self assertCollection: ps colors asArray equals: #(0 0 0 0 0 0 0 0 0).
	ps colorAtPoint: 0 @ 0 put: 1.
	ps colorAtPoint: -1 @ -1 put: 2.
	ps colorAtPoint: 0 @ 1 put: 3.
	ps colorAtPoint: 1 @ 1 put: 4.
	self assertCollection: ps colors asArray equals: #(2 0 0 0 1 0 0 3 4).