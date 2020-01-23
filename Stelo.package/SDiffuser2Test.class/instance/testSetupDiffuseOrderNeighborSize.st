tests-private
testSetupDiffuseOrderNeighborSize
	| d |
	d := SDiffuser2 new.
	d setupDiffuseOrder: 4 neighborSize: 4.
	self assert: d privNeighborSize equals: 4.
	self assert: d privOrder equals: 4.
	self assert: (d privExtended allSatisfy: [ :each | each = 0 ]).