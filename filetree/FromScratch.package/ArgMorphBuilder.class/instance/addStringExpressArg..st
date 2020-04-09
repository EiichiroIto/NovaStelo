accessing
addStringExpressArg: aCharacter
	self add: aCharacter builder: [ ExpressionArgMorph new stringExpression: '' ]