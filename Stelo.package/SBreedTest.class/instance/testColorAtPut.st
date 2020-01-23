tests-accessing
testColorAtPut
	| ps |
	ps := SPatches new.
	ps create: 3.
	self assertCollection: ps colors equals: #[0 0 0 0 0 0 0 0 0].
	ps colorAt: 1 put: 1.
	ps colorAt: 2 put: 30.
	ps colorAt: 9 put: 41.
	self assertCollection: ps colors equals: #[1 30 0 0 0 0 0 0 41]