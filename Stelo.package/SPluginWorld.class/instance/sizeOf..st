accessing
sizeOf: bno
	^ (plugin
		getFloat: SObserverVarDef sizeVarNo
		breed: SBreedId observerBreedNo
		id: bno) truncated