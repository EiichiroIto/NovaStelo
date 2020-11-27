accessing
addNumberExpressArg: aCharacter selector: aSymbol target: anObject
	self
		add: aCharacter
		builder: [ ExpressionArgMorphWithMenu new
				numExpression: (anObject perform: aSymbol) first second asString;
				getOptionsSelector: aSymbol;
				getOptionsTarget: anObject ]