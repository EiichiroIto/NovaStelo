private
getCols
	^ (plugin
		getFloat: SObserverVarDef widthVarNo
		breed: SBreedId observerBreedNo
		id: 1) truncated