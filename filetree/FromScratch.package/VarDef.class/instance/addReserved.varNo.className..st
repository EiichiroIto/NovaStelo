private
addReserved: aString varNo: anInteger className: aSymbol
	varClasses at: aString put: aSymbol.
	reservedVarNames size < anInteger
		ifTrue: [ reservedVarNames := reservedVarNames
				forceTo: anInteger
				paddingWith: nil ].
	reservedVarNames at: anInteger put: aString.
	^ anInteger