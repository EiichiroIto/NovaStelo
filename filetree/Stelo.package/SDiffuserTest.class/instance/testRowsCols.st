tests-accessing
testRowsCols
	| d |
	d := SDiffuser neighbor4.
	self assert: d privRows isNil.
	self assert: d privCols isNil.
	d rows: 3 cols: 4.
	self assert: d privRows equals: 3.
	self assert: d privCols equals: 4.