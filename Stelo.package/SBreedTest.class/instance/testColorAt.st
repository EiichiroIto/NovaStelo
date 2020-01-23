tests-accessing
testColorAt
	| ps |
	ps := SPatches new.
	ps create: 3.
	(ps privVariables varAt: 1) setArray: #[0 1 0 2 0 3 0 0 0].
	self assert: (ps colorAt: 1) equals: 0.
	self assert: (ps colorAt: 2) equals: 1.
	self assert: (ps colorAt: 3) equals: 0.
	self assert: (ps colorAt: 4) equals: 2.