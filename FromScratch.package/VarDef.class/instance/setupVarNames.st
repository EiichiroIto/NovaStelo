private
setupVarNames
	varNames ifNotNil: [ ^ self ].
	reservedVarNames
		do: [ :each | each ifNil: [ self error: 'reservedVarNames has nil' ] ].
	varNames := reservedVarNames copy