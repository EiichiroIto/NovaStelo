private
setupDiffuseOrder: anInteger1 neighborSize: anInteger2
	self allocateExtended: (anInteger1 + 2) * (anInteger1 + 2).
	order := anInteger1.
	self setupNeighbor.
	self clearExtended.
	neighborSize := anInteger2.