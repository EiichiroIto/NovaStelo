accessing
realVarNames
	^ self varNames
		withIndexSelect: [ :each :index | (self classNameForVarNo: index) notNil ]