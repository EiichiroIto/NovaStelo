private
getRows
	^ (plugin
		getFloat: SObserverVarDef heightVarNo
		breed: SBreedId observerBreedNo
		id: 1) truncated