arg generator
literalStringFrom: anObject
	anObject isString
		ifTrue: [ ^ (SexpLexer quotedString: anObject) ].
	anObject isNumber
		ifTrue: [ ^ anObject ].
	self error.