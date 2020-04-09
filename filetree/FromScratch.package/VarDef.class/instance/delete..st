accessing
delete: aString
	(self includes: aString)
		ifFalse: [ self error: 'cannot delete not existing var' ].
	(self isReserved: aString)
		ifTrue: [ self error: 'cannot delete reserved var' ].
	varNames := varNames copyWithout: aString.
	varClasses removeKey: aString