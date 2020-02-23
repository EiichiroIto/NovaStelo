accessing
defaultValue: anObject
	anObject isString
		ifTrue: [ self specialValue: anObject ]
		ifFalse: [ super defaultValue: anObject ]