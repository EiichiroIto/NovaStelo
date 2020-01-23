tests-initialization
testInitialize
	| d |
	d := SDiffuser2 new.
	self assert: d privOrder equals: 0.
	self assert: d privNeighborSize equals: 0.