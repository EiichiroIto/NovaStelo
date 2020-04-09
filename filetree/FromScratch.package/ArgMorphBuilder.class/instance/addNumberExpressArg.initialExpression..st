accessing
addNumberExpressArg: aCharacter initialExpression: aString
	self add: aCharacter builder: [ ExpressionArgMorph new numExpression: aString ]