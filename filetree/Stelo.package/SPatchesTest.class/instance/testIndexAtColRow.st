tests-private
testIndexAtColRow
	| ps |
	ps := SPatches new.
	self assert: ps cols equals: 100.
	self assert: (ps indexAtCol: 1 row: 1) equals: 1.
	self assert: (ps indexAtCol: 1 row: 2) equals: 101.
	self assert: (ps indexAtCol: 100 row: 1) equals: 100.
	self assert: (ps indexAtCol: 2 row: 1) equals: 2.
	self assert: (ps indexAtCol: 100 row: 100) equals: 10000.