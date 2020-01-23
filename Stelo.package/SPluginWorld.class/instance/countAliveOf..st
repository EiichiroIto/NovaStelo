accessing
countAliveOf: bno
	^ (plugin
		getFloat: SObserverVarDef countAliveVarNo
		breed: SBreedId observerBreedNo
		id: bno) truncated