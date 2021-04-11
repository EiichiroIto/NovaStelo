api
localVarAt: aString
	^ localVars ifNil: [ nil ] ifNotNil: [ localVars at: aString ]