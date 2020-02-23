tests-private
testSetupNeighbor
	| d |
	d := SDiffuser2 new.
	self assert: d privNeighbor isNil.
	d privOrder: 4.
	d setupNeighbor.
	self assert: d privNeighbor isArray.
	self assert: d privNeighbor size equals: 8.
	self assertCollection: d privNeighbor equals: #(1 -1 6 -6 5 7 -5 -7).