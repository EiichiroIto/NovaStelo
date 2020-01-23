private
add: aString className: aSymbol
	| id |
	self setupVarNames.
	id := (self includes: aString)
		ifTrue: [ self varNoFor: aString ]
		ifFalse: [ varNames := varNames copyWith: aString.
			varNames size ].
	classNames at: id put: aSymbol.
	^ id