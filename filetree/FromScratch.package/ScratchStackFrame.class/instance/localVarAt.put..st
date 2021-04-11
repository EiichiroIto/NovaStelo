api
localVarAt: aString put: anObject
	localVars ifNil: [ localVars := Dictionary new ].
	localVars at: aString put: anObject