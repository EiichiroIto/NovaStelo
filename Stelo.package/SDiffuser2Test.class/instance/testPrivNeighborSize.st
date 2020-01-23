tests-private
testPrivNeighborSize
	| d |
	d := SDiffuser2 new.
	self assert: d privNeighborSize equals: 0.
	d privNeighborSize: 123.
	self assertCollection: d privNeighborSize equals: 123.