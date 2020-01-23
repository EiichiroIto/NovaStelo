private
addReserved: aString varNo: anInteger className: aSymbol
	classNames at: anInteger put: aSymbol.
	reservedVarNames size < anInteger
		ifTrue: [ reservedVarNames := reservedVarNames
				forceTo: anInteger
				paddingWith: nil ].
	reservedVarNames at: anInteger put: aString.
	^ anInteger