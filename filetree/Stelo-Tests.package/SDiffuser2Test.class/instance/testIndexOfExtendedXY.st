tests-private
testIndexOfExtendedXY
	| d |
	d := SDiffuser2 new.
	d privOrder: 4.
	self assert: (d indexOfExtendedX: -1 y: -1) equals: 1.
	self assert: (d indexOfExtendedX: 0 y: -1) equals: 2.
	self assert: (d indexOfExtendedX: 1 y: -1) equals: 3.
	self assert: (d indexOfExtendedX: 2 y: -1) equals: 4.
	self assert: (d indexOfExtendedX: 3 y: -1) equals: 5.
	self assert: (d indexOfExtendedX: 4 y: -1) equals: 6.
	self assert: (d indexOfExtendedX: -1 y: 0) equals: 7.
	self assert: (d indexOfExtendedX: 0 y: 0) equals: 8.
	self assert: (d indexOfExtendedX: 1 y: 0) equals: 9.
	self assert: (d indexOfExtendedX: 2 y: 0) equals: 10.
	self assert: (d indexOfExtendedX: 3 y: 0) equals: 11.
	self assert: (d indexOfExtendedX: 4 y: 0) equals: 12.
	self assert: (d indexOfExtendedX: 5 y: 0) equals: 13.
	self assert: (d indexOfExtendedX: 0 y: 1) equals: 14.
	self assert: (d indexOfExtendedX: -1 y: 3) equals: 25.
	self assert: (d indexOfExtendedX: 0 y: 3) equals: 26.
	self assert: (d indexOfExtendedX: 1 y: 3) equals: 27.
	self assert: (d indexOfExtendedX: 2 y: 3) equals: 28.
	self assert: (d indexOfExtendedX: 3 y: 3) equals: 29.
	self assert: (d indexOfExtendedX: 4 y: 3) equals: 30.
	self assert: (d indexOfExtendedX: -1 y: 4) equals: 31.
	self assert: (d indexOfExtendedX: 0 y: 4) equals: 32.
	self assert: (d indexOfExtendedX: 1 y: 4) equals: 33.
	self assert: (d indexOfExtendedX: 2 y: 4) equals: 34.
	self assert: (d indexOfExtendedX: 3 y: 4) equals: 35.
	self assert: (d indexOfExtendedX: 4 y: 4) equals: 36.
