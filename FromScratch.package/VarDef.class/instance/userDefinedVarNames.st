accessing
userDefinedVarNames
	^ self varNames
		reject: [ :each | each isNil or: [ reservedVarNames includes: each ] ]