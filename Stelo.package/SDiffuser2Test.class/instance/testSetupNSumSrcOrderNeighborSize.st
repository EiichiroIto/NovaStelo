tests-private
testSetupNSumSrcOrderNeighborSize
	| d |
	d := SDiffuser2 new.
	d
		setupNSumSrc: #(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16) asFloatArray
		order: 4
		neighborSize: 4.
	self assert: d privNeighborSize equals: 4.
	self assert: d privOrder equals: 4.
	self
		assertCollection: d privExtended
		equals:
			#(16 13 14 15 16 13 4 1 2 3 4 1 8 5 6 7 8 5 12 9 10 11 12 9 16 13 14 15 16 13 4 1 2 3 4 1)
				asFloatArray.