private
setupNSumSrc: anArray1 order: anInteger1 neighborSize: anInteger2
	| sz |
	sz := (anInteger1 + 2) * (anInteger1 + 2).
	self allocateExtended: sz.
	order := anInteger1.
	self setupNeighbor.
	self setupExtended: anArray1.
	self setupBorder.
	neighborSize := anInteger2.