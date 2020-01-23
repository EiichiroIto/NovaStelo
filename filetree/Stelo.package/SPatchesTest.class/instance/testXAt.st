tests-accessing
testXAt
	| ps |
	ps := SPatches new.
"
	 1  2  3  4   -2 -1 0 1
	 5  6  7  8
	 9 10 11 12
	13 14 15 16
"
	ps create: 4.
	self assert: (ps xAt: 1) equals: -2.
	self assert: (ps xAt: 2) equals: -1.
	self assert: (ps xAt: 3) equals: 0.
	self assert: (ps xAt: 4) equals: 1.
	self assert: (ps xAt: 5) equals: -2.
	self assert: (ps xAt: 6) equals: -1.
	self assert: (ps xAt: 7) equals: 0.
	self assert: (ps xAt: 8) equals: 1.
	self assert: (ps xAt: 9) equals: -2.
	self assert: (ps xAt: 10) equals: -1.
	self assert: (ps xAt: 11) equals: 0.
	self assert: (ps xAt: 12) equals: 1.
	self assert: (ps xAt: 13) equals: -2.
	self assert: (ps xAt: 14) equals: -1.
	self assert: (ps xAt: 15) equals: 0.
	self assert: (ps xAt: 16) equals: 1.

"
   1  2  3  4  5   -2 -1 0 1 2
   6  7  8  9 10
  11 12 13 14 15
  16 17 18 19 20
  21 22 23 24 25
"
	ps create: 5.
	self assert: (ps xAt: 1) equals: -2.
	self assert: (ps xAt: 2) equals: -1.
	self assert: (ps xAt: 3) equals: 0.
	self assert: (ps xAt: 4) equals: 1.
	self assert: (ps xAt: 5) equals: 2.
	self assert: (ps xAt: 21) equals: -2.
	self assert: (ps xAt: 22) equals: -1.
	self assert: (ps xAt: 23) equals: 0.
	self assert: (ps xAt: 24) equals: 1.
	self assert: (ps xAt: 25) equals: 2.