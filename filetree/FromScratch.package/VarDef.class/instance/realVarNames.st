accessing
realVarNames
	^ self varNames select: [ :each | (self classNameFor: each) notNil ]