tests-private
testSetupNeighbor8
	| d |
	d := SDiffuser neighbor8.
	d rows: 5 cols: 6.
	d setupNeighbor8.
	self assertCollection: d privNeighbor equals: #(1 -1 -6 -5 -4 4 5 6).
	self assertCollection: d privCornerIndexes equals: #(1 2 3 4 6 7 8 9).