accessing
idOf: aString
	self assert: aString isString.
	^ self invLiterals
		at: aString
		ifAbsentPut: [ | id |
			literals := literals grownBy: 1.
			id := literals size.
			literals at: id put: aString.
			id ]