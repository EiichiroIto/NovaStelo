tests-accessing
testReservedVarNames
	self
		assertCollection: SObserverVarDef new privReservedVarNames
		equals: #(width height maxBreedNo ticks countAlive size maxVar)