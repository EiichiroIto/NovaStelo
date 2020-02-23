tests-private
testPrivNeighbor
	| d |
	d := SDiffuser2 new.
	self assert: d privNeighbor isNil.
	d privNeighbor: #(1 2 3).
	self assertCollection: d privNeighbor equals: #(1 2 3).