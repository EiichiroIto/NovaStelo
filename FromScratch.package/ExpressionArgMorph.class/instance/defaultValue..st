accessing
defaultValue: anObject

	anObject isNumber ifTrue: [self numExpression: anObject].
	(anObject isKindOf: String) ifTrue: [self stringExpression: anObject].
