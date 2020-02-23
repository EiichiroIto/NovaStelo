test
testAt
	| a |
	a := self newArray: #FloatArray.
	self assert: (a at: 1) equals: 0.
	a at: 2 put: 3.
	a at: 5 put: 9.
	self assert: (a at: 1) equals: 0.0.
	self assert: (a at: 2) equals: 3.0.
	self assert: (a at: 3) equals: 0.0.
	self assert: (a at: 4) equals: 0.0.
	self assert: (a at: 5) equals: 9.0.
	self assert: (a at: 6) equals: 0.0.