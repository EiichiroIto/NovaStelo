tests-private
testIndexOfNormalXY
	| d |
	d := SDiffuser2 new.
	d privOrder: 4.
	self assert: (d indexOfNormalX: 0 y: 0) equals: 1.
	self assert: (d indexOfNormalX: 1 y: 0) equals: 2.
	self assert: (d indexOfNormalX: 2 y: 0) equals: 3.
	self assert: (d indexOfNormalX: 3 y: 0) equals: 4.
	self assert: (d indexOfNormalX: 0 y: 1) equals: 5.
	self assert: (d indexOfNormalX: 1 y: 1) equals: 6.
	self assert: (d indexOfNormalX: 2 y: 1) equals: 7.
	self assert: (d indexOfNormalX: 3 y: 1) equals: 8.
	self assert: (d indexOfNormalX: 0 y: 2) equals: 9.
	self assert: (d indexOfNormalX: 1 y: 2) equals: 10.
	self assert: (d indexOfNormalX: 2 y: 2) equals: 11.
	self assert: (d indexOfNormalX: 3 y: 2) equals: 12.
	self assert: (d indexOfNormalX: 0 y: 3) equals: 13.
	self assert: (d indexOfNormalX: 1 y: 3) equals: 14.
	self assert: (d indexOfNormalX: 2 y: 3) equals: 15.
	self assert: (d indexOfNormalX: 3 y: 3) equals: 16.