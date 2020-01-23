tests-private
testIndexAtPoint
	| ps |
	ps := SPatches new.
	ps create: 5.
	self assert: ps cols equals: 5.
	self assert: ps rows equals: 5.
	self assert: (ps indexAtPoint: -2 @ -2) equals: 1.
	self assert: (ps indexAtPoint: -1.9 @ -2) equals: 1.
	self assert: (ps indexAtPoint: -1.1 @ -2) equals: 1.
	self assert: (ps indexAtPoint: -1 @ -2) equals: 2.
	self assert: (ps indexAtPoint: -0.9 @ -2) equals: 2.
	self assert: (ps indexAtPoint: -0.1 @ -2) equals: 2.
	self assert: (ps indexAtPoint: 0 @ -2) equals: 3.
	self assert: (ps indexAtPoint: 0.1 @ -2) equals: 3.
	self assert: (ps indexAtPoint: 0.9 @ -2) equals: 3.
	self assert: (ps indexAtPoint: 1 @ -2) equals: 4.
	self assert: (ps indexAtPoint: 2 @ -2) equals: 5.
	self assert: (ps indexAtPoint: 2.1 @ -2) equals: 5.
	self assert: (ps indexAtPoint: 2.9 @ -2) equals: 5.
	self assert: (ps indexAtPoint: -1 @ 1) equals: 17.
	self assert: (ps indexAtPoint: -0.9 @ 1) equals: 17.
	self assert: (ps indexAtPoint: 0 @ 0) equals: 13.
	self assert: (ps indexAtPoint: 0.1 @ 0) equals: 13.
	self assert: (ps indexAtPoint: 0.9 @ 0) equals: 13.
	self assert: (ps indexAtPoint: 2 @ 2) equals: 25.
	ps create: 6.
	self assert: ps cols equals: 6.
	self assert: ps rows equals: 6.
	self assert: (ps indexAtPoint: 0 @ 0) equals: 22.
	self assert: (ps indexAtPoint: -3 @ -3) equals: 1.
	self assert: (ps indexAtPoint: 2 @ 2) equals: 36.
	self assert: (ps indexAtPoint: -1 @ 1) equals: 27.
	ps create: 100.
	self assert: (ps indexAtPoint: -50 @ -50) equals: 1.
	self assert: (ps indexAtPoint: -49.5 @ -50) equals: 1.
	self assert: (ps indexAtPoint: -49 @ -50) equals: 2.