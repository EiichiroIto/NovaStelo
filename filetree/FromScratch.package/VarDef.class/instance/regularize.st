accessing
regularize
	varNames := varNames copyWithoutAll: reservedVarNames.
	varNames := reservedVarNames , varNames.
	varNames := varNames asArray