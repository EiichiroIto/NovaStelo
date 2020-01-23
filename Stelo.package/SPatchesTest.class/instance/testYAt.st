tests-accessing
testYAt
	| ps |
	ps := SPatches new.
"
	 1  2  3  4   -2
	 5  6  7  8   -1
	 9 10 11 12    0
	13 14 15 16    1
"
	ps create: 4.
	self assert: (ps yAt: 1) equals: -2.
	self assert: (ps yAt: 2) equals: -2.
	self assert: (ps yAt: 3) equals: -2.
	self assert: (ps yAt: 4) equals: -2.
	self assert: (ps yAt: 5) equals: -1.
	self assert: (ps yAt: 6) equals: -1.
	self assert: (ps yAt: 7) equals: -1.
	self assert: (ps yAt: 8) equals: -1.
	self assert: (ps yAt: 9) equals: 0.
	self assert: (ps yAt: 10) equals: 0.
	self assert: (ps yAt: 11) equals: 0.
	self assert: (ps yAt: 12) equals: 0.
	self assert: (ps yAt: 13) equals: 1.
	self assert: (ps yAt: 14) equals: 1.
	self assert: (ps yAt: 15) equals: 1.
	self assert: (ps yAt: 16) equals: 1.
"
   1  2  3  4  5   -2
   6  7  8  9 10   -1
  11 12 13 14 15    0
  16 17 18 19 20    1
  21 22 23 24 25    2
"
	ps create: 5.
	self assert: (ps yAt: 1) equals: -2.
	self assert: (ps yAt: 6) equals: -1.
	self assert: (ps yAt: 11) equals: 0.
	self assert: (ps yAt: 16) equals: 1.
	self assert: (ps yAt: 21) equals: 2.
	self assert: (ps yAt: 5) equals: -2.
	self assert: (ps yAt: 10) equals: -1.
	self assert: (ps yAt: 15) equals: 0.
	self assert: (ps yAt: 20) equals: 1.
	self assert: (ps yAt: 25) equals: 2.