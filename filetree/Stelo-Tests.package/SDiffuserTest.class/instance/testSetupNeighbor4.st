tests-private
testSetupNeighbor4
	| d |
	d := SDiffuser neighbor4.
	d rows: 5 cols: 6.
	d setupNeighbor4.
	self assertCollection: d privNeighbor equals: #(1 -1 -5 5).
	self assertCollection: d privCornerIndexes equals: #(2 4 6 8).