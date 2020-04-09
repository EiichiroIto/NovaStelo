accessing
addNumberExpressArg: aCharacter selector: aSymbol target: anObject initialExpression: aString
	self
		add: aCharacter
		builder: [ ExpressionArgMorphWithMenu new
				numExpression: aString;
				getOptionsSelector: aSymbol;
				getOptionsTarget: anObject ]