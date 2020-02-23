accessing
defaultValue: anObject
	anObject isNumber
		ifTrue: [ ^ self numExpression: anObject ].
	anObject isString
		ifTrue: [ ^ self stringExpression: anObject ]