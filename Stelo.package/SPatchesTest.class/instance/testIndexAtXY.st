tests-accessing
testIndexAtXY
	| ps |
	ps := SPatches new.
	ps create: 5.
	self assert: ps cols equals: 5.
	self assert: ps rows equals: 5.
	self assert: (ps indexAtX: -2 y: -2) equals: 1.
	self assert: (ps indexAtX: -1 y: -2) equals: 2.
	self assert: (ps indexAtX: 0 y: -2) equals: 3.
	self assert: (ps indexAtX: 1 y: -2) equals: 4.
	self assert: (ps indexAtX: 2 y: -2) equals: 5.
	self assert: (ps indexAtX: -3 y: -2) equals: 5.
	self assert: (ps indexAtX: -2 y: -1) equals: 6.
	self assert: (ps indexAtX: -2 y: 0) equals: 11.
	self assert: (ps indexAtX: -2 y: 1) equals: 16.
	self assert: (ps indexAtX: -2 y: 2) equals: 21.
	self assert: (ps indexAtX: -2 y: -3) equals: 21.