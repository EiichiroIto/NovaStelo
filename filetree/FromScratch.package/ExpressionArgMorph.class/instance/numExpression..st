accessing
numExpression: aNumber
	isNumber := true.
	labelMorph isNumeric: true.
	labelMorph
		contents:
			(aNumber isFloat
				ifTrue: [ aNumber printString ]
				ifFalse: [ aNumber asString ]).
	self fixArgLayout